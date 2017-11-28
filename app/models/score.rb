class Score < ActiveRecord::Base
  @@permitted_attributes = %i(uuid player_uuid player_id game_id cols rows
    date game_level game_mode moves time gameLevel)

  def Score.permitted_attributes
    return @@permitted_attributes
  end

  belongs_to :player, primary_key: 'uuid', foreign_key: "player_uuid", class_name: "Player"
  after_initialize :set_date

  def set_date
    self.date ||= Date.today
  end
end
