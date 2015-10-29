json.player do |json|
  json.(@player, :uuid, :fb_id, :first_name, :last_name, :username)
  json.errors @player.errors.full_messages
end
