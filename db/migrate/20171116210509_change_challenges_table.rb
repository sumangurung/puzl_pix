class ChangeChallengesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :player_id, :integer, null: false, unique: false
    add_column :challenges, :score_id, :integer, null: false, unique: true
    add_column :challenges, :sequence, :text, null: false
    add_column :challenges, :unique_path_id, :string, null: false, unique: true
    add_column(:challenges, :picture_name, :string, null: false, unique:false)

    change_column_null(:challenges, :date, false)
    change_column_null(:challenges, :picture_url, false)
    change_column_null(:challenges, :created_at, false)
    change_column_null(:challenges, :updated_at, false)

    add_index :challenges, :player_id
    add_index :challenges, :score_id

    remove_column :challenges, :game_id, :integer
    remove_column :challenges, :thumb_url, :string
  end
end
