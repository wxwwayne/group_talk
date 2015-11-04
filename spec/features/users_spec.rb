require "rails_helper"

feature "User registration" do
  let(:new_user) { build(:user) }
  let(:a_user) { create(:user) }

  scenario 'add a new user', js: true do
    expect{ sign_up(new_user) }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario 'update a user', js:true do
    new_profile = build(:user)
    log_in(a_user)
    update_user_with(new_profile, a_user.password)
    expect(page).to have_content "Your account has been updated successfully."
    expect(page).to have_content(new_profile.name)
  end

  scenario 'delete the user', js: true do
    log_in(a_user)
    expect{ destroy_my_account }.to change(User, :count).by(-1)
    expect(current_path).to eq root_path
    expect(page).not_to have_content a_user.name
  end
end
