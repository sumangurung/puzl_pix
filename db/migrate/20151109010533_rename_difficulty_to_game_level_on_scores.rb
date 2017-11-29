class RenameDifficultyToGameLevelOnScores < ActiveRecord::Migration[5.0]
  def change
    rename_column :scores, :difficulty, :game_level
  end
end
