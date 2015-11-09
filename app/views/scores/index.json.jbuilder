json.scores @scores do |score|
  json.date score.date
  json.player_id score.player_id
  json.player_uuid score.player_uuid
  json.player_name score.player && score.player.username #delete this after a while - deprecated
  json.username score.player && score.player.username
  json.game_id score.game_id
  json.cols score.cols
  json.rows score.cols
  json.game_level score.game_level
  json.game_mode score.game_mode
  json.moves score.moves
  json.time score.time
end
