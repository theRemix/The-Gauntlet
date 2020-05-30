const { Room, Client } = require("colyseus")
const schema = require("@colyseus/schema")
const { Schema, MapSchema } = schema

class Player extends Schema {
  alias = null;
}
schema.defineTypes(Player, {
  alias: "string",
});

class State extends Schema {
  constructor(){
    super();

    this.players = new MapSchema();
    this.test = 'empty';
  }

  something = "This attribute won't be sent to the client-side";

  createPlayer (id) {
    this.players[ id ] = new Player();
    console.log('added player', id)
  }

  removePlayer (id) {
    delete this.players[ id ];
    console.log('removed player', id)
  }

  setAlias(id, alias) {
    console.log(1, this.players[ id ].alias, this.players[ id ])
    this.players[ id ].alias = alias;
    console.log(2, this.players[ id ].alias, this.players[ id ])
    // this.players[ id ].alias = 99;
    // this.test = alias;
  }

}
schema.defineTypes(State, {
  players: { map: Player },
  test: "string",
});

module.exports.StateHandlerRoom = class StateHandlerRoom extends Room {

  maxClients = 20;

  onCreate (options) {
    console.log("StateHandlerRoom created!", options);

    this.setSeatReservationTime(20)

    this.setState(new State());

    this.onMessage("setAlias", (client, alias) => {
      console.log("StateHandlerRoom setAlias", client.sessionId, ":", alias);
      this.state.setAlias(client.sessionId, alias);
      client.send("ALIAS_ENTERED");
    });
  }

  onAuth(client, options, req) {
    // console.log(req.headers.cookie);
    return true;
  }

  onJoin (client) {
    this.state.createPlayer(client.sessionId);
  }

  async onLeave (client, consented) {
    client.send("DISCONNECTED");

    // flag client as inactive for other users
    if(this.state.players.hasOwnProperty(client.sessionId)){
      this.state.players[client.sessionId].connected = false;
      try {
        if (consented) {
          this.state.removePlayer(client.sessionId);
          throw new Error("consented leave");
        }

        // allow disconnected client to reconnect into this room until 20 seconds
        await this.allowReconnection(client, 20);

        // client returned! let's re-activate it.
        this.state.players[client.sessionId].connected = true;

      } catch (e) {
        // 20 seconds expired. let's remove the client.
        this.state.removePlayer(client.sessionId);
      }
    }
  }

  onDispose () {
    console.log("Dispose StateHandlerRoom");
  }

}
