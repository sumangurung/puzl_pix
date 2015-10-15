require 'rails_helper'

describe Player do
  describe "#username" do
    it "return the username if the player object has a username" do
      player = Player.new(username: 'foob')
      expect(player.username).to eq('foob')
    end

    it "returns a default username if username is emtpy" do
      player = Player.new(username: '', id: 12)
      expect(player.username).to eq('Player 12')
    end

    it "returns a default username if username is nil" do
      player = Player.new(username: nil, id: 12)
      expect(player.username).to eq('Player 12')
    end
  end
end
