class AddUuidToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :uuid, :string, null: false
    add_index :players, :uuid, unique: true
  end
end
