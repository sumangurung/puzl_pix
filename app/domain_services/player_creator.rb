class PlayerCreator
  def self.create(player_params)
    player = Player.new(player_params)

    if player.save && player.username.blank?
      player.username = "Player #{Time.now.to_i}#{player.id}"
      player.save
    end

    player
  end
end
