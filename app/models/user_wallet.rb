class UserWallet < ApplicationRecord
  belongs_to :user
  has_many :receive_transactions, class_name: 'Transaction', foreign_key: 'from_id'
  has_many :send_transactions, class_name: 'Transaction', foreign_key: 'to_id'
end
