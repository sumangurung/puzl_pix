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

    Persistence::Score.create(
      player_id: '123',
      game_id: 'awesomegame1',
      cols: '3',
      date: "02/02/2014",
      difficulty: "1",
      game_mode: "timed",
      moves: "20",
      rows: '3',
      time: '140'
    )

    Persistence::Score.create(
      player_id: '234',
      game_id: 'awesomegame3',
      cols: '4',
      date: "02/02/2014",
      difficulty: "3",
      game_mode: "untimed",
      moves: "40",
      rows: '4',
      time: '340'
    )
  end

  it "allows filtering by user" do
    get '/v1/scores', { player_id: 123 }, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
    score = scores.first
    expect(score["player_id"]).to eq 123
    expect(score["game_id"]).to eq 'awesomegame1'

    get '/v1/scores', { player_id: 234 }, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
    score = scores.first
    expect(score["player_id"]).to eq 234
    expect(score["game_id"]).to eq 'awesomegame3'
  end

  it "allows filter by game mode" do
    get '/v1/scores', { game_mode: "timed" }, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
    score = scores.first
    expect(score["game_mode"]).to eq "timed"

    get '/v1/scores', { game_mode: 'untimed' }, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
    score = scores.first
    expect(score["game_mode"]).to eq "untimed"
  end
end
