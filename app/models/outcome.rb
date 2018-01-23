class Outcome < ApplicationRecord
  belongs_to :challengee, primary_key: 'id', foreign_key: "challengee_id", class_name: "Challengee"
  belongs_to :score, primary_key: 'id', foreign_key: "score_id", class_name: "Score"
end
