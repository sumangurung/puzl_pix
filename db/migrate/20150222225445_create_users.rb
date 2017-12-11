class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fb_id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :uuid, null: false
      t.timestamps
    end

    add_index :users, :uuid, unique: true
    add_index :users, :username, unique: true
  end
end
