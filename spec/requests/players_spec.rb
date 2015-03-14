require 'rails_helper'

RSpec.describe "player registration info" do
  let(:token) { 'abc123' }
  before do
    allow(Authentication).to receive(:valid_key?)
      .with(token)
      .and_return(true)
  end

  it "creates a player record" do
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Token token=#{token}"
    }
    player_params = {
      player: { uuid: "123abc", fb_id: "123", first_name: "Jimmy", last_name: "Johnson", username: "jj" }
    }.to_json

    post '/v1/players', player_params, request_headers

    expect(response.status).to eq 201
    player = JSON.parse(response.body)['player']
    expect(player['uuid']).to eq('123abc')
    expect(player['fb_id']).to eq("123")
    expect(player['first_name']).to eq("Jimmy")
    expect(player['last_name']).to eq("Johnson")
    expect(player['username']).to eq("jj")

    players = Player.all
    expect(players.count).to eq 1
    expect(players.first.uuid).to eq("123abc")
    expect(players.first.fb_id).to eq("123")
    expect(players.first.first_name).to eq("Jimmy")
    expect(players.first.last_name).to eq("Johnson")
    expect(players.first.username).to eq("jj")
  end
end
