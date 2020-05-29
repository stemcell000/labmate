json.extract! user_attachment, :id, :created_at, :updated_at
json.url user_attachment_url(user_attachment, format: :json)
