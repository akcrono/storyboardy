require "rails_helper"
feature 'User votes on an story' do
let(:story) { FactoryGirl.create(:story) }
let(:user) { FactoryGirl.create(:user) }
  scenario "user upvotes a story" do
    sign_in_as(user)
    visit story_path(story)
    #find("#thumb-up").click
    click_link "up"

    expect(page).to have_content '1'
  end

  scenario "user downvotes a story" do
    sign_in_as(user)
    visit story_path(story)
    #find("#thumb-up").click
    click_link "down"

    expect(page).to have_content '-1'
  end

  scenario "user deletes an upvote a story" do
    sign_in_as(user)
    visit story_path(story)
    #find("#thumb-up").click
    click_link "up"
    click_link "UP"

    expect(page).to have_content '0'
  end

  scenario "user deletes a downvote a story" do
    sign_in_as(user)
    visit story_path(story)
    #find("#thumb-up").click
    click_link "down"
    click_link "DOWN"

    expect(page).to have_content '0'
  end

  scenario "user changes a story" do
    sign_in_as(user)
    visit story_path(story)
    #find("#thumb-up").click
    click_link "up"
    click_link "down"

    expect(page).to have_content '-1'
  end
end
