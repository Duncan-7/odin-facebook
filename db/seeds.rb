# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Duncan",
             email: "duncan@duncan.com",
             password:              "foobar",
             password_confirmation: "foobar",
             )

User.create!(name:  "Cordelia",
             email: "cordi@cordi.com",
             password:              "foobar",
             password_confirmation: "foobar",
             )

User.create!(name:  "Willis",
             email: "willis@willis.com",
             password:              "foobar",
             password_confirmation: "foobar",
             )

User.first.posts.create!(content: "Duncan's post 1")

User.first.posts.create!(content: "Duncan's post 2",
created_at: (Time.now - 3400))
                    
User.second.posts.create!(content: "Cordelia's post 1")

User.second.posts.create!(content: "Cordelia's post 2",
created_at: (Time.now - 3500))

User.third.posts.create!(content: "Willis's post 1")

User.third.posts.create!(content: "Willis's post 2",
created_at: (Time.now - 3600))

Friendship.create!(user_id: 1,
friend_id: 2)
