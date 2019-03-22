# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def initialize_users
  puts "\n-- #{User.count} users in database --\n"
  puts "Destroying all..."
  User.destroy_all
  puts "\n-- Done\n#{User.count} users in database --\n"
  puts "Creating users..."
  %w[alex arthur tristan nono jordon].each do |user|
    User.create! (
      {
      pseudo: user,
      email: "#{user}@gros.porc",
      password: "123456",
      }
    )
  end
  puts "All users created!"
  User.all.each { |user| puts user.pseudo }
  puts "\n-- #{User.count} users in database --\n"
end

def initialize_teams
  puts "\n-- #{Team.count} teams in database --\n"
  puts "Destroying all..."
  Team.destroy_all
  puts "\n-- Done\n#{Team.count} teams in database --\n"
  puts "Creating teams..."
  FootballScraper.new.initialize_teams
  puts "All teams created!"
  Team.all.each { |team| puts team.name }
  puts "\n-- #{Team.count} teams in database --\n"
end

def initialize_games
  puts "\n-- #{Game.count} games in database --\n"
  puts "Destroying all..."
  Game.destroy_all
  puts "\n-- Done\n#{Game.count} games in database --\n"
  puts "Creating games..."
  FootballScraper.new.initialize_games
  puts "All games created!"
  puts "\n-- #{Game.count} games in database --\n"
end

# initialize_users
# initialize_teams
# initialize_games
