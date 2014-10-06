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

  scenario 'user signs in successfully' do
    sign_in_as(user)

    expect(page).to have_content "Signed in successfully."
  end

  scenario 'user signs in with invalid info' do
    visit login_path
    fill_in "Username", with: 'taco'
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to_not have_content user.username
  end

  scenario 'user signs in and signs out' do
    sign_in_as(user)
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end


end
