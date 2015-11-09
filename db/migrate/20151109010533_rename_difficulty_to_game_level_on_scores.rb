class RenameDifficultyToGameLevelOnScores < ActiveRecord::Migration
  def change
    rename_column :scores, :difficulty, :game_level
  end
end
