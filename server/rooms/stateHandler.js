const { Room, Client } = require("colyseus")
const schema = require("@colyseus/schema")
const { Schema, MapSchema } = schema

 // module.exports.Player =
class Player extends Schema {
  x = Math.floor(Math.random() * 400);
  y = Math.floor(Math.random() * 400);
}
schema.defineTypes(Player, {
  x: "number",
  y: "number"
});

// module.exports.State =
class State extends Schema {
  constructor(){
    super();

    this.players = new MapSchema();
    this.test = 'hemlo';
  }

  something = "This attribute won't be sent to the client-side";

  createPlayer (id) {
    this.players[ id ] = new Player();
    this.players[ id ].x += 1000;
    console.log('added player', id)
  }

  removePlayer (id) {
    delete this.players[ id ];
    console.log('removed player', id)
  }

  movePlayer (id, movement) {
    if (movement.x) {
        this.players[ id ].x += movement.x * 10;

    } else if (movement.y) {
        this.players[ id ].y += movement.y * 10;
    }
  }

  updateTest(str){
    this.test = str
  }
}
schema.defineTypes(State, {
  players: { map: Player },
  test: "string"
});

module.exports.StateHandlerRoom = class StateHandlerRoom extends Room {
    maxClients = 10;

    onCreate (options) {
        console.log("StateHandlerRoom created!", options);

        this.setState(new State());

        this.onMessage("move", (client, data) => {
            console.log("StateHandlerRoom received message from", client.sessionId, ":", data);
            this.state.movePlayer(client.sessionId, data);
        });
        this.onMessage("updateTest", (client, data) => {
            console.log("StateHandlerRoom received message from", client.sessionId, ":", data);
            this.state.updateTest(client.sessionId + ":" + data);
        });
    }

    onAuth(client, options, req) {
        // console.log(req.headers.cookie);
        return true;
    }

    onJoin (client) {
        client.send("playerConnected", "hello");
        this.state.createPlayer(client.sessionId);

    }

    onLeave (client) {
        this.state.removePlayer(client.sessionId);
    }

    onDispose () {
        console.log("Dispose StateHandlerRoom");
    }

}
