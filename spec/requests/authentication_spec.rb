require 'rails_helper'

describe "Authentication with api key" do
  it "Requests without valid api key will return 401" do
    api_key = Authentication.create_new_api_key
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Token token=#{api_key}foo"
    }

    get "/v1/challenges", {}, request_headers

    expect(response.status).to eq 401
    body = JSON.parse(response.body)
    expect(body["error"]).to eq "HTTP Token: Access denied."
  end

  it "accepts requests with correct api key" do
    api_key = Authentication.create_new_api_key
    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Token token=#{api_key}"
    }

    get "/v1/challenges", {}, request_headers

    expect(response.status).to eq 200
  end
end
