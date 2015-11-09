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

  context "for timed games" do
    before do
      Persistence::Score.create(
        player_uuid: '123',
        game_id: 'awesomegame1',
        game_level: "1",
        game_mode: "0",
        moves: "20",
        time: '440'
      )

      Persistence::Score.create(
        player_uuid: '323',
        game_id: 'awesomegame2',
        game_level: "1",
        game_mode: "0",
        moves: "20",
        time: '640'
      )

      Persistence::Score.create(
        player_uuid: '234',
        game_id: 'awesomegame3',
        game_level: "3",
        game_mode: "0",
        moves: "40",
        time: '340'
      )
    end

    it "orders by time in ascending order" do
      get '/v1/scores', { game_mode: "0" }, request_headers
      expect(response.status).to eq 200
      scores = JSON.parse(response.body)['scores']
      expect(scores.length).to eq 3
      expected_sequence  = [ "awesomegame3" , "awesomegame1", "awesomegame2" ]
      actual_sequence = scores.map { |score| score["game_id"] }
      expect(actual_sequence).to eq expected_sequence
    end
  end

  context "untimed game" do
    before do
      Persistence::Score.create(
        player_uuid: '123',
        game_id: 'awesomegame1',
        game_level: "1",
        game_mode: "1",
        moves: "20",
        time: '440'
      )

      Persistence::Score.create(
        player_uuid: '323',
        game_id: 'awesomegame2',
        game_level: "1",
        game_mode: "1",
        moves: "50",
        time: '640'
      )

      Persistence::Score.create(
        player_uuid: '234',
        game_id: 'awesomegame3',
        game_level: "3",
        game_mode: "1",
        moves: "40",
        time: '340'
      )
    end

    it "orders by time in ascending order" do
      get '/v1/scores', { game_mode: "1" }, request_headers
      expect(response.status).to eq 200
      scores = JSON.parse(response.body)['scores']
      expect(scores.length).to eq 3
      expected_sequence  = [ "awesomegame1", "awesomegame3",  "awesomegame2" ]
      actual_sequence = scores.map { |score| score["game_id"] }
      expect(actual_sequence).to eq expected_sequence
    end
  end
end
