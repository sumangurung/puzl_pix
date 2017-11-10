class ChangeScoresTable < ActiveRecord::Migration[5.0]
  def change
    add_column :scores, :uuid, :string, null: false, unique: true
  end
end
