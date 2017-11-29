class AddPlayerUuidToScores < ActiveRecord::Migration[5.0]
  def change
    add_column :scores, :player_uuid, :string, null: false
  end
end
