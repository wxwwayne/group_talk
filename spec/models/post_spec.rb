require 'rails_helper'
describe Post do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }

  it "is valid with content, user_id and group_id" do
    post = create(:post, user: user, group: group)
    expect(post).to be_valid
  end

  it "is invalid without content" do
    post = build(:post, user: user, group: group, content: nil)
    expect(post).not_to be_valid
  end

  it "is invalid without group_id" do
    post = build(:post, user: user, group: nil)
    expect(post).not_to be_valid
  end

  it "is invalid without user_id" do
    post = build(:post, user: nil, group: group)
    expect(post).not_to be_valid
  end
end

describe "Post dependent on group and user" do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }

  it "is deleted if group is deleted" do
    post = create(:post, user: user, group: group)
    user.destroy
    expect(Post.find_by(id: post.id)).to be_nil
  end

  it "is deleted if user is deleted" do
    post = create(:post, user: user, group: group)
    group.destroy
    expect(Post.find_by(id: post.id)).to be_nil
  end
end
