require 'rails_helper'

describe UserCreator do
  describe "#create" do
    it "creates the user with the provided params" do
      params = {
        uuid: "123abc",
        fb_id: "123",
        first_name: "Jimmy",
        last_name: "Johnson",
        username: "jj"
      }
      user = UserCreator.create(params)
      expect(user.id).to be
      expect(user.uuid).to eq params[:uuid]
      expect(user.fb_id).to eq params[:fb_id]
      expect(user.first_name).to eq params[:first_name]
      expect(user.last_name).to eq params[:last_name]
      expect(user.username).to eq params[:username]
    end

    it "assigns a username if the username is blank" do
      params = {
        uuid: "123abc",
      }
      user = UserCreator.create(params)
      expect(user.id).to be
      expect(user.username).to match(/\AUser [0-9\.]*\Z/)
    end
  end
end
