Rails.application.config.after_initialize do
  Diary.cleanup_expired
end