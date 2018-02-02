json.challenges @challenges  do |challenge|
  json.date challenge.date
  json.picture_url challenge.picture_url
  json.thumb_url challenge.thumb_url.nil? ? challenge.picture_url : challenge.thumb_url 
  json.game_id challenge.game_id
end
