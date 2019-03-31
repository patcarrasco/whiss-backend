# Resetting Database Instances
User.destroy_all
UserChat.destroy_all
Chat.destroy_all
Message.destroy_all
Friendship.destroy_all
Request.destroy_all


# Creating Users
johnmark = User.create(name: "John Mark", username: "johnmark", password: "none")
patricio = User.create(name: "Patricio", username: "patricio", password: "none")
taimur = User.create(name: "Taimur", username: "taimur", password: "none")
samuel = User.create(name: "Samuel", username: "samuel", password: "none")


# Creating Chats
chat1 = Chat.create(title: "JM and Pat")
chat2 = Chat.create(title: "Taimur and Samuel")
chat3 = Chat.create(title: "John Mark, Patricio, Taimur, and Samuel")


Friendship.create(friend1_id: johnmark.id, friend2_id: patricio.id)
Friendship.create(friend1_id: johnmark.id, friend2_id: taimur.id)
Friendship.create(friend1_id: samuel.id, friend2_id: johnmark.id)
Friendship.create(friend1_id: samuel.id, friend2_id: patricio.id)
Friendship.create(friend1_id: taimur.id, friend2_id: samuel.id)
Friendship.create(friend1_id: patricio.id, friend2_id: taimur.id)


# Adding Members
# Chat 1 - JM, Pat
UserChat.create(user_id: johnmark.id, chat_id: chat1.id)
UserChat.create(user_id: patricio.id, chat_id: chat1.id)

# Chat 2 - Sam, Tai
UserChat.create(user_id: samuel.id, chat_id: chat2.id)
UserChat.create(user_id: taimur.id, chat_id: chat2.id)

# Chat 3 - JM, Pat, Sam, Tai
UserChat.create(user_id: johnmark.id, chat_id: chat3.id)
UserChat.create(user_id: patricio.id, chat_id: chat3.id)
UserChat.create(user_id: samuel.id, chat_id: chat3.id)
UserChat.create(user_id: taimur.id, chat_id: chat3.id)


# Creating Messages
# Chat 1
Message.create(user_id: johnmark.id, content: "JM in Chat 1", chat_id: chat1.id)
Message.create(user_id: patricio.id, content: "Pat in Chat 1", chat_id: chat1.id)

# Chat 2
Message.create(user_id: taimur.id, content: "Tai in Chat 2", chat_id: chat2.id)
Message.create(user_id: samuel.id, content: "Sam in Chat 2", chat_id: chat2.id)

# Chat 3
Message.create(user_id: johnmark.id, content: "JM in Chat 3", chat_id: chat3.id)
Message.create(user_id: patricio.id, content: "Pat in Chat 3", chat_id: chat3.id)
Message.create(user_id: taimur.id, content: "Tai in Chat 3", chat_id: chat3.id)
Message.create(user_id: samuel.id, content: "Sam in Chat 3", chat_id: chat3.id)

# Creating Wisprs
Wispr.create(user_id: johnmark.id, content: "Hey, Wispr, from JM")
Wispr.create(user_id: patricio.id, content: "Hey, Wispr, from Patricio")
Wispr.create(user_id: taimur.id, content: "Hey, Wispr, from Taimur")
Wispr.create(user_id: samuel.id, content: "Hey, Wispr, from Samuel")








