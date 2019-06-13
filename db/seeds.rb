# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create_with(password: 'password').find_or_create_by!(name: 'Ivan', email: 'test@example.com')

3.times do |_i|
  account = user.owned_accounts.find_or_create_by! name: 'test', metadata: { test: SecureRandom.hex(20) }
  3.times do
    account.boards.create_with_member!({ title: 'Test board', metadata: { test: SecureRandom.hex(20) } }, member: user)
  end
end
