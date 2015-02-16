require 'rails_helper'

RSpec.describe "player registration info" do
  it "creates a player record" do
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }
    player_params = {
      player: { fb_id: 123, first_name: "Jimmy", last_name: "Johnson", username: "jj" }
    }.to_json

    post '/v1/players', player_params, request_headers

    expect(response.status).to eq 201
    player = JSON.parse(response.body)['player']
    expect(player['fb_id']).to eq(123)
    expect(player['first_name']).to eq("Jimmy")
    expect(player['last_name']).to eq("Johnson")
    expect(player['username']).to eq("jj")
  end
end
