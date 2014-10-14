class StoriesController < ApplicationController
  def index
    @stories = Story.populate_index_with(params).page(params[:page])
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
      redirect_to story_path(@story)
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
  end

  def show
    @story = Story.find(params[:id])
    @submission = Submission.new
    @submissions = @story.submissions.order(:created_at).page(params[:page]).per(10)
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
    vote = story.votes.find_or_initialize_by(user: current_user)
    user_vote = params[:vote_value].to_i

    if user_vote == vote.value
      story.increment!(:score, by = -user_vote)
      vote.delete
    else
      if vote.value.nil?
        story.increment!(:score, by = user_vote)
      else
        story.increment!(:score, by = user_vote * 2)
      end
      vote.value = params[:vote_value]
      vote.save
    end

    redirect_to stories_path
  end

  private

  def story_params
    params.require(:story).permit(:title, :first_entry, :search)
  end
end
