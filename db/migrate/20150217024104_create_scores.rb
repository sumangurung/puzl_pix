class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.date :date
      t.integer :cols, null: false
      t.integer :rows, null: false
      t.integer :game_level, null: false
      t.integer :game_mode, null: false
      t.integer :moves, null: false
      t.integer :time, null: false
      t.string :user_uuid, null: false
      t.string :uuid, null: false, unique: true

      t.timestamps
    end

    add_index :scores, :game_mode
    add_index :scores, :game_level
    add_index :scores, :uuid
    add_index :scores, :user_uuid
  end
end
