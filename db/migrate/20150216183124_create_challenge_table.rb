class CreateChallengeTable < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.date :date
      t.string :picture_url
      t.string :thumb_url
      t.string :game_id

      t.timestamps
    end
  end
end
