class Score < ActiveRecord::Base
  belongs_to :player, primary_key: 'uuid', foreign_key: "player_uuid", class_name: "Player"
  after_initialize :set_date

  def set_date
    self.date ||= Date.today
  end
end
