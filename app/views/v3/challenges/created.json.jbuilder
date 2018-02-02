json.challenges @challenges do |challenge|
  json.id challenge.id
  json.user challenge.user
  json.unique_path_id challenge.unique_path_id
  json.picture_name challenge.picture_name
  json.picture_url challenge.picture_url
  json.thumb_name challenge.thumb_name
  json.thumb_url challenge.thumb_url
  json.created_at challenge.created_at
  json.score challenge.score
  json.challengees challenge.challengees do |challengee|
    json.created_at challengee.created_at
    json.rewarded challengee.rewarded
    json.unique_path_id challengee.unique_path_id
    json.user challengee.user
    json.outcomes challengee.outcomes do |outcome|
      json.score outcome.score
    end
  end
end
