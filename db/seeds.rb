# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Admin User', :email => 'user@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user.name
user1 = User.create! :name => 'No.1 User', :email => 'user1@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
user.follow!(user1)
puts 'New user created: ' << user1.name
user2 = User.create! :name => 'No.2 User', :email => 'user2@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
user.follow!(user2)
puts 'New user created: ' << user2.name
user3 = User.create! :name => 'No.3 User', :email => 'user3@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user3.name
user4 = User.create! :name => 'No.4 User', :email => 'user4@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user4.name
user5 = User.create! :name => 'No.5 User', :email => 'user5@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user5.name
user6 = User.create! :name => 'No.6 User', :email => 'user6@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user6.name
user7 = User.create! :name => 'No.7 User', :email => 'user7@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user7.name
user8 = User.create! :name => 'No.8 User', :email => 'user8@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user8.name
user9 = User.create! :name => 'No.9 User', :email => 'user9@example.com', :password => 'password', :password_confirmation => 'password', :confirmed_at => Time.now.utc
puts 'New user created: ' << user9.name

user.add_role :admin

puts 'SETTING UP DEFAULT LOCATIONS'
location = user.locations.create! :name => "beiing", :address => "beijing tian an men"
puts 'New location created: ' << location.address
location1 = user.locations.create! :name => "Houhai", :address => "Houhai"
puts 'New location created: ' << location1.address
location2 = user.locations.create! :name => "Castlefield Hotel Ltd", :address => "Liverpool Road, Manchester, Lancashire M3 4JR, United Kingdom"
puts 'New location created: ' << location2.address
location3 = user1.locations.create! :name => "tianjin", :address => "tianjin da ma hua"
puts 'New location created: ' << location3.address
location4 = user1.locations.create! :name => "Preston's Candy and Ice Cream", :address => "1170 Broadway, Burlingame, CA 94010"
puts 'New location created: ' << location4.address

puts 'SETTING UP DEFAULT SCHEMES'
scheme = Scheme.create! :content => "Read Animal Farm", :user_id => user.id
user.do!(scheme)
user1.done!(scheme)
puts 'New scheme created: ' << scheme.content
scheme1 = Scheme.create! :content => "try the cheese ramen at Tukumo", :user_id => user.id
user.do!(scheme1)
user1.do!(scheme1)
puts 'New scheme created: ' << scheme1.content