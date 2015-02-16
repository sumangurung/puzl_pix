require 'rails_helper'

RSpec.describe "Challenge friends" do
  it "stores a challenge request by a player" do
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }

    challenge_params = {
      challenge: {
        date: "02/02/2013",
        picture_url: "http://www.foo",
        thumb_url: "http://www.bar",
        game_id: 'awesomegame1',
        challengees: ['fbid1', 'fbid2']
      }
    }

    post '/v1/challenges', challenge_params.to_json, request_headers

    expect(response.status).to eq 201
  end
end
