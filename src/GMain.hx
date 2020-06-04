import js.Browser.document;
import js.Browser.window;
import js.html.DOMElement;
import js.html.InputElement;
import js.html.SelectElement;
import js.html.FormElement;
import io.colyseus.Client;
import io.colyseus.Room;
import io.colyseus.serializer.schema.Schema;

class GState extends Schema {
  // messages server -> client
  public static inline var SERVER_CREATED = "SERVER_CREATED";

  // messages client -> server
  public static inline var CREATE_SERVER = "createServer";
  public static inline var SET_PLAYER_SCENE = "setPlayerScene";
  public static inline var SET_SCENE = "setScene";
  public static inline var SET_TUT_STEP = "setTutStep";
  public static inline var SET_TIMER = "setTimer";
  public static inline var PAUSE = "pause";
  public static inline var UNPAUSE = "unpause";

	@:type("number")
	public var dummy:Int = 0;
}

class GMain {
  var client:Client; // room controller, creates servers

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

  var sim_running:InputElement;
  var sim_pause_dim:InputElement;
  var sim_pause_dark:InputElement;
  var cur_scene:SelectElement;
  var scene_tut1_controls:DOMElement;
  var scene_tut1_control_inputs:Array<InputElement>;
  var scene_tut2_controls:DOMElement;
  var scene_tut2_control_inputs:Array<InputElement>;
  var scene_tut3_controls:DOMElement;
  var scene_tut3_control_inputs:Array<InputElement>;

  var current_timer:DOMElement;
  var scene_sim_base_controls:DOMElement;
  var timer_form:FormElement;
  var timer_seconds_input:InputElement;

  var server_name:String;

  function new() {
    document.addEventListener("DOMContentLoaded", init);

    client = new Client('ws://localhost:3000');
    client.joinOrCreate("room_controller", [], GState, onRoomJoinOrCreate);
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

    sim_running = cast(document.getElementById("sim_running"), InputElement);
    sim_pause_dim = cast(document.getElementById("sim_pause_dim"), InputElement);
    sim_pause_dark = cast(document.getElementById("sim_pause_dark"), InputElement);
    cur_scene = cast(document.getElementById("cur_scene"), SelectElement);
    scene_tut1_controls = document.getElementById("scene_tut1_controls");
    scene_tut1_control_inputs = [
      cast(document.getElementById("scene_tut1_controls_1"), InputElement),
      cast(document.getElementById("scene_tut1_controls_2"), InputElement),
      cast(document.getElementById("scene_tut1_controls_3"), InputElement),
      cast(document.getElementById("scene_tut1_controls_4"), InputElement),
      cast(document.getElementById("scene_tut1_controls_5"), InputElement),
    ];
    scene_tut2_controls = document.getElementById("scene_tut2_controls");
    scene_tut2_control_inputs = [
      cast(document.getElementById("scene_tut2_controls_1"), InputElement),
      cast(document.getElementById("scene_tut2_controls_2"), InputElement),
      cast(document.getElementById("scene_tut2_controls_3"), InputElement),
      cast(document.getElementById("scene_tut2_controls_4"), InputElement),
      cast(document.getElementById("scene_tut2_controls_5"), InputElement),
      cast(document.getElementById("scene_tut2_controls_6"), InputElement),
      cast(document.getElementById("scene_tut2_controls_7"), InputElement),
      cast(document.getElementById("scene_tut2_controls_8"), InputElement),
    ];
    scene_tut3_controls = document.getElementById("scene_tut3_controls");
    scene_tut3_control_inputs = [
      cast(document.getElementById("scene_tut3_controls_1"), InputElement),
      cast(document.getElementById("scene_tut3_controls_2"), InputElement),
      cast(document.getElementById("scene_tut3_controls_3"), InputElement),
      cast(document.getElementById("scene_tut3_controls_4"), InputElement),
      cast(document.getElementById("scene_tut3_controls_5"), InputElement),
      cast(document.getElementById("scene_tut3_controls_6"), InputElement),
      cast(document.getElementById("scene_tut3_controls_7"), InputElement),
      cast(document.getElementById("scene_tut3_controls_8"), InputElement),
    ];
    current_timer = document.getElementById("current_timer");
    scene_sim_base_controls = document.getElementById("scene_sim_base_controls");
    timer_form = cast(document.getElementById("timer_form"), FormElement);
    timer_seconds_input = cast(document.getElementById("timer_seconds_input"), InputElement);

    server_address.hidden =
    servers_container.hidden =
    players_container.hidden =
    controls_container.hidden =
    scene_tut1_controls.hidden =
    scene_tut2_controls.hidden =
    scene_tut3_controls.hidden =
    scene_sim_base_controls.hidden = true;

    status.innerText = "📡 Connecting to Room Controller";

    // FAST DEV
    // onGameJoinOrCreate(null, new Room<State>("dummy", State));
  }

  // Colyseus ready
  function onRoomJoinOrCreate(err:io.colyseus.error.MatchMakeError, room:Room<GState>) {
    if (err != null) {
      status.innerText = err.message;
      trace("JOIN ERROR: " + err);
      return;
    }

    servers_container.hidden = false;
    create_server_form.reset();
    status.innerText = "✅ Connected to Room Controller!";

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

      status.innerText = "👷 Creating Server";
      room.send(GState.CREATE_SERVER, server_address_input.value);
    }


    // room.onMessage(State.DISCONNECTED, function(_){
    //   js.Browser.alert("Server Disconnected! Will reload the browser.");
    //   document.location.reload();
    // });

    room.onMessage(GState.SERVER_CREATED, function(address){
      server_address.innerText = address;
      server_address_input.hidden = true;
      create_server_form.hidden = true;
      status.innerText = 'Server "$address" Created';

      switchToCreatedServer();
    });
  }

  function switchToCreatedServer(){
    status.innerText = "🖧  Connecting to Game State room";

    client.joinOrCreate(server_address.innerText, [], State, onGameJoinOrCreate);
  }

  function onGameJoinOrCreate(err:io.colyseus.error.MatchMakeError, room:Room<State>) {
    if (err != null) {
      status.innerText = err.message;
      trace("JOIN ERROR: " + err);
      return;
    }

    players_container.hidden = false;
    controls_container.hidden = false;
    server_address.hidden = false;

    status.innerText = '✅ Connected to Game State room!';

    // room.state.players.onAdd =

    // FAST DEV START
    room.state.players.onChange = function updatePlayerList(player, key){
      var rows = players_table.getElementsByClassName("player_row");
      for(row in rows){
        players_table.removeChild(row);
      }

      for(player in room.state.players.items){
        createPlayerTableRow(players_table, player);
      }
    }
    room.state.players.onRemove = function removePlayerList(player, key){
      var rows = players_table.getElementsByClassName("player_row");
      for(row in rows){
        var keyCols = row.getElementsByClassName("player_key");
        for(keyCol in keyCols){
          if(keyCol.innerText == key)
            players_table.removeChild(row);
        }
      }

    }
    // FAST DEV END

    room.state.onChange = function roomOnChange(changes){
      for(change in changes){
        switch(change.field){
          case "timer":
            current_timer.innerText = change.value;
        }
      }
    }


    // CONTROLS
    sim_running.onclick = function(_){
      room.send(GState.UNPAUSE);
    }
    sim_pause_dim.onclick = function(_){
      room.send(GState.PAUSE, "dim");
    }
    sim_pause_dark.onclick = function(_){
      room.send(GState.PAUSE, "dark");
    }
    cur_scene.onchange = function(e){
      room.send(GState.SET_SCENE, e.target.value);

      switch(e.target.value){
        case "Lobby":
          scene_tut1_controls.hidden =
          scene_tut2_controls.hidden =
          scene_tut3_controls.hidden =
          scene_sim_base_controls.hidden = true;
        case "Tut1":
          scene_tut2_controls.hidden =
          scene_tut3_controls.hidden =
          scene_sim_base_controls.hidden = true;
          scene_tut1_controls.hidden = false;
        case "Tut2":
          scene_tut1_controls.hidden =
          scene_tut3_controls.hidden =
          scene_sim_base_controls.hidden = true;
          scene_tut2_controls.hidden = false;
        case "Tut3":
          scene_tut1_controls.hidden =
          scene_tut2_controls.hidden =
          scene_sim_base_controls.hidden = true;
          scene_tut3_controls.hidden = false;
        case "Practice":
          scene_tut1_controls.hidden =
          scene_tut2_controls.hidden =
          scene_tut3_controls.hidden = true;
          scene_sim_base_controls.hidden = false;
        case "RealNet":
          scene_tut1_controls.hidden =
          scene_tut2_controls.hidden =
          scene_tut3_controls.hidden = true;
          scene_sim_base_controls.hidden = false;
      }

      // this happens on server, just going to sync it manually
      for(i in scene_tut1_control_inputs) i.checked = false;
      for(i in scene_tut2_control_inputs) i.checked = false;
      for(i in scene_tut3_control_inputs) i.checked = false;
    }

    for(i in 0...scene_tut1_control_inputs.length)
      scene_tut1_control_inputs[i].onchange = function(e){
        room.send(GState.SET_TUT_STEP, ["step" => i, "value" => e.target.checked]);
      }
    for(i in 0...scene_tut2_control_inputs.length)
      scene_tut2_control_inputs[i].onchange = function(e){
        room.send(GState.SET_TUT_STEP, ["step" => i, "value" => e.target.checked]);
      }
    for(i in 0...scene_tut3_control_inputs.length)
      scene_tut3_control_inputs[i].onchange = function(e){
        room.send(GState.SET_TUT_STEP, ["step" => i, "value" => e.target.checked]);
      }

    var secondsInput = "";
    timer_seconds_input.onchange = function(e){
      secondsInput = e.currentTarget.value.trim();
    }

    timer_form.onsubmit = function(e){
      e.preventDefault();
      if(secondsInput.length == 0){
        status.innerText = "❌ You must enter seconds";
        e.currentTarget.reset();
        return;
      }

      var seconds = Std.parseInt(secondsInput);
      status.innerText = "👷 Setting Timer to: "+seconds;
      room.send(GState.SET_TIMER, seconds);
    }

    window.onbeforeunload = function(_){
      room.leave();
      return null;
    }

    // room.onMessage(State.DISCONNECTED, function(_){
    //   js.Browser.alert("Server Disconnected! Will reload the browser.");
    //   document.location.reload();
    // });

  }

  static function main() new GMain();


  static inline function createPlayerTableRow(table, player){
    var row = document.createElement("tr");
    var key = document.createElement("td");
    var alias = document.createElement("td");
    var stats = document.createElement("td");
    var pause = document.createElement("td");
    var connect = document.createElement("td");

    row.className = "player_row";
    key.className = "player_key";
    key.innerText = player.key;
    alias.innerText = player.alias;
    if(player.alias != "GM"){
      stats.innerHTML = 'hacking:${Std.string(player.hacking)}<br>sysops:${Std.string(player.sysops)}<br>skullduggery:${Std.string(player.skullduggery)}<br>int:${Std.string(player.intellect)}';
    }

    row.append(key, alias, stats, pause, connect);
    // row.appendChild(key);
    table.appendChild(row);
  }

}
