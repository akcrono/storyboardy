module Helpers
  module Authentication
    def sign_in_as(user)
      visit login_path

      within "#new_user" do
        fill_in "Login", with: user.username
        fill_in "Password", with: user.password
        click_button "Log in"
      end
    end
  end
end
