class Player < ActiveRecord::Base
  has_many :device_tokens, foreign_key: "fb_id"

  def add_device_token(token_attributes)
    device_tokens.create(token_attributes)
  end
end
