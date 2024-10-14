class Transaction < ApplicationRecord
  TRX_TYPE_WITHDRAWAL = 1
  TRX_TYPE_DEPOSIT = 2
  TRX_TYPE_TRANSFER = 3

  STATUS_FAIL = 1
  STATUS_DONE = 2

  validates :amount, presence: true
  validates :status, presence: true
  validates :trx_type, presence: true

  belongs_to :user_wallet, foreign_key: 'from_id'
  belongs_to :user_wallet, foreign_key: 'to_id'
end
