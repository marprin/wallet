class CreateUserWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :user_wallets do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
