require "rails_helper"

describe "Groups API" do
  it "sends an individual group" do
    user = create(:user)
    group = create(:group, user: user)

    get "/api/v1/groups/#{group.id}", nil, { 'HTTP_ACCEPT' => 'application/vnd.groups.v1' }

    expect(response.code).to eq "200"
    # json = JSON.parse(response.body)
    # expect(json['title']).to eq(group.title)
    # expect(json['description']).to eq(nil)
    # expect(response.body).to have_content(group.title)
  end
end
