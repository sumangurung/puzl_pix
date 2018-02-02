json.challenges do
  json.date @challenge.date
  json.created_at @challenge.created_at
  json.updated_at @challenge.updated_at
  json.picture_name @challenge.picture_name
  json.picture_url @challenge.picture_url
  json.thumb_name @challenge.thumb_name.nil? ? @challenge.picture_name : @challenge.thumb_name
  json.thumb_url @challenge.thumb_url.nil? ? @challenge.picture_url : @challenge.thumb_url
  json.user @challenge.user
  json.score @challenge.score
  json.sequence @challenge.sequence
  json.missing_square_number @challenge.missing_square_number
  json.unique_path_id @challenge.unique_path_id
end
