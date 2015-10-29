class PlayerCreator
  def self.create(player_params)
    instantiate_and_return_player(player_params) do |player|
      player.save
    end
  end

  def self.create!(player_params)
    instantiate_and_return_player(player_params) do |player|
      player.save!
    end
  end

  def self.instantiate_and_return_player(player_params)
    player = Player.new(player_params)
    if player.username.blank?
      player.username = "Player #{Time.now.to_i}"
    end

    yield(player)

    player
  end
end
