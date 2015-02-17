json.scores @scores do |score|
  json.date score.date
  json.player_id score.player_id
  json.game_id score.game_id
  json.cols score.cols
  json.rows score.cols
  json.difficulty score.difficulty
  json.game_mode score.game_mode
  json.moves score.moves
  json.time score.time
end
