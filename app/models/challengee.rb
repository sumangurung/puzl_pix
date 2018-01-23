class Challengee < ActiveRecord::Base
  belongs_to :challenge, primary_key: 'unique_path_id', foreign_key: "unique_path_id", class_name: "Challenge"
  belongs_to :user, primary_key: 'uuid', foreign_key: "user_uuid", class_name: "User"
  has_many :outcomes, -> { order(:created_at => :desc) },
    primary_key: 'id', foreign_key: "challengee_id", class_name: "Outcome"
end
