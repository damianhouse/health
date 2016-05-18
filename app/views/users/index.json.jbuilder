json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :role, :coach_id, :coach_1, :coach_2, :coach_3, :coach_4
  json.url user_url(user, format: :json)
end
