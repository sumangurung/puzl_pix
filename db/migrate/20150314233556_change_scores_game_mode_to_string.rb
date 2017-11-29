class ChangeScoresGameModeToString < ActiveRecord::Migration[5.0]
  def change
    change_column :scores, :game_mode, :string
    add_index :scores, :game_mode
  end
end
