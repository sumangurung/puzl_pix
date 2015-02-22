require 'rails_helper'

RSpec.describe 'store device token for user' do
  let(:token) { 'abc123' }
  before do
    allow(Authentication).to receive(:valid_key?)
      .with(token)
      .and_return(true)
  end

  it "stores the device token for a user" do
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Token token=#{token}"
    }

    Player.create( fb_id: 'fbid1')
    device_token = "123abc456dev"
    device_token_params = { device_token: device_token }.to_json
    post "/v1/players/fbid1/device_tokens", device_token_params, request_headers

    expect(response.status).to eq 201

    player = Player.find_by fb_id: "fbid1"
    expect(player.device_tokens.map(&:token)).to include(device_token)
  end
end
