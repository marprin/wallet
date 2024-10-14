class UserWallet < ApplicationRecord
  validates :type, presence: true
  validates :balance, presence: true

  belongs_to :user
  has_many :receive_transactions, class_name: 'Transaction', foreign_key: 'from_id'
  has_many :send_transactions, class_name: 'Transaction', foreign_key: 'to_id'

  # Scope section
  scope :internal, -> { where(type: 'InternalWallet') }
  scope :team, -> { where(type: 'TeamWallet') }
  scope :stock, -> { where(type: 'StockWallet') }

end
