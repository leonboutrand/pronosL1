# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[alex arthur tristan nono jordon].each do |user|
  User.create! (
    {
    pseudo: user,
    email: "#{user}@kickmybets.fun",
    password: "azertyuiop",
    }
  )
end

puts "creating users"
puts User.select(:pseudo).join('')
puts "users created"
