class CreateChallengeeTable < ActiveRecord::Migration[5.0]
  def change
    create_table :challengees do |t|
      t.string :user_uuid, null: false, unique: false
      t.string :unique_path_id, null: false, unique: false
      t.boolean :rewarded, null: false, default: false
      t.timestamps
    end

    add_index :challengees, [:user_uuid, :unique_path_id], unique: true
    add_index :challengees, :user_uuid
    add_index :challengees, :unique_path_id
  end
end
