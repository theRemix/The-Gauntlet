import io.colyseus.Client;
import io.colyseus.Room;

class Main extends hxd.App {
  public var client:Client;
	public var room:Room<State>;
  private var scene:h2d.Scene;

  // heaps
  override function init() {
    this.goToScene(scenes.Connecting);
  }

  // colyseus
  public function new() {
    super();

    this.client = new Client('ws://localhost:3000');
    this.client.joinOrCreate("state_handler", [], State, this.onJoinOrCreate);
  }

  public function goToScene(scene:Class<h2d.Scene>):h2d.Scene {
    switch(scene){
      case scenes.Connecting:
        this.scene = new scenes.Connecting();
        this.setScene(this.scene);

      case scenes.FormAlias:
        this.scene = new scenes.FormAlias();
        this.setScene(this.scene, true);

      case scenes.Lobby:
        this.scene = new scenes.Lobby();
        this.setScene(this.scene, true);

      default:
        trace('WARN! No handler for scenee = $scene');
    }
    return this.scene;
  }

  private inline function onJoinOrCreate(err:io.colyseus.error.MatchMakeError, room) {
    if (err != null) {

      var tf = new h2d.Text(hxd.res.DefaultFont.get(), this.scene);
      tf.text = err.message;
      tf.y = 20;

      trace("JOIN ERROR: " + err);
      return;
    }
    this.room = room;

    this.room.onStateChange += Rooms.onStateChange;
    this.room.onError += Rooms.onError;
    this.room.onLeave += Rooms.onLeave;

    // this.room.state.onChange = onStateChange;

    this.goToScene(scenes.FormAlias);
  }

  private inline function onStateChange(changes){
    trace('onStateChange', changes);
    // for(change in changes){
    //   switch(change.field){
    //     case State.ALIAS_ENTERED:
    //       trace('case', State.ALIAS_ENTERED);
    //       goToScene(scenes.Lobby);
    //     default:
    //       trace('WARN! unhandled change: ${change.field}');
    //   }
    // }
  }

  override function update(dt:Float) {

  }

  public static var instance:Main;
  static function main() {
    instance = new Main();
  }
}
