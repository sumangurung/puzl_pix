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
    player = Player.create(
      uuid: SecureRandom.uuid,
      first_name: 'John',
      last_name: 'Doe'
    )

    score_params = {
      score: {
        player_uuid: player.uuid,
        game_id: 'awesomegame1',
        cols: '3',
        date: Date.today,
        difficulty: "very",
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
    player1 = Player.create(
      uuid: SecureRandom.uuid,
      first_name: "John",
      last_name: "Doe",
    )

    player2 = Player.create(
      uuid: SecureRandom.uuid,
      first_name: "Susan",
      last_name: "Smith"
    )

    Persistence::Score.create(
      player_uuid: player1.uuid,
      game_id: 'awesomegame1',
      cols: '3',
      date: Date.today,
      difficulty: "1",
      game_mode: "0",
      moves: "20",
      rows: '3',
      time: '140'
    )

    Persistence::Score.create(
      player_uuid: player2.uuid,
      game_id: 'awesomegame3',
      cols: '4',
      date: Date.today,
      difficulty: "3",
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
    expect(first_score["player_uuid"]).to eq player1.uuid
    expect(first_score["player_name"]).to eq player1.username
    expect(first_score["username"]).to eq player1.username
    expect(first_score["game_id"]).to eq 'awesomegame1'
    expect(first_score["cols"]).to eq 3
    expect(first_score["rows"]).to eq 3
    expect(first_score["date"]).to eq Date.today.strftime("%Y-%m-%d")
    expect(first_score["difficulty"]).to eq 1
    expect(first_score["game_mode"]).to eq "0"
    expect(first_score["moves"]).to eq 20
    expect(first_score["time"]).to eq 140

    expect(second_score["player_uuid"]).to eq player2.uuid
    expect(second_score["player_name"]).to eq player2.username
    expect(second_score["username"]).to eq player2.username
    expect(second_score["game_id"]).to eq 'awesomegame3'
    expect(second_score["cols"]).to eq 4
    expect(second_score["rows"]).to eq 4
    expect(second_score["date"]).to eq Date.today.strftime("%Y-%m-%d")
    expect(second_score["difficulty"]).to eq 3
    expect(second_score["game_mode"]).to eq "0"
    expect(second_score["moves"]).to eq 40
    expect(second_score["time"]).to eq 340
  end
end
