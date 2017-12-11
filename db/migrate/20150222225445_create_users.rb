class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :uuid, null: false
      t.timestamps
    end

    add_index :users, :uuid, unique: true
    add_index :users, :username, unique: true
  end
end
