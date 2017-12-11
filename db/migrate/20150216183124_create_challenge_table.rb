class CreateChallengeTable < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.date :date, null: false
      t.string :picture_url, null: false
      t.string :user_id, :integer, null: false, unique: false
      t.string :score_id, :integer, null: false, unique: true
      t.string :sequence, :text, null: false
      t.string :unique_path_id, :string, null: false, unique: true
      t.string :picture_name, :string, null: false, unique:false

      t.timestamps
    end

    add_index :challenges, :unique_path_id
    add_index :challenges, :user_id
    add_index :challenges, :score_id
  end
end
