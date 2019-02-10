# Resetting Database Instances
User.destroy_all
UserChat.destroy_all
Chat.destroy_all
Message.destroy_all


# Creating Users
johnmark = User.create(name: "John Mark", username: "johnmark", password: "none")
patricio = User.create(name: "Patricio", username: "patricio", password: "none")
taimur = User.create(name: "Taimur", username: "taimur", password: "none")
samuel = User.create(name: "Samuel", username: "samuel", password: "none")


# Creating Chats
chat1 = Chat.create(title: "Taimur and Samuel")
chat2 = Chat.create(title: "JM and Pat")
chat3 = Chat.create(title: "John Mark, Patricio, Taimur, and Samuel")


# Adding Members
# Chat 1 - Sam, Tai
UserChat.create(user_id: samuel.id, chat_id: chat1.id)
UserChat.create(user_id: taimur.id, chat_id: chat1.id)

# Chat 2 - JM, Pat
UserChat.create(user_id: johnmark.id, chat_id: chat2.id)
UserChat.create(user_id: patricio.id, chat_id: chat2.id)

# Chat 3 - JM, Pat, Sam, Tai
UserChat.create(user_id: johnmark.id, chat_id: chat3.id)
UserChat.create(user_id: patricio.id, chat_id: chat3.id)
UserChat.create(user_id: samuel.id, chat_id: chat3.id)
UserChat.create(user_id: taimur.id, chat_id: chat3.id)


# Creating Messages
# Chat 1
Message.create(user_id: johnmark.id, content: "Hey.", chat_id: chat1.id)
Message.create(user_id: patricio.id, content: "Hey.", chat_id: chat1.id)

# Chat 2
Message.create(user_id: taimur.id, content: "Hey.", chat_id: chat2.id)
Message.create(user_id: samuel.id, content: "Hey.", chat_id: chat2.id)

# Chat 3
Message.create(user_id: johnmark.id, content: "Hey.", chat_id: chat3.id)
Message.create(user_id: patricio.id, content: "Hey.", chat_id: chat3.id)
Message.create(user_id: taimur.id, content: "Hey.", chat_id: chat3.id)
Message.create(user_id: samuel.id, content: "Hey.", chat_id: chat3.id)








