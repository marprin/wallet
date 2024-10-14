class Transaction < ApplicationRecord
  belongs_to :from_id, class_name: 'UserWallet'
  belongs_to :to_id, class_name: 'UserWallet'
end
