require 'rails_helper'
feature 'User creates a submission' do
  let(:story) { FactoryGirl.create(:story) }
  let(:user) { FactoryGirl.create(:user) }
  scenario 'User not signed in' do
    visit story_path(story)
    click_link "Log in to add to this story!"

    expect(page).to have_content "Password"
    expect(page).to have_content "Remember me"
  end

  scenario 'User writes a submission successfully' do
    sign_in_as(user)
    visit story_path(story)
    fill_in "Add your submission below:", with: "A party?"
    click_button "Submit"

    expect(page).to have_content "A party?"
    expect(page).to have_content "Your entry was submitted."

  end

  let(:submission) { FactoryGirl.create(:submission) }
  scenario 'User destroys his submission' do
    sign_in_as(submission.user)
    visit story_path(submission.story)
    click_button "Delete Submission"

   expect(page).to have_content "Submission deleted."
  end
# Need proper delete route for this method
  # let(:submission) { FactoryGirl.create(:submission) }
  # scenario 'User attempts to destroys other user\'s submission' do
  #   sign_in_as(user)
  #   delete "/stories/#{submission.story.id}/submissions/#{submission.id}"

  #  expect(page).to have_content "You aren't signed in as the original author."
  # end

  # scenario 'User creates a submission with markdown' do
        # save_and_open_page
  # end
end

