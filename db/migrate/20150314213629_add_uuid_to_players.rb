class AddUuidToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :uuid, :string, null: false
    add_index :players, :uuid, unique: true
  end
end
