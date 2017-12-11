json.user do |json|
  json.(@user, :uuid, :username)
  json.errors @user.errors.full_messages
end
