class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :fb_id
      t.string :first_name
      t.string :last_name
      t.string :username

      t.timestamps
    end
  end
end
