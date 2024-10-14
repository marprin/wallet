class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :from, null: false
      t.references :to, null: false
      t.decimal :amount, precision: 12, scale: 2

      t.timestamps
    end
    add_foreign_key :transactions, :user_wallets, column: :from_id
    add_foreign_key :transactions, :user_wallets, column: :to_id
  end
end
