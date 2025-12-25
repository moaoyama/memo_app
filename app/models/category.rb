class Category < ApplicationRecord
  has_many :diaries, dependent: :nullify
end
