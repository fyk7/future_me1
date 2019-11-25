# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.create!(
    email: 'admin@example.com', 
    password: 'password', 
    password_confirmation: 'password')

  User.create!(
    name: 'テストユーザー',
    email: 'test@testuser1.com',
    password: 'password',
    password_confirmation: 'password',
    user_category: '1'
  )
end
User.create!(name: 'テストユーザー7', email: 'test@testuser7.com', password: 'passwordd', password_confirmation: 'passwordd', user_category: 1)
