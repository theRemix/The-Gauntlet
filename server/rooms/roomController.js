const { Room, Client } = require("colyseus")
const schema = require("@colyseus/schema")
const { Schema, MapSchema } = schema
const { StateHandlerRoom } = require('./stateHandler')

class State extends Schema {
  constructor(){
    super();
  }
}
schema.defineTypes(State, {

});

module.exports.RoomController = class RoomController extends Room {

  maxClients = 10;

  onCreate (options) {
    console.log("RoomController created!", options);

    this.setSeatReservationTime(20)

    this.setState(new State());

    this.onMessage("createServer", (client, address) => {
      console.log("StateHandlerRoom createServer", client.sessionId, ":", address);
      RoomController.gameServer.define(address, StateHandlerRoom).enableRealtimeListing()
      // client.send("ALIAS_ENTERED");
    });
  }

  onAuth(client, options, req) {
    // console.log(req.headers.cookie);
    return true;
  }

  onJoin (client) {
    // this.state.createPlayer(client.sessionId);
  }

  async onLeave (client, consented) {
    client.send("DISCONNECTED, RECONNECTING");

    await this.allowReconnection(client, 30);

    client.send("RECONNECTING");
  }

  onDispose () {
    console.log("Dispose RoomController");
  }

}
