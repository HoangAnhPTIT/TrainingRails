### Training Rails
***
1. **Getting started**
*Project use Rails and MySql*

My project has 3 models include log, player, game.
- Player model contains infomation of player convering:
> username, password, fullname, point, wincount, losecount, status
- Game model contains infomation of each game when has request to start a game. 
> player1, player2, winner, status

When starting a game, the game model would save 2 ids of 2 players, winner was unknown who wins this game so `winner = 0` and `status = 1` express game is running. These variables will change after the request end game is called. This time we can determine who is the winner and `status = 0`
- Unlike the other model. The log model saves information of each action belong to players. 
> gameid, point1, point2, status

When you start a game, id's game is saved to this model, the current point of players is shown by point1 and point2. This model also has status, the feature of it same as the status in-game model.

2. **My project users JWT for authentication so if you want to send any request from POST MAN you must access**
```
post  'localhost:3000/api/auth/login'
```
It look like that:
![alt](https://drive.google.com/file/d/17M2CFXwd2QqB_03qx9htB_5VoPgpDdl-/view?usp=sharing)

Then in response, you will have a token. Use this token with Bearer for Authorization in any request in POSTMAN

3. **My project has some api:**
-   Create a user	  `post`    `localhost:3000/api/players`
-   Update a user `put/patch` `localhost:3000/api/players/`
-   Delete a user	`delete` `localhost:3000/api/players/`
-   Get all user info	 `get` `localhost:3000/api/players/`
-   Get single user info `get` `localhost:3000/api/players/:id`
-   Start a game `post` `localhost:3000/api/games`
-   Score a point for a player in a game	`post` `localhost:3000/api/games/:gameid/score`
-   Reset a point scored previously `delete` `localhost:3000/api/games/:gameid/reset_point`
-   End a game `put` `localhost:3000/api/games/:gameid/end`
-   Get game details `get` `localhost:3000/api/games/:gameid`
-   Get leaderboard	`get` `localhost:3000/api/leaderboard`
> Content-Type : application/json
3. **Description details for some request after authentication**
-  **Start a game**:  This request get player id which exists in the player model.
```
Request:
{
    "players" : {
        "A" : 3,
        "B" : 1,
    }
}

Response:
{ 
    "game": { 
        "id": 45,
        "players": [
            { "id": 3, "points": 0 },
            { "id": 1, "points": 0 }
        ],
        "winner": 0 
    } 
}
```

- **Score a point for a player in a game**: You must send the game's id present and id of the player win this session game. And the point of this player will be plus 10. Log table will be inserted in 1 row contain information of this session game.

```
Request:
{
    "player_id": 3
}

Response:
{ 
    "game": 
    { 
        "id": 45,
        "players": [
            { "id": 3, "points": 1 },
            { "id": 1, "points": 0 }
        ],
        "winner": 0 
    } 
}
```

- **Reset a point scored previously**: You can not reset a point in the game which was the end. The log table and point of player were specialized in the player table will be reverted. Data that was sent include the game's id and id of the player who you want to reset point.
 ```
Request:
{
    "player_id": 3
}

Response:
{ 
    "game": { 
        "id": 45,
        "players": [
            { "id": 3, "points": 0 },
            { "id": 1, "points": 0 }
        ],
        "winner": 0 ,
    } 
}
```

- **End a game**: When this request was called, the present game will end and. You only need to send the game's id.
```
Response:
{ 
    "game": { 
        "id": 45,
        "players": [
            { "id": 3, "points": 7 },
            { "id": 1, "points": 5 }], 
        "winner": 3 
    }
}
```

- **Get game details**: Send the game's id for this request so you will get details of this game.
```
Response:
{ 
    "game": { 
        "id": 45,
        "players": [
            { "id": 3, "points": 7 },
            { "id": 1, "points": 5 }
        ],
        "winner": 3 
    } 
}
```

-  **Get leaderboard**:  Return leaderboard !!!!
```
Response:
{ 
    "players": [
        {   "id": 3, "name": "Fer", "wins_count": 50, "loses_count": 3 },
        {   "id": 1, "name": "Adrian", "wins_count": 53, "loses_count": 10 },
        {   "id": 19, "name": "Chava", "wins_count": 45, "loses_count": 20 }
    ] 
}
```