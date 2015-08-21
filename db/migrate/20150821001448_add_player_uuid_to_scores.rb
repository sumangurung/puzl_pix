class AddPlayerUuidToScores < ActiveRecord::Migration
  def change
    add_column :scores, :player_uuid, :string, null: false
  end
end
