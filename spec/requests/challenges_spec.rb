require 'rails_helper'

RSpec.describe "Challenge friends" do
  describe "Store Challenges" do
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

  describe "Query Challenges" do
    it "fetches all the challenges for a player" do
      Challenges.create!(
        date: "02/02/2013",
        picture_url: "http://www.foo1",
        thumb_url: "http://www.bar1",
        game_id: 'awesomegame1',
        challengees: ['fbid1']
      )

      Challenges.create!(
        date: "02/03/2013",
        picture_url: "http://www.foo2",
        thumb_url: "http://www.bar2",
        game_id: 'awesomegame2',
        challengees: ['fbid1']
      )

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"

      }
      get '/v1/challenges', { fb_id: 'fbid1' }, request_headers

      expect(response.status).to eq 200
      challenges = JSON.parse(response.body)['challenges']
      expect(challenges.size).to eq 2

      expect(challenges.first['picture_url']).to eq('http://www.foo1')
      expect(challenges.first['thumb_url']).to eq('http://www.bar1')
      expect(challenges.first['game_id']).to eq('awesomegame1')

      expect(challenges.last['picture_url']).to eq('http://www.foo2')
      expect(challenges.last['thumb_url']).to eq('http://www.bar2')
      expect(challenges.last['game_id']).to eq('awesomegame2')
    end
  end
end
