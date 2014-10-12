class SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @submission = Submission.new(submission_params)
    @story = Story.find(params[:story_id])
    @submission.user = current_user
    @submission.story = @story

    if @submission.save
      flash[:notice] = "Your entry was submitted."
    end
    redirect_to story_path(@story)
  end

  def destroy
    @submission = Submission.find(params[:id])
    authorize_user_for_action!(@submission.user)
    @submission.destroy
    flash[:notice] = "Submission deleted."
    redirect_to story_path(params[:story_id])
  end

  def vote
    submission = Submission.find(params[:id])
    vote = submission.votes.find_or_initialize_by(user: current_user)

    if params[:vote_value].to_i == vote.value
      vote.delete
    else
      vote.value = params[:vote_value]
      vote.save
    end
    redirect_to story_path(submission.story_id)
  end

  private

  def submission_params
    params.require(:submission).permit(:body, :story_id, :search)
  end
end
