require 'rails_helper'

RSpec.describe "player registration info" do
  let(:token) { 'abc123' }
  let(:request_headers) do
    {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Token token=#{token}"
    }
  end

  before do
    allow(Authentication).to receive(:valid_key?)
      .with(token)
      .and_return(true)
  end

  it "creates a player record" do
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

  it "updates a player record" do
    player_params = { player: { uuid: "123abc" } }.to_json
    post '/v1/players', player_params, request_headers

    player_params = { player: { fb_id: "123", first_name: "Jimmy", last_name: "Johnson", username: "jj" } }.to_json
    put '/v1/players/123abc', player_params, request_headers

    expect(response.status).to eq 200
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

  it "update a player which does not exist" do
    put '/v1/players/doesnotexist', { player: { username: "foobar" } }.to_json, request_headers

    expect(response.status).to eq 404
  end
end
