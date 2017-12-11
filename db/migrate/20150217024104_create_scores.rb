class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.date :date
      t.integer :user_id
      t.integer :cols
      t.integer :rows
      t.integer :game_level
      t.integer :game_mode
      t.integer :moves
      t.integer :time
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
