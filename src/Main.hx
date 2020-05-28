import io.colyseus.Client;
import io.colyseus.Room;

class Main extends hxd.App {
  private var client:Client;
	private var room:Room<State>;

  var test:h2d.Text;

  // heaps
  override function init() {
    var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
    tf.text = "Hello World !";

    test = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
    test.text = "test init";
    test.y = 20;

    hxd.Window.getInstance().addEventTarget(onEvent);
  }

  // colyseus
  public function new() {
    super();

    this.client = new Client('ws://localhost:3000');
    this.client.joinOrCreate("state_handler", [], State, this.onJoinOrCreate);
  }

  private inline function onJoinOrCreate(err:io.colyseus.error.MatchMakeError, room) {
    if (err != null) {
      trace("JOIN ERROR: " + err);
      return;
    }

    this.room = room;

    this.room.onStateChange += Rooms.onStateChange;
    this.room.onMessage(0, Rooms.onMessage0);
    this.room.onMessage("type", Rooms.onMessageType);
    this.room.onMessage("playerConnected", Rooms.onMessagePlayerConnected);
    this.room.onError += Rooms.onError;
    this.room.onLeave += Rooms.onLeave;

    // this.room.state.movePlayer({ x: 200, y: 200 });

    this.room.state.players.onAdd = Players.onAdd;
    this.room.state.players.onChange = Players.onChange;
    this.room.state.players.onRemove = Players.onRemove;

    trace(this.room.state);
    this.room.state.onChange = function(changes){
      for(change in changes){
        trace(change.field == "test");
        if(change.field == "test"){
          test.text = change.value;
        }
      }
    }
  }

  override function update(dt:Float) {

  }

  private function onEvent(event : hxd.Event) {
      switch(event.kind) {
          case EKeyDown: trace('DOWN keyCode: ${event.keyCode}');
          case EKeyUp:
            trace('UP keyCode: ${event.keyCode}');
            test.text = 'sending';
            this.room.send("updateTest", Std.string(event.keyCode));
          case _:
      }
  }

  static function main() {
      new Main();
  }
}
