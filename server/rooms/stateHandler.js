const { Room, Client } = require("colyseus")
const schema = require("@colyseus/schema")
const { Schema, ArraySchema, MapSchema } = schema

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

class SubSystem extends Schema {
  constructor(props){
    super();

    const { x, y, name, keys } = props;
    this.name = name;
    this.x = x;
    this.y = y;
    this.keys = new ArraySchema();
    keys.forEach(k => this.keys.push(k))
    this.owned = false;
    this.ownedBy = '';
    this.runners = new ArraySchema();
  }
}
schema.defineTypes(SubSystem, {
  name: "string",
  x: "number",
  y: "number",
  keys: ["string"],
  owned: "boolean",
  ownedBy: "string",
  runners: ["string"],
});

class State extends Schema {
  constructor(){
    super();

    this.players = new MapSchema();
    this.tutStep = new ArraySchema();
    this.practiceNet = createPracticeNet();
    this.realNet = createRealNet();
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

  setScene(sceneName) {
    this.scene = sceneName;
    // reset
    this.tutStep = new ArraySchema();
  }

  setTutStep(step, visible) {
    this.tutStep[step] = visible;
  }

  hackAttempt(mode, playerAlias, subsystem, program){
    let net;
    switch(mode){
      case "practice":
        net = this.practiceNet;
        break;
      case "real":
        net = this.realNet;
        break;
      default:
        console.warn('WARN: unknown mode:', mode)
        return;
    }

    let s = net.find((a) => a.name === subsystem);
    if(s == null){
      console.warn('WARN: could not find subsystem in net:', subsystem)
      return;
    }

    if(s.keys.includes(program)){
      s.owned = true;
      s.ownedBy = playerAlias;
    } else {
      if(!s.runners.includes(playerAlias))
        s.runners.push(playerAlias)
    }

  }


}
schema.defineTypes(State, {
  players: { map: Player },
  gm: Player,
	scene: "string",
	pauseOverlay: "string",
	tutStep: ["boolean"],
	practiceNet: [SubSystem],
	realNet: [SubSystem],
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

    this.onMessage("setScene", (client, sceneName) => {
      if(client.sessionId != this.state.gm.key)
        return console.warn('WARN: non GM attempted to run setScene');

      console.log("StateHandlerRoom setScene", sceneName);
      this.state.setScene(sceneName);
    });

    this.onMessage("setTutStep", (client, {step, value}) => {
      if(client.sessionId != this.state.gm.key)
        return console.warn('WARN: non GM attempted to run setTutStep');

      console.log("StateHandlerRoom setTutStep", step, value);
      this.state.setTutStep(step, value);
    });

    this.onMessage("hackAttempt", (client, {mode, playerAlias, subsystem, program}) => {
      if(!this.state.players[client.sessionId])
        return console.warn('WARN: hackAttempt, unknown client sessionId', client.sessionId);

      this.state.hackAttempt(mode, playerAlias, subsystem, program)
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

const createPracticeNet = () => {
  const a = new ArraySchema();
  [
    new SubSystem({x: 280, y: 100, name: "Database", keys: ["Firetoolz"]}),
    new SubSystem({x: 440, y: 100, name: "Admin Terminal", keys: ["Tron"]}),
    new SubSystem({x: 620, y: 100, name: "Data Vault", keys: ["Firetoolz"]}),
  ].forEach(b => a.push(b))
  return a;
}

const createRealNet = () => {
  const cols = [ 80, 325, 570, 815 ];
  const rows = [ 440, 330, 220, 110, 2 ];
  const a = new ArraySchema();
  [
    new SubSystem({x: cols[0], y: rows[0], name: "Mail Server", keys: []}),
    new SubSystem({x: cols[2], y: rows[0], name: "Proxy", keys: []}),
    new SubSystem({x: cols[3], y: rows[0], name: "VPN", keys: []}),
    new SubSystem({x: cols[0], y: rows[1], name: "Backup Server", keys: []}),
    new SubSystem({x: cols[1], y: rows[1], name: "Web Server", keys: []}),
    new SubSystem({x: cols[2], y: rows[1], name: "Router", keys: []}),
    new SubSystem({x: cols[3], y: rows[1], name: "Intranet svc", keys: []}),
    new SubSystem({x: cols[0], y: rows[2], name: "Domain Control", keys: []}),
    new SubSystem({x: cols[1], y: rows[2], name: "Web Database", keys: []}),
    new SubSystem({x: cols[2], y: rows[2], name: "Auth Control", keys: []}),
    new SubSystem({x: cols[3], y: rows[2], name: "R&D Beta svc", keys: []}),
    new SubSystem({x: cols[0], y: rows[3], name: "FIREWALL\nCONTROLLER", keys: []}),
    new SubSystem({x: cols[1], y: rows[3], name: "Admin Portal", keys: []}),
    new SubSystem({x: cols[2], y: rows[3], name: "Admin DB", keys: []}),
    new SubSystem({x: cols[3], y: rows[3], name: "AI/ML Control", keys: []}),
    new SubSystem({x: cols[2], y: rows[4], name: "ENCRYPTED\nDATA STORE", keys: []}),
    new SubSystem({x: cols[3], y: rows[4], name: "FIREWALL\nCONTROLLER", keys: []}),
  ].forEach(b => a.push(b))
  return a;
}
