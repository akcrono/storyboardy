require 'rails_helper'
feature 'User registers an account' do
  scenario "user signs up successfully" do
    visit register_path
    fill_in 'Email', with: 'frank@tank.com' #can also user css id's
    fill_in 'Username', with: 'tanktheFrank'
    fill_in 'user_password', with: 'something'
    fill_in 'Password confirmation', with: 'something'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'user signs up with invalid info' do
    visit register_path
    fill_in 'Email', with: 'frank@tank.com'
    fill_in 'Username', with: 'frank'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'passward'
    click_on 'Sign up'

    expect(page).to have_content "doesn't match Password"
  end
end

feature "User signs in" do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'User signs in with username successfully' do
    sign_in_as(user)

    expect(page).to have_content "Signed in successfully."
  end

  scenario 'User signs in with email successfully' do
    visit login_path
    fill_in "Login", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
  end

  scenario 'User signs in with invalid info' do
    visit login_path
    fill_in "Login", with: 'taco'
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to_not have_content user.username
  end

  scenario 'User signs in and signs out' do
    sign_in_as(user)
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end
end

feature 'User changes user' do
  let(:user) { FactoryGirl.create(:user) }
  scenario 'User edits profile' do
    sign_in_as(user)
    click_link user.username
    click_link "Edit Profile"

    fill_in "Avatar", with: "http://www.southparkreviews.com/assets/stan-a7a0b4f320264fcb3abb3469a865cd73.png"
    fill_in "Bio", with: "Just a city boy, born and raised in south Detroit."
    fill_in "Current password", with: "abcd1234"
    click_button "Update"

    expect(page).to have_content "Your account has been updated successfully."
  end

  scenario 'User tries to edit other_user' do
    sign_in_as(user)
    other_user = FactoryGirl.create(:user)
    visit edit_user_registration_path(other_user)
    fill_in "Bio", with: "Just a small town girl."
    fill_in "Current password", with: "efgh1234"

    expect(page).to have_content "need your current password to confirm your changes"
  end

  scenario 'User deletes profile' do
    sign_in_as(user)
    click_link user.username
    click_link "Edit Profile"
    click_link "Cancel my account"


    expect(page).to have_content "Your account has been successfully cancelled."
  end

end

