require 'rails_helper'

describe PlayerCreator do
  describe "#create" do
    it "creates the player with the provided params" do
      params = {
        uuid: "123abc",
        fb_id: "123",
        first_name: "Jimmy",
        last_name: "Johnson",
        username: "jj"
      }
      player = PlayerCreator.create(params)
      expect(player.id).to be
      expect(player.uuid).to eq params[:uuid]
      expect(player.fb_id).to eq params[:fb_id]
      expect(player.first_name).to eq params[:first_name]
      expect(player.last_name).to eq params[:last_name]
      expect(player.username).to eq params[:username]
    end

    it "assigns a username if the username is blank" do
      params = {
        uuid: "123abc",
      }
      player = PlayerCreator.create(params)
      expect(player.id).to be
      expect(player.username).to match(/\APlayer [0-9\.]*\Z/)
    end
  end
end
