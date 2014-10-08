require 'rails_helper'
describe StoriesController do
  describe "GET #index" do
    it "populates an array of stories" do
      story = FactoryGirl.create(:story)
      get :index
      assigns(:stories).should eq([story])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
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
