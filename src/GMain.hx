import js.Browser.document;
import js.html.DOMElement;
import js.html.FormElement;
import js.html.InputElement;
import io.colyseus.Client;
import io.colyseus.Room;
import io.colyseus.serializer.schema.Schema;

using StringTools;

class GMain {
  var client:Client;

  var servers_container:DOMElement;
  var server_address:DOMElement;
  var players_container:DOMElement;
  var players_table_container:DOMElement;
  var players_table:DOMElement;
  var controls_container:DOMElement;
  var status_container:DOMElement;
  var status:DOMElement;
  var server_address_input:InputElement;
  var create_server_form:FormElement;

  function new() {
    document.addEventListener("DOMContentLoaded", init);

    client = new Client('ws://localhost:3000');
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
    create_server_form = cast(document.getElementById("create_server_form"), FormElement);

    server_address.hidden = true;
    players_container.hidden = true;
    controls_container.hidden = true;

    // status.innerText = "📡 Connecting to Room Controller";
    // status.innerText = "✅ Connected to Room Controller!";
    // status.innerText = "🖧  Connecting to Game State room";
    // status.innerText = '✅ Connected to Game State room!';

    create_server_form.reset();

    server_address_input.onchange = function(e){
      server_address.innerText = e.currentTarget.value.trim();
    }
    create_server_form.onsubmit = function(e){
      e.preventDefault();
      if(server_address.innerText.length == 0){
        status.innerText = "❌ You must enter a server address";
        e.currentTarget.reset();
        return;
      }
      server_address.innerText = server_address.innerText.trim();
      status.innerText = "👷 Creating Server";
      client.create(State.COLYSEUS_ROOM, [State.SERVER_ADDRESS => server_address.innerText], State, onRoomCreate);
    }

  }

  // Colyseus ready
  function onRoomCreate(err:io.colyseus.error.MatchMakeError, room:Room<State>) {
    if (err != null) {
      status.innerText = err.message;
      trace("JOIN ERROR: " + err);
      return;
    }

    create_server_form.hidden = true;
    server_address.hidden = false;
    players_container.hidden = false;
    controls_container.hidden = false;
    status.innerText = 'Server "${server_address.innerText}" Created';

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
