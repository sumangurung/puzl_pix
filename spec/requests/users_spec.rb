require 'rails_helper'

RSpec.describe "user registration info" do
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

  it "creates a user record" do
    user_params = {
      user: { uuid: "123abc", username: "jj" }
    }.to_json

    post '/v1/users', user_params, request_headers

    expect(response.status).to eq 201
    user = JSON.parse(response.body)['user']
    expect(user['uuid']).to eq('123abc')
    expect(user['username']).to eq("jj")

    users = User.all
    expect(users.count).to eq 1
    expect(users.first.uuid).to eq("123abc")
    expect(users.first.username).to eq("jj")
  end

  it "creates a default username if a username is not passed in" do
    user_params = {
      user: { uuid: "123abc", username: "" }
    }.to_json

    post '/v1/users', user_params, request_headers

    expect(response.status).to eq 201
    user = JSON.parse(response.body)['user']
    user_record = User.find_by(uuid: "123abc")
    expect(user['username']).to match(/\AUser [0-9\.]*\Z/)
  end

  it "users have unique usernames" do
    user_params = {
      user: { uuid: "123abc", username: "" }
    }.to_json

    post '/v1/users', user_params, request_headers

    expect(response.status).to eq 201
    user = JSON.parse(response.body)['user']
    user_record = User.find_by(uuid: "123abc")
    expect(user['username']).to match(/\AUser [0-9\.]*\Z/)

    second_user_params = {
      user: { uuid: "234abc", username: user['username'] }
    }.to_json

    post '/v1/users', second_user_params, request_headers
    expect(response.status).to eq 422
    errors = JSON.parse(response.body)['user']['errors']
    expect(errors).to include("Username has already been taken")
  end

  it "updates a user record" do
    user_params = { user: { uuid: "123abc" } }.to_json
    post '/v1/users', user_params, request_headers

    user_params = { user: { username: "jj" } }.to_json
    put '/v1/users/123abc', user_params, request_headers

    expect(response.status).to eq 200
    user = JSON.parse(response.body)['user']
    expect(user['uuid']).to eq('123abc')
    expect(user['username']).to eq("jj")
  end

  it "responds with error if the username is updated to be blank" do
    user_params = { user: { uuid: "123abc", username: "jj" } }.to_json
    post '/v1/users', user_params, request_headers

    updated_user_params = { user: { username: "" } }.to_json
    put '/v1/users/123abc', updated_user_params, request_headers

    expect(response.status).to eq 422
    errors = JSON.parse(response.body)['user']['errors']
    expect(errors).to include("Username can't be blank")
  end

  it "responds with error if the username is not unique" do
    UserCreator.create!(uuid: '123123', username: 'kk')
    UserCreator.create!(uuid: '123abc', username: 'jj')

    updated_user_params = { user: { username: "kk" } }.to_json
    put '/v1/users/123abc', updated_user_params, request_headers

    expect(response.status).to eq 422
    errors = JSON.parse(response.body)['user']['errors']
    expect(errors).to include("Username has already been taken")
  end

  it "returns the json of the user information" do
    user_params = { user: { uuid: "123abc", username: "jj" } }.to_json
    post '/v1/users', user_params, request_headers
    expect(response.status).to eq 201

    get '/v1/users/123abc', {}, request_headers

    expect(response.status).to eq 200
    user = JSON.parse(response.body)['user']
    expect(user['uuid']).to eq('123abc')
    expect(user['username']).to eq("jj")
  end

  it "update a user which does not exist" do
    put '/v1/users/doesnotexist', { user: { username: "foobar" } }.to_json, request_headers

    expect(response.status).to eq 404
  end
end
