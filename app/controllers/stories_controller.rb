class StoriesController < ApplicationController
  def index
    @stories = Story.populate_index_with(params).
      includes(:user, :additions).page(params[:page])
      # still an n+1 query here
  end

  def new
    authorize_user!
    @story = Story.new
  end

  def create
    authorize_user!
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      flash[:notice] = "Your story was submitted."
      StoriesWorker.perform_in(5.hours, @story.id)
      redirect_to story_path(@story)
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
  end

  def show
    @story = Story.find(params[:id])
    @submission = Submission.new
    @additions = @story.additions.order(created_at: :desc)

    if current_user
      @submissions = @story.submissions_to_be_viewed(current_user.id)
      SubmissionsWorker.perform_async(submissions_to_id(@submissions), current_user.id)
    else
      @submissions = @story.submissions.
        find_by_sql("SELECT submissions.*, users.username,
                    (select sum(value) as score from votes
                      where voteable_type='Submission' and voteable_id=submissions.id) as score
                    from submissions
                    join users on users.id=submissions.user_id
                    group by submissions.id, users.username")
        binding.pry
    end
  end

  def edit
    @story = Story.find(params[:id])
    authorize_user_for_action!(@story.user)
  end

  def update
    @story = Story.find(params[:id])
    authorize_user_for_action!(@story.user)
    if @story.update(story_params)
      flash[:notice] = "Your story was edited."
      redirect_to story_path(@story)
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
  end

  def destroy
    @story = Story.find(params[:id])
    authorize_user_for_action!(@story.user)

    Story.destroy(params[:id])
    redirect_to stories_path, notice: "Story deleted."
  end

  def vote
    story = Story.find(params[:id])
    if current_user
      vote = story.votes.find_or_initialize_by(user: current_user)
      vote.change_vote!(params[:vote_value].to_i)
      redirect_to stories_path
    else
      redirect_to new_user_session_path
    end
  end

  private

  def submissions_to_id(submissions)
    ids = []
    submissions.each { |s| ids << s.id}
    ids
  end

  def story_params
    params.require(:story).permit(:title, :first_entry, :search)
  end
end
