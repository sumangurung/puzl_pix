class Score < ActiveRecord::Base
  @@permitted_attributes = %i(uuid user_uuid user_id game_id cols rows
    date game_level game_mode moves time)

  def Score.permitted_attributes
    return @@permitted_attributes
  end

  belongs_to :user, primary_key: 'uuid', foreign_key: "user_uuid", class_name: "User"
  has_one :challenge, primary_key: 'id', foreign_key: "score_id", class_name: "Score"
  after_initialize :set_date

  def set_date
    self.date ||= Date.today
  end
end
