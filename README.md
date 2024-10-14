# README
* Ruby version
3.3.5

* System dependencies
sqlite3

* Configuration
copy `.env.erb` to `.env`

* Database initialization
run `rails db:migrate`

* Database Seeder
run `rails db:seed`

* Run the service
```cmd
rails server
```

# Endpoints
* Login
Path: /login
Method: POST
Body:
{
    "email": "alice@gmail.com",
    "password": "mysecretpass"
}


* Transactions
Path: /transactions
Method: POST
Body:
{
    "amount": 5.0,
    "from_id": 2,
    "to_id": 3
}