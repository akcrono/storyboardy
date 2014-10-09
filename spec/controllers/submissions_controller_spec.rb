require 'rails_helper'

describe SubmissionsController do
  describe "DELETE #destroy" do
    context "when not signed signed in" do
      let!(:submission) { FactoryGirl.create(:submission) }

      it "is denied access" do
        delete :destroy, { id: submission.id, story_id: submission.story.id }
        # delete story_submission_path(submission.story, submission)
        expect(response).to be_a_redirect
      end
    end
  end
end
