class User < ActiveRecord::Base
  # has_many :device_tokens, foreign_key: "fb_id"
  has_many :challenges, primary_key: 'id', foreign_key: "user_id", class_name: "Challenge"
  has_many :challengees, primary_key: 'uuid', foreign_key: "user_uuid", class_name: "Challengee"
  has_many :scores, primary_key: 'uuid', foreign_key: "user_uuid", class_name: "Score"
  validates :username, uniqueness: true, presence: true

  def add_device_token(device_token)
    device_tokens.create(token: device_token)
  end

  def name
    if first_name.present? || last_name.present?
      [first_name, last_name].join(" ")
    else
      "User #{id}"
    end
  end
end
