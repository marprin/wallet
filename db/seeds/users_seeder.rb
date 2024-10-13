class UserSeeder
  def self.seed
    User.create([
      {
        name: "Alice", 
        email: "alice@gmail.com", 
        salt: "abcdef", 
        password: BCrypt::Password.create("mysecretpassabcdef"),
      }
    ])
  end
end
