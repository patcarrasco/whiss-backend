# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Chat.destroy_all
Message.destroy_all



johnmark = User.create(name: "John Mark", username: "johnmark", password: "none")
patricio = User.create(name: "Patricio", username: "patricio", password: "none")
taimur = User.create(name: "Taimur", username: "taimur", password: "none")
samuel = User.create(name: "Samuel", username: "samuel", password: "none")

chat1 = Chat.create(sender_id:patricio.id, receiver_id:johnmark.id)
chat2 = Chat.create(sender_id:taimur.id, receiver_id:samuel.id)


Message.create(user_id: johnmark.id, content: "Hey.", chat_id: chat1.id)
Message.create(user_id: patricio.id, content: "Hey.", chat_id: chat1.id)
Message.create(user_id: taimur.id, content: "Hey.", chat_id: chat2.id)
Message.create(user_id: samuel.id, content: "Hey.", chat_id: chat2.id)