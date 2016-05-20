json.array!(@messages) do |message|
  json.extract! message, :id, :body, :user_id, :conversation_id, :read
  json.url message_url(message, format: :json)
end
