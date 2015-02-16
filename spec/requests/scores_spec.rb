require 'rails_helper'

RSpec.describe "game score" do
  it "stores the game score" do
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }

    score_params = {
      score: {
        player_id: '123',
        game_id: 'awesomegame1',
        cols: '3',
        date: "02/02/2014",
        difficulty: "very",
        game_mode: "easy",
        moves: "20",
        rows: '3',
        time: '140'
      }
    }

    post '/v1/scores', score_params.to_json, request_headers

    expect(response.status).to eq 201
  end
end
