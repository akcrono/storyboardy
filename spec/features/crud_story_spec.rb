require 'rails_helper'
feature 'User creates a story' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'User not signed in' do
    visit new_story_path

    expect(page).to have_content "You must be signed in to do this."
  end

  scenario 'User writes a story successfully' do
    sign_in_as(user)
    click_button "New Story"
    fill_in "Title", with: 'taco time'
    fill_in "First entry", with: 'It was the time of the taco'
    click_button "Create Story"

    expect(page).to have_content "Your story was submitted."
    expect(page).to have_content "taco time"
  end

  scenario 'User writes an invalid story' do
    sign_in_as(user)
    visit new_story_path
    fill_in "First entry", with: 'It was the time of the taco'
    click_button "Create Story"

    expect(page).to have_content "Invalid entry"
  end

  let(:story) { FactoryGirl.create(:story) }
  scenario 'User edits his story' do
    visit story_path(story)
    sign_in_as(story.user)
    visit edit_story_path(story)
    fill_in "Title", with: 'pizza time'
    fill_in "First entry", with: 'It was the time of pizza'
    click_button "Update Story"

    expect(page).to have_content "Your story was edited."
    expect(page).to have_content "pizza time"
  end

  scenario 'User edits his story with a blank title' do
    visit story_path(story)
    sign_in_as(story.user)
    visit edit_story_path(story)
    fill_in "Title", with: ''
    fill_in "First entry", with: 'It was the time of pizza'
    click_button "Update Story"

    expect(page).to have_content "Invalid entry"
  end

  scenario "User tries to edit someone else's story" do
    visit story_path(story)
    sign_in_as(user)

    expect{ visit edit_story_path(story) }.to raise_error(ActionController::RoutingError)
  end

  scenario 'User destroys his story' do
    visit story_path(story)
    sign_in_as(story.user)
    visit story_path(story)
    click_button "Delete Story"

   expect(page).to have_content "Story deleted."
  end



  # scenario 'User creates a review with markdown' do
        # save_and_open_page
  # end
end
