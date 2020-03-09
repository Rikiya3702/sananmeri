class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_paranoid

  has_many :posts,     dependent: :destroy
  has_many :comments,  dependent: :destroy

  validates :nickname, presence: true,
                       length: {maximum: 50}
  validates :email,    presence: true,
                       length: {maximum: 50},
                       uniqueness: { case_sensitive: true }
end
