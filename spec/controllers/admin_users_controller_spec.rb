require 'rails_helper'

describe Admin::UsersController do

  describe "DELETE destroy" do
    it "allows admin to remove user" do
      admin = FactoryGirl.create(:admin)
      user = FactoryGirl.create(:user)
      sign_in admin

      delete :destroy, id: user.id

      expect(User.count).to eq(1)
    end

    it "prevents user from removing user" do
      other_user = FactoryGirl.create(:user)
      user = FactoryGirl.create(:user)
      sign_in user

      expect { delete :destroy, id: other_user.id }.
        to raise_error(ActionController::RoutingError)
      expect(User.count).to eq(2)
    end
  end
end
