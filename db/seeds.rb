# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

coach1 = Coach.create!(name: "1", password:"password", email: "coach@coach.com")
coach2 = Coach.create!(name: "2", password:"password", email: "coach2@coach.com")

user1 = User.create!(name: "1", password: "password", email: "user@user.com", coach_id: coach1.id)
conversation1 = Conversation.create!(user_id: user1.id, coach_id: coach1.id)
message1 = Message.create!(user_id: user1.id, conversation_id: conversation1.id, body: "hello hello!")

user2 = User.create!(name: "2", password: "password", email: "user2@user.com", coach_id: coach1.id)
conversation2 = Conversation.create!(user_id: user2.id, coach_id: coach1.id)
message2 = Message.create!(user_id: user2.id, conversation_id: conversation2.id, body: "hello hello!")

user3 = User.create!(name: "3", password: "password", email: "user3@user.com", coach_id: coach1.id)
conversation3 = Conversation.create!(user_id: user3.id, coach_id: coach1.id)
message3 = Message.create!(user_id: user3.id, conversation_id: conversation3.id, body: "hello hello!")

user4 = User.create!(name: "4", password: "password", email: "user4@user.com", coach_id: coach2.id)
conversation4 = Conversation.create!(user_id: user4.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user1.id, conversation_id: conversation1.id, body: "hello hello!")

user5 = User.create!(name: "5", password: "password", email: "user5@user.com", coach_id: coach2.id)
conversation5 = Conversation.create!(user_id: user5.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user5.id, conversation_id: conversation5.id, body: "hello hello!")

user6 = User.create!(name: "6", password: "password", email: "user6@user.com", coach_id: coach2.id)
conversation6 = Conversation.create!(user_id: user6.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user6.id, conversation_id: conversation6.id, body: "hello hello!")
