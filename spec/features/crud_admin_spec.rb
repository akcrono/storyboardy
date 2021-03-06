require 'rails_helper'
feature 'User Priviledges' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  scenario 'Admin deletes an unruly user' do
    sign_in_as(admin)
    visit user_path(user)
    click_on 'Delete User'
    # save_and_open_page
    expect(page).to have_content 'User has been deleted'
  end

  scenario 'Admin makes another user an admin' do
    sign_in_as(admin)
    visit user_path(user)
    click_on 'Make user admin'

    expect(page).to have_content 'User has been set as Admin'
  end

end
