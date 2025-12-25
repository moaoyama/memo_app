json.extract! diary, :id, :title, :body, :date, :created_at, :updated_at
json.url diary_url(diary, format: :json)
