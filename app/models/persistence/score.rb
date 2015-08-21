module Persistence
  class Score < ActiveRecord::Base
    belongs_to :player, primary_key: 'uuid', foreign_key: "player_uuid", class_name: "Player"
  end
end
