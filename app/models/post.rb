class Post < ApplicationRecord
  belongs_to :user

  has_many :comments,  dependent: :destroy
  has_many :likeposts, dependent: :destroy
  validates :user_id,     presence: true
  validates :title,      length: {maximum: 99}
  validates :content,    length: {maximum: 1024}, presence: true
end
