class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.date :date
      t.integer :player_id
      t.string :game_id
      t.integer :cols
      t.integer :rows
      t.integer :difficulty
      t.integer :game_mode
      t.integer :moves
      t.integer :time

      t.timestamps
    end
  end
end
