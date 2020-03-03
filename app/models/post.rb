class Post < ApplicationRecord
  validates :title,      length: {maximum: 99}
  validates :content,    length: {maximum: 1024}, presence: true
end
