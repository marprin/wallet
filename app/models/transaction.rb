class Transaction < ApplicationRecord
  TRX_TYPE_WITHDRAWAL = 1
  TRX_TYPE_DEPOSIT = 2

  STATUS_FAIL = 1
  STATUS_DONE = 2

  validates :amount, presence: true
  validates :status, presence: true
  validates :trx_type, presence: true

  belongs_to :from_id, class_name: 'UserWallet'
  belongs_to :to_id, class_name: 'UserWallet'
end
