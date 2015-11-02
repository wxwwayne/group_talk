require 'rails_helper'
describe Group do
  let(:user) { create(:user) }
  it "is valid with title and user_id" do
    group = create(:group, user: user)
    expect(group).to be_valid
  end

  it "is invalid without title" do
    group = build(:group, user: user, title: nil)
    expect(group).not_to be_valid
  end

  it "is invalid without user_id" do
    group = build(:group, user: nil)
    expect(group).not_to be_valid
  end
end

describe "Group dependent on user" do
  let(:user) { create(:user) }
  it "is deleted when user if user is deleted" do
    group = create(:group, user: user)
    user.destroy
    expect(Group.find_by(id: group.id)).to be_nil
  end
end
