require 'rails_helper'

RSpec.describe "push notification on challenges" do
  let(:token) { "abc123" }
  before do
    allow(Authentication).to receive(:valid_key?)
      .with(token)
      .and_return(true)
  end

  describe "Store Challenges" do
    it "stores a challenge request by a player" do
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Token token=#{token}"
      }
      friend1 = Player.create!(
        fb_id: "fbid1",
        first_name: "John",
        last_name: "Ball",
        username: "jb"
      )
      friend1.add_device_token("token1")

      friend2= Player.create(
        fb_id: "fbid2",
        first_name: "Kevin",
        last_name: "Friend",
        username: "kf"
      )
      friend2.add_device_token("token2")

      challenge_params = {
        challenge: {
          date: "02/02/2013",
          picture_url: "http://www.foo",
          thumb_url: "http://www.bar",
          game_id: 'awesomegame1',
          challengees: ['fbid1', 'fbid2']
        }
      }

      notification1 = double; notification2 = double

      allow(APNS::Notification).to receive(:new)
        .with("token1", "You have been challenged!")
        .and_return(notification1)
      allow(APNS::Notification).to receive(:new)
        .with("token2", "You have been challenged!")
        .and_return(notification2)

      expect(APNS).to receive(:send_notifications)
        .with([notification1, notification2])
      post '/v1/challenges', challenge_params.to_json, request_headers

      expect(response.status).to eq 201
    end
  end
end
