json.challenges do
  json.date @challenge.date
  json.created_at @challenge.created_at
  json.updated_at @challenge.updated_at
  json.picture_url @challenge.picture_url
  json.user @challenge.user
  json.score @challenge.score
  json.sequence @challenge.sequence
  json.unique_path_id @challenge.unique_path_id
  json.picture_name @challenge.picture_name
end
