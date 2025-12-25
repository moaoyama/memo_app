namespace :diaries do
  desc "Delete expired auto_delete diaries"
  task delete_expired: :environment do
    Diary.expired_auto_delete.find_each(&:destroy)
  end
end