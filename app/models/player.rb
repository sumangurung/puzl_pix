class Player < ActiveRecord::Base
  has_many :device_tokens, foreign_key: "fb_id"
  has_many :scores, primary_key: 'uuid', foreign_key: "player_uuid", class_name: "Persistence::Score"
  validates :username, uniqueness: true, presence: true

  def add_device_token(device_token)
    device_tokens.create(token: device_token)
  end

  def name
    if first_name.present? || last_name.present?
      [first_name, last_name].join(" ")
    else
      "Player #{id}"
    end
  end
end
