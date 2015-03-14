class ChangeScoresGameModeToString < ActiveRecord::Migration
  def change
    change_column :scores, :game_mode, :string
    add_index :scores, :game_mode
  end
end
