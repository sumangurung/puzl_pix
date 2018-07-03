require 'rails_helper'

RSpec.describe "game score" do
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

  it "stores the game score" do
    user = User.create(
      uuid: SecureRandom.uuid,
      username: 'jd'
    )

    score_params = {
      score: {
        uuid: SecureRandom.uuid,
        user_uuid: user.uuid,
        cols: '3',
        date: Date.today,
        game_level: "very",
        game_mode: "0",
        moves: "20",
        rows: '3',
        time: '140'
      }
    }

    post '/v1/scores', score_params.to_json, request_headers

    expect(response.status).to eq 201

    get '/v1/scores', {}, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
  end

  it "fetches the scores of all users" do
    user1 = User.create(
      uuid: SecureRandom.uuid,
      username: "jd"
    )

    user2 = User.create(
      uuid: SecureRandom.uuid,
      username: "ss"
    )

    Score.create(
      uuid: SecureRandom.uuid,
      user_uuid: user1.uuid,
      cols: '3',
      date: Date.today,
      game_level: "1",
      game_mode: "0",
      moves: "20",
      rows: '3',
      time: '140'
    )

    Score.create(
      uuid: SecureRandom.uuid,
      user_uuid: user2.uuid,
      cols: '4',
      date: Date.today,
      game_level: "3",
      game_mode: "0",
      moves: "40",
      rows: '4',
      time: '340'
    )

    get '/v1/scores', {}, request_headers

    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 2
    first_score, second_score = scores
    expect(first_score["user_uuid"]).to eq user1.uuid
    expect(first_score["user_name"]).to eq user1.username
    expect(first_score["username"]).to eq user1.username
    expect(first_score["cols"]).to eq 3
    expect(first_score["rows"]).to eq 3
    expect(first_score["date"]).to eq Date.today.strftime("%Y-%m-%d")
    expect(first_score["game_level"]).to eq 1
    expect(first_score["game_mode"]).to eq 0
    expect(first_score["moves"]).to eq 20
    expect(first_score["time"]).to eq 140

    expect(second_score["user_uuid"]).to eq user2.uuid
    expect(second_score["user_name"]).to eq user2.username
    expect(second_score["username"]).to eq user2.username
    expect(second_score["cols"]).to eq 4
    expect(second_score["rows"]).to eq 4
    expect(second_score["date"]).to eq Date.today.strftime("%Y-%m-%d")
    expect(second_score["game_level"]).to eq 3
    expect(second_score["game_mode"]).to eq 0
    expect(second_score["moves"]).to eq 40
    expect(second_score["time"]).to eq 340
  end
end
