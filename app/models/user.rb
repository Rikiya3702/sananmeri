class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_paranoid
  validates :nickname, presence: true,
                       length: {maximum: 50}
  validates :email,    presence: true,
                       length: {maximum: 50},
                       uniqueness: { case_sensitive: true }
end
