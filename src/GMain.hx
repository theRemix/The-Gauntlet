import js.Browser.document;
import js.html.DOMElement;
import js.html.InputElement;
import io.colyseus.Client;
import io.colyseus.Room;
import io.colyseus.serializer.schema.Schema;

class GState extends Schema {
  // messages server -> client
  public static inline var SERVER_CREATED = "SERVER_CREATED";

  // messages client -> server
  public static inline var CREATE_SERVER = "createServer";
  public static inline var SET_PLAYER_SCENE = "setPlayerScene";

	@:type("number")
	public var dummy:Int = 0;
}

class GMain {
  var roomClient:Client; // room controller, creates servers
  var gameClient:Client; // same room as players

  var servers_container:DOMElement;
  var server_address:DOMElement;
  var players_container:DOMElement;
  var players_table_container:DOMElement;
  var players_table:DOMElement;
  var controls_container:DOMElement;
  var status_container:DOMElement;
  var status:DOMElement;
  var server_address_input:InputElement;
  var create_server_btn:DOMElement;

  var server_name:String;

  function new() {
    document.addEventListener("DOMContentLoaded", init);

    roomClient = new Client('ws://localhost:3000');
    roomClient.joinOrCreate("room_controller", [], GState, onRoomJoinOrCreate);
  }

  // DOM ready
  function init(_) {
    servers_container = document.getElementById("servers_container");
    server_address = document.getElementById("server_address");
    players_container = document.getElementById("players_container");
    players_table_container = document.getElementById("players_table_container");
    players_table = document.getElementById("players_table");
    controls_container = document.getElementById("controls_container");
    status_container = document.getElementById("status_container");
    status = document.getElementById("status");
    server_address_input = cast(document.getElementById("server_address_input"), InputElement);
    create_server_btn = document.getElementById("create_server");

    servers_container.hidden = true;
    players_container.hidden = true;
    controls_container.hidden = true;

    status.innerText = "📡 Connecting to Room Controller";
  }

  // Colyseus ready
  function onRoomJoinOrCreate(err:io.colyseus.error.MatchMakeError, room:Room<GState>) {
    if (err != null) {
      status.innerText = err.message;
      trace("JOIN ERROR: " + err);
      return;
    }

    create_server_btn.onclick = function(_){
      if(server_name == "") return;
      status.innerText = "👷 Creating Server";
      room.send(GState.CREATE_SERVER, server_address_input.value);
    }

    servers_container.hidden = false;
    status.innerText = "✅ Connected to Room Controller!";

    room.onMessage(GState.SERVER_CREATED, function(address){
      server_address.innerText = address;
      server_address_input.hidden = true;
      create_server_btn.hidden = true;
      status.innerText = 'Server "$address" Created';

      switchToCreatedServer();
    });
  }

  function switchToCreatedServer(){
    status.innerText = "🖧  Connecting to Game State room";
    roomClient.joinOrCreate(server_address.innerText, [], State, onGameJoinOrCreate);
  }

  function onGameJoinOrCreate(err:io.colyseus.error.MatchMakeError, room:Room<State>) {
    if (err != null) {
      status.innerText = err.message;
      trace("JOIN ERROR: " + err);
      return;
    }

    players_container.hidden = false;
    controls_container.hidden = false;

    // create_server_btn.onclick = function(_){
    //   if(server_name == "") return;
    //   status.innerText = "👷 Creating Server";
    //   room.send(GState.CREATE_SERVER, server_address_input.value);
    // }

    status.innerText = '✅ Connected to Game State room!';

    // room.onMessage(GState.SERVER_CREATED, function(address){
    //   server_address.innerText = address;
    //   server_address_input.hidden = true;
    //   create_server_btn.hidden = true;
    //   status.innerText = 'Server "$address" Created';
    // });


    room.state.players.onAdd =
    room.state.players.onChange =
    room.state.players.onRemove = function updatePlayerList(player, key){
      var rows = players_table.getElementsByClassName("player_row");
      for(row in rows){
        players_table.removeChild(row);
      }

      for(player in room.state.players.items){
        createPlayerTableRow(players_table, player);
      }
    }
  }

  static function main() new GMain();


  static inline function createPlayerTableRow(table, player){
    var row = document.createElement("tr");
    var key = document.createElement("td");
    var alias = document.createElement("td");
    var pause = document.createElement("td");
    var connect = document.createElement("td");

    row.className = "player_row";
    key.innerText = player.key;
    alias.innerText = player.alias;

    row.append(key, alias, pause, connect);
    // row.appendChild(key);
    table.appendChild(row);
  }

}
