json.pictures @pictures do |picture|
  json.first_name picture.first_name
  json.last_name picture.last_name
  json.location picture.location
  json.show_attribution picture.show_attribution
  json.release_datetime picture.release_datetime
  json.image_url picture.image.try(:url)
  json.thumb_url picture.image.try(:thumb).try(:url)
  json.created_at picture.created_at
  json.updated_at picture.updated_at
end
