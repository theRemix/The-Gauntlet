const { Room, Client } = require("colyseus")
const schema = require("@colyseus/schema")
const { Schema, MapSchema } = schema

class Player extends Schema {
}
schema.defineTypes(Player, {
  key: "string",
  alias: "string",
  hacking: "number",
  sysops: "number",
  skullduggery: "number",
  intellect: "number",
});

class State extends Schema {
  constructor(){
    super();

    this.players = new MapSchema();
  }

  something = "This attribute won't be sent to the client-side";

  createPlayer (id) {
    this.players[ id ] = new Player();
    this.players[ id ].key = id;

    // if this is the first player created, make GM
    if(Object.keys(this.players).length == 1){
      console.log('setting GM to', id);
      this.gm = this.players[ id ]
      this.gm.alias = "GM";
    }
  }

  removePlayer (id) {
    delete this.players[ id ];
    console.log('removed player', id)
  }

  setAliasAndStats(id, aliasAndStats) {
    this.players[ id ].alias = aliasAndStats.alias;
    this.players[ id ].hacking = parseInt(aliasAndStats.hacking);
    this.players[ id ].sysops = parseInt(aliasAndStats.sysops);
    this.players[ id ].skullduggery = parseInt(aliasAndStats.skullduggery);
    this.players[ id ].intellect = parseInt(aliasAndStats.intellect);
  }

}
schema.defineTypes(State, {
  players: { map: Player },
  gm: Player,
});

module.exports.StateHandlerRoom = class StateHandlerRoom extends Room {

  maxClients = 20;

  onCreate (options) {
    console.log("StateHandlerRoom created!", options);

    this.setSeatReservationTime(40)

    this.setState(new State());

    this.onMessage("setAliasAndStats", (client, aliasAndStats) => {
      console.log("StateHandlerRoom setAlias", client.sessionId, ":", aliasAndStats);
      this.state.setAliasAndStats(client.sessionId, aliasAndStats);
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

  onLeave (client, consented) {
    console.log("user disconnected", client.sessionId, 'consented', consented);
    this.state.removePlayer(client.sessionId);

  // async onLeave (client, consented) {
    // // flag client as inactive for other users
    // if(this.state.players.hasOwnProperty(client.sessionId)){
    //   this.state.players[client.sessionId].connected = false;
    //   try {
    //     if (consented) {
    //       this.state.removePlayer(client.sessionId);
    //       throw new Error("consented leave");
    //     }

    //     // allow disconnected client to reconnect into this room until 20 seconds
    //     await this.allowReconnection(client, 20);

    //     // client returned! let's re-activate it.
    //     this.state.players[client.sessionId].connected = true;

    //   } catch (e) {
    //     // 20 seconds expired. let's remove the client.
    //     this.state.removePlayer(client.sessionId);
    //   }
    // }
  }

  onDispose () {
    // console.log("Broadcasting DISCONNECTED");
    // this.broadcast("DISCONNECTED"); // not handled yet
    console.log("Dispose StateHandlerRoom");
  }

}
