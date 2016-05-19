json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :user_id, :coach_id, :active
  json.url conversation_url(conversation, format: :json)
end
