class Challenge < ActiveRecord::Base
  belongs_to :user, primary_key: 'id', foreign_key: "user_id", class_name: "User"
  belongs_to :score, primary_key: 'id', foreign_key: "score_id", class_name: "Score"
end
