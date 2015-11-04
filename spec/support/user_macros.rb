module UserMacros
  def sign_up(user)
    visit root_path
    click_link "Register"
    fill_in "Email", with: user.email
    fill_in "Name", with: user.name
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_button "Sign up"
  end

  def log_in(user)
    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def update_user_with(profile, old_password)
    find('.dropdown-toggle').click
    click_link "Account update"
    fill_in "Email", with: profile.email
    fill_in "Name", with: profile.name
    fill_in "user_current_password", with: old_password
    click_button "Update"
  end

  def destroy_my_account
    find('.dropdown-toggle').click
    click_link "Account update"
    click_link "Cancel my account"
    page.driver.browser.switch_to.alert.accept
    visit current_path
  end
end
