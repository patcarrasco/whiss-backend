# Documentation

## Routes

### Sign Up

**Path**: `/api/v1/sign-up`

#### Params

- `name: "John Mark Redding"`
- `username: "johnmark"`
- `password: "1notAnyThIng!"`

### Login

**Path**: `/api/v1/login`

#### Params

- `username: "johnmark"`
- `password: "1notAnyThIng!"`

### WS

**Path**: `/api/v1/cable`

#### Headers

- `"Authorization": "Bearer xxxx-token-xxxxx"`

---

## WS Channels

- `ChatChannel`
- `MessageChannel`
- `WisprChannel`

### Example
```js
//Example of a call.
const messageChannel = Cable.createConsumer(/*Channel Type String or Object*/, /*Channel Callbacks Object*/);

const action = {type: "NEW_MESSAGE", payload: {content: "Hey, what’s up?"}};
messageChannel.send(action);
```

### Actions

#### Chats
```js

/*Create*/
{
	type: "NEW_CHAT",
	payload: {
		title: "JM and Joe",
		members: /*User ID array*/ [1,2,3,5,393,7]
	}
}
/*Update*/
{
	type: "UPDATE_CHAT",
	payload: {
		id: 456,
		title: "JM and Joe",
		members: [1,2,3,5,393,7]
	}
}
/*Delete*/
{
	type: "DELETE_CHAT",
	payload: {
		id: 456
	}
}
```

#### Messages

```js
/*Create*/
{
	type: "NEW_MESSAGE",
	payload: {
		chat_id: 2,
		user_id: 1,
		content: "Hey, friend."
	}
}
/*Delete*/
{
	type: "DELETE_MESSAGE",
	payload: {
		id: 53
	}
}
```

#### Wisprs

```js
/*Create*/
{
	type: "NEW_WISPR",
	payload: {
		content: "Hey, friend."
	}
}
```

