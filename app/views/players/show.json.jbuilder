json.player do |json|
  json.(@player, :uuid, :fb_id, :first_name, :last_name, :username, :errors)
end
