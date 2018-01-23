class Challenge < ActiveRecord::Base
  belongs_to :user, primary_key: 'id', foreign_key: "user_id", class_name: "User"
  belongs_to :score, primary_key: 'id', foreign_key: "score_id", class_name: "Score"
  has_many :challengees, -> { order(:created_at => :desc) },
    primary_key: 'unique_path_id', foreign_key: "unique_path_id", class_name: "Challengee"
end
