class UserWalletSeeder
  def self.seed
    alice = User.find_by(email: "alice@gmail.com")
    if alice
      alice.user_wallets.create(type: "InternalWallet", balance: 150000.00)
      alice.user_wallets.create(type: "StockWallet", balance: 297.00)
    end

    bob = User.find_by(email: "bob@gmail.com")
    if bob
      bob.user_wallets.create(type: "InternalWallet", balance: 75000.00)
      bob.user_wallets.create(type: "StockWallet", balance: 887.00)
      bob.user_wallets.create(type: "TeamWallet", balance: 0.00)
    end
  end
end
