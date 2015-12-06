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

  it "fetches only the best 50 scores" do
    allow(Rails.configuration).to receive(:scores_limit)
      .and_return(2)
    player1 = Player.create(
      uuid: SecureRandom.uuid,
      username: 'jd',
      first_name: "John",
      last_name: "Doe",
    )

    player2 = Player.create(
      uuid: SecureRandom.uuid,
      username: 'ss',
      first_name: "Susan",
      last_name: "Smith"
    )

    Persistence::Score.create(
      player_uuid: player1.uuid,
      game_id: 'awesomegame1',
      cols: '3',
      date: 4.days.ago.to_date,
      game_level: "1",
      game_mode: "0",
      moves: "20",
      rows: '3',
      time: '140'
    )

    Persistence::Score.create(
      player_uuid: player2.uuid,
      game_id: 'awesomegame2',
      cols: '4',
      date: 7.days.ago.to_date,
      game_level: "1",
      game_mode: "0",
      moves: "40",
      rows: '4',
      time: '340'
    )

    Persistence::Score.create(
      player_uuid: player1.uuid,
      game_id: 'awesomegame3',
      cols: '4',
      date: 6.days.ago.to_date,
      game_level: "1",
      game_mode: "0",
      moves: "30",
      rows: '4',
      time: '200'
    )

    get '/v1/scores', { game_mode: '0' }, request_headers

    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 2
    first_score, second_score = scores

    expect(first_score["player_name"]).to eq player1.username
    expect(first_score["username"]).to eq player1.username
    expect(first_score["game_id"]).to eq 'awesomegame1'
    expect(first_score["date"]).to eq 4.days.ago.strftime("%Y-%m-%d")
    expect(first_score["game_level"]).to eq 1
    expect(first_score["game_mode"]).to eq "0"
    expect(first_score["time"]).to eq 140

    expect(second_score["player_name"]).to eq player1.username
    expect(second_score["username"]).to eq player1.username
    expect(second_score["game_id"]).to eq 'awesomegame3'
    expect(second_score["date"]).to eq 6.days.ago.strftime("%Y-%m-%d")
    expect(first_score["game_level"]).to eq 1
    expect(second_score["game_mode"]).to eq "0"
    expect(second_score["time"]).to eq 200
  end
end
