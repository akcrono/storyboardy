class SubmissionsController < ApplicationController
  def create
    @submission = Submission.new(submission_params)
    @story = Story.find(params[:story_id])
    @submission.user = current_user
    @submission.story = @story
    if @submission.save
      flash[:notice] = "Your entry was submitted."
      redirect_to story_path(@story)
    else
      flash[:notice] = "You need to add something!"
      render :new
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    if authorize_user_for_action?(@submission.user)
      @submission.destroy
      flash[:notice] = "Submission deleted."
    else
      flash[:notice] = "You aren't the author of this post."
    end
    redirect_to story_path(params[:story_id])
  end

  private

  def submission_params
        params.require(:submission).permit(:body, :story_id, :search)
  end
end
