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

  it "creates a default username if a username is not passed in" do
    player_params = {
      player: { uuid: "123abc", fb_id: "123", first_name: "Jimmy", last_name: "Johnson", username: "" }
    }.to_json

    post '/v1/players', player_params, request_headers

    expect(response.status).to eq 201
    player = JSON.parse(response.body)['player']
    player_record = Player.find_by(uuid: "123abc")
    expect(player['username']).to match(/\APlayer [0-9\.]*\Z/)
  end

  it "players have unique usernames" do
    player_params = {
      player: { uuid: "123abc", fb_id: "123", first_name: "Jimmy", last_name: "Johnson", username: "" }
    }.to_json

    post '/v1/players', player_params, request_headers

    expect(response.status).to eq 201
    player = JSON.parse(response.body)['player']
    player_record = Player.find_by(uuid: "123abc")
    expect(player['username']).to match(/\APlayer [0-9\.]*\Z/)

    second_player_params = {
      player: { uuid: "234abc", first_name: "James", last_name: "Milner", username: player['username'] }
    }.to_json

    require 'pry'
    post '/v1/players', second_player_params, request_headers
    expect(response.status).to eq 422
    errors = JSON.parse(response.body)['player']['errors']
    expect(errors).to include("Username has already been taken")
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
  end

  it "responds with error if the username is updated to be blank" do
    player_params = { player: { uuid: "123abc", fb_id: "123", first_name: "Jimmy", last_name: "Johnson", username: "jj" } }.to_json
    post '/v1/players', player_params, request_headers

    updated_player_params = { player: { username: "" } }.to_json
    put '/v1/players/123abc', updated_player_params, request_headers

    expect(response.status).to eq 422
    errors = JSON.parse(response.body)['player']['errors']
    expect(errors).to include("Username can't be blank")
  end

  it "responds with error if the username is not unique" do
    PlayerCreator.create!(uuid: '123123', username: 'kk')
    PlayerCreator.create!(uuid: '123abc', username: 'jj')

    updated_player_params = { player: { username: "kk" } }.to_json
    put '/v1/players/123abc', updated_player_params, request_headers

    expect(response.status).to eq 422
    errors = JSON.parse(response.body)['player']['errors']
    expect(errors).to include("Username has already been taken")
  end

  it "returns the json of the player information" do
    player_params = { player: { uuid: "123abc", fb_id: "123", first_name: "Jimmy", last_name: "Johnson", username: "jj" } }.to_json
    post '/v1/players', player_params, request_headers
    expect(response.status).to eq 201

    get '/v1/players/123abc', {}, request_headers

    expect(response.status).to eq 200
    player = JSON.parse(response.body)['player']
    expect(player['uuid']).to eq('123abc')
    expect(player['fb_id']).to eq("123")
    expect(player['first_name']).to eq("Jimmy")
    expect(player['last_name']).to eq("Johnson")
    expect(player['username']).to eq("jj")
  end

  it "update a player which does not exist" do
    put '/v1/players/doesnotexist', { player: { username: "foobar" } }.to_json, request_headers

    expect(response.status).to eq 404
  end
end
