class Player < ActiveRecord::Base
  has_many :device_tokens, foreign_key: "fb_id"

  def add_device_token(device_token)
    device_tokens.create(token: device_token)
  end
end
