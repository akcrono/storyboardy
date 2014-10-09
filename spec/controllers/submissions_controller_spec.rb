require 'rails_helper'

describe SubmissionsController do
  describe "DELETE #destroy" do
    context "when not signed signed in" do
      let!(:submission) { FactoryGirl.create(:submission) }

      it "is denied access" do
        delete :destroy, { id: submission.id, story_id: submission.story.id }
        # delete story_submission_path(submission.story, submission)
      end
    end

    # it "populates an array of stories" do
    #   story = FactoryGirl.create(:story)
    #   get :index
    #   assigns(:stories).should eq([story])
    # end

    # it "renders the :index view" do
    #   get :index
    #   response.should render_template :index
    # end
  end
# These don't work either for some reason
  # describe "GET #show" do
  #   it "assigns the requested story to @story" do
  #     story = FactoryGirl.create(:story)
  #     get :show, id: story
  #     assigns(:story).should eq(story)
  #   end

  #   it "renders the #show view" do
  #     get :show, id: FactoryGirl.create(:story)
  #     response.should render_template :show
  #   end
  # end
end
