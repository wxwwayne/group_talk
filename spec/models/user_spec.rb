require 'rails_helper'
describe User do
  it "is valid with password and email" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without email" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "is invalid with duplicated email" do
    create(:user, email: "something@something.com")
    user = build(:user, email: "something@something.com")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid without password" do
    expect(build(:user, password: nil)).not_to be_valid
  end

  it "is invalid with too short password" do
    expect(build(:user, password: "a"*5)).not_to be_valid
  end
end
