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
end
