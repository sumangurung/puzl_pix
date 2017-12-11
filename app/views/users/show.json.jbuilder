json.user do |json|
  json.(@user, :uuid, :fb_id, :first_name, :last_name, :username)
  json.errors @user.errors.full_messages
end
