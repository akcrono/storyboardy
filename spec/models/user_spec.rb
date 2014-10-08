require 'rails_helper'

describe User do
  it { should respond_to(:stories) }
  it { should respond_to(:submissions) }

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without a password" do
    FactoryGirl.build(:user, encrypted_password: nil).should_not be_valid
  end

  it "should return true if admin" do
    user = FactoryGirl.build(:user)
    admin = FactoryGirl.build(:admin)

    expect(user.admin?).to eq(false)
    expect(admin.admin?).to eq(true)
  end

  # it "should check if user is authorized" do
  #   HOW TO DO THIS?
  # end
end
