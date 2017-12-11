json.scores @scores do |score|
  json.date score.date
  json.user_id score.user_id
  json.user_uuid score.user_uuid
  json.user_name score.user && score.user.username #delete this after a while - deprecated
  json.username score.user && score.user.username
  json.game_id score.game_id
  json.cols score.cols
  json.rows score.cols
  json.game_level score.game_level
  json.game_mode score.game_mode
  json.moves score.moves
  json.time score.time
end
