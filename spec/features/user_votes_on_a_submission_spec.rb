require "rails_helper"
feature 'User votes on an submission' do
let(:submission) { FactoryGirl.create(:submission) }
let(:user) { FactoryGirl.create(:user) }
  scenario "user upvotes a submission" do
    sign_in_as(user)
    visit story_path(submission.story)
    find(".submission-upvote").click
    click_link "up"
    expect(page).to have_content '1'
  end

  scenario "user downvotes a submission" do
    sign_in_as(user)
    visit story_path(submission.story)
    find(".submission-downvote").click

    expect(page).to have_content '-1'
  end

  scenario "user deletes an upvote a submission" do
    sign_in_as(user)
    visit story_path(submission.story)
    find(".submission-upvote").click
    find(".submission-upvote").click

    expect(page).to have_content '0'
  end

  scenario "user deletes a downvote a submission" do
    sign_in_as(user)
    visit story_path(submission.story)
    #find("#thumb-up").click
    find(".submission-downvote").click
    find(".submission-downvote").click

    expect(page).to have_content '0'
  end

  scenario "user changes a submission" do
    sign_in_as(user)
    visit story_path(submission.story)
    #find("#thumb-up").click
    find(".submission-upvote").click
    find(".submission-downvote").click

    expect(page).to have_content '-1'
  end
end
