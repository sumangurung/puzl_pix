class Challenge < ActiveRecord::Base
  has_many :challengees, class_name: "Challengee"
  belongs_to :player, primary_key: 'id', foreign_key: "player_id", class_name: "Player"
  belongs_to :score, primary_key: 'id', foreign_key: "score_id", class_name: "Score"
end
