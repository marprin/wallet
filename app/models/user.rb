class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :salt, presence: true

  has_many :user_wallets
end
