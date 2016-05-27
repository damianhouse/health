json.array!(@notes) do |note|
  json.extract! note, :id, :user_id, :coach_id, :note_1, :note_2, :note_3, :note_4, :note_5, :note_6, :note_7, :note_8, :note_9, :note_10
  json.url note_url(note, format: :json)
end
