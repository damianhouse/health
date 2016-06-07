# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

coach1 = Coach.create!(name: "Mike", password:"password", email: "coach@coach.com")
coach2 = Coach.create!(name: "Jim", password:"password", email: "coach2@coach.com")
coach3 = Coach.create!(name: "Asher", password:"password", email: "coach3@coach.com")
coach4 = Coach.create!(name: "Willy", password:"password", email: "coach4@coach.com")



user1 = User.create!(name: "Thomas", password: "password", email: "user@user.com", coach_id: coach1.id, coach_1: coach2.id, coach_2: coach3.id, coach_3: coach4.id)

conversation_user1 = Conversation.create!(user_id: user1.id, coach_id: coach1.id)
conversation_user2 = Conversation.create!(user_id: user1.id, coach_id: coach2.id)
conversation_user3 = Conversation.create!(user_id: user1.id, coach_id: coach3.id)
conversation_user4 = Conversation.create!(user_id: user1.id, coach_id: coach4.id)
message1 = Message.create!(user_id: user1.id, conversation_id: conversation_user1.id, body: "hi, hello!")
message2 = Message.create!(user_id: user1.id, conversation_id: conversation_user2.id, body: "hey hello!")
message3 = Message.create!(user_id: user1.id, conversation_id: conversation_user3.id, body: "hello there!")
message4 = Message.create!(user_id: user1.id, conversation_id: conversation_user4.id, body: "hello hello!")


user2 = User.create!(name: "2", password: "password", email: "user2@user.com", coach_id: coach1.id)
conversation2 = Conversation.create!(user_id: user2.id, coach_id: coach1.id)
message2 = Message.create!(user_id: user2.id, conversation_id: conversation2.id, body: "hello hello!")

user3 = User.create!(name: "3", password: "password", email: "user3@user.com", coach_id: coach1.id)
conversation3 = Conversation.create!(user_id: user3.id, coach_id: coach1.id)
message3 = Message.create!(user_id: user3.id, conversation_id: conversation3.id, body: "hello hello!")

user4 = User.create!(name: "4", password: "password", email: "user4@user.com", coach_id: coach2.id)
conversation4 = Conversation.create!(user_id: user4.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user1.id, conversation_id: conversation4.id, body: "hello hello!")

user5 = User.create!(name: "5", password: "password", email: "user5@user.com", coach_id: coach2.id)
conversation5 = Conversation.create!(user_id: user5.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user5.id, conversation_id: conversation5.id, body: "hello hello!")

user6 = User.create!(name: "6", password: "password", email: "user6@user.com", coach_id: coach2.id)
conversation6 = Conversation.create!(user_id: user6.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user6.id, conversation_id: conversation6.id, body: "hello hello!")


user7 = User.create!(name: "7", password: "password", email: "user7@user.com", coach_id: coach4.id)
conversation7 = Conversation.create!(user_id: user7.id, coach_id: coach2.id)
message1 = Message.create!(user_id: user6.id, conversation_id: conversation6.id, body: "hello hello!")



coach_1 = Coach.create!(name: "coach1", password:"password", email: "coach_1@coach.com")

user1 = User.create!(name: "one", password: "password", email: "user21@user.com", coach_1: coach_1.id)

user2 = User.create!(name: "two", password: "password", email: "user22@user.com", coach_2: coach_1.id)

user3 = User.create!(name: "three", password: "password", email: "user23@user.com", coach_3: coach_1.id)

user4 = User.create!(name: "four", password: "password", email: "user24@user.com", coach_4: coach_1.id)

user5 = User.create!(name: "five", password: "password", email: "user25@user.com", coach_id: coach_1.id)
