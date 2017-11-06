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

    PlayerCreator.create!(uuid: '123', username: 'kk')
    PlayerCreator.create!(uuid: '234', username: 'jj')

    Score.create(
      player_uuid: '123',
      game_id: 'awesomegame1',
      cols: '3',
      date: Date.today,
      game_level: "1",
      game_mode: "0",
      moves: "20",
      rows: '3',
      time: '140'
    )

    Score.create(
      player_uuid: '234',
      game_id: 'awesomegame3',
      cols: '4',
      date: Date.today,
      game_level: "3",
      game_mode: "1",
      moves: "40",
      rows: '4',
      time: '340'
    )
  end

  it "allows filter by gameLevel" do
    get '/v1/scores', { gameLevel: "1" }, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
    score = scores.first
    expect(score["game_level"]).to eq 1

    get '/v1/scores', { game_level: '3' }, request_headers
    expect(response.status).to eq 200
    scores = JSON.parse(response.body)['scores']
    expect(scores.length).to eq 1
    score = scores.first
    expect(score["game_level"]).to eq 3
  end
end
