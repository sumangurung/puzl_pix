require 'rails_helper'

RSpec.describe "store user registration info" do
  it "returns an empty array when array when there are no challenges" do
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }
    user_params = {
      user: { fb_id: 123, first_name: "Jimmy", last_name: "Johnson", username: "jj" }
    }.to_json

    post '/v1/users', user_params, request_headers

    expect(response.status).to eq 201
    user = JSON.parse(response.body)['user']
    expect(user['fb_id']).to eq(123)
    expect(user['first_name']).to eq("Jimmy")
    expect(user['last_name']).to eq("Johnson")
    expect(user['username']).to eq("jj")
  end
end
