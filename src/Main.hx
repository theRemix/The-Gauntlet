import io.colyseus.Client;
import io.colyseus.Room;

class Main extends hxd.App {
  private var client:Client;
	private var room:Room<State>;
  private var scene:h2d.Scene;

  // heaps
  override function init() {
    this.scene = new scenes.Connecting();
    this.setScene(this.scene);

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

    this.scene = new scenes.InputAlias();
    this.setScene(this.scene, true);

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

    // this.room.state.onChange = onStateChange;

  }

  // private inline function onStateChange(changes){
  //   for(change in changes){
  //     switch(change.field){
  //       case State.ALIAS_ENTERED:
  //         this.scene = new scenes.Lobby();
  //         this.setScene(this.scene, true);
  //       default:
  //         trace('WARN! unhandled change: ${change.field}');
  //     }
  //   }
  // }

  override function update(dt:Float) {

  }

  private function onEvent(event : hxd.Event) {
      switch(event.kind) {
          case EKeyDown: trace('DOWN keyCode: ${event.keyCode}');
          case EKeyUp:
            if(this.room == null) return;
            trace('UP keyCode: ${event.keyCode}');
            this.room.send("updateTest", Std.string(event.keyCode));
          case _:
      }
  }

  static function main() {
      new Main();
  }
}
