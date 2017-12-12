class CreateChallengeTable < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.date :date, null: false
      t.integer :user_id, null: false, unique: false
      t.integer :score_id, null: false, unique: false
      t.string :user_uuid, null: false, unique: false
      t.string :score_uuid, null: false, unique: false
      t.text :sequence, null: false
      t.string :missing_square_number, null: false
      t.string :unique_path_id, null: false, unique: true
      t.string :picture_name, null: false, unique:false
      t.string :picture_url, null: false

      t.timestamps
    end

    add_index :challenges, :unique_path_id
    add_index :challenges, :user_id
    add_index :challenges, :score_id
    add_index :challenges, :user_uuid
    add_index :challenges, :score_uuid
  end
end
