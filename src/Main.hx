import js.Browser.document;
import js.Browser.window;
import io.colyseus.Client;
import io.colyseus.Room;
import io.colyseus.serializer.schema.Schema;


class Main extends hxd.App {
  public var client:Client;
	public var room:Room<State>;
  private var scene:h2d.Scene;
  public var gmControlledScenes:Bool;
  public var curPlayer:Player;

  // heaps
  override function init() {
    this.goToScene(scenes.FormServer);
    // this.goToScene(scenes.RealNet);
  }

  // colyseus
  public function new() {
    super();

    this.client = new Client('ws://${window.location.host}');
  }

  public function goToScene(scene:Class<h2d.Scene>):h2d.Scene {
    switch(scene){
      case scenes.Connecting:
        this.scene = new scenes.Connecting();
        this.setScene(this.scene);

      case scenes.FormServer:
        this.scene = new scenes.FormServer();
        this.setScene(this.scene, true);

      case scenes.FormAlias:
        this.scene = new scenes.FormAlias();
        this.setScene(this.scene, true);

      case scenes.Lobby:
        this.scene = new scenes.Lobby();
        this.setScene(this.scene, true);

      case scenes.Tut1:
        this.scene = new scenes.Tut1();
        this.setScene(this.scene, true);

      case scenes.Tut2:
        this.scene = new scenes.Tut2();
        this.setScene(this.scene, true);

      case scenes.Tut3:
        this.scene = new scenes.Tut3();
        this.setScene(this.scene, true);

      case scenes.Practice:
        this.scene = new scenes.Practice();
        this.setScene(this.scene, true);

      case scenes.RealNet:
        this.scene = new scenes.RealNet();
        this.setScene(this.scene, true);

      default:
        trace('WARN! No handler for scene = $scene');
    }
    return this.scene;
  }

  public inline function onJoin(err:io.colyseus.error.MatchMakeError, room) {
    if (err != null) {

      cast(this.scene, scenes.Connecting).showReturnBtn();
      var tf = new h2d.Text(hxd.res.DefaultFont.get(), this.scene);
      tf.text = err.message;
      tf.y = 20;

      trace("JOIN ERROR: " + err);
      return;
    }
    this.room = room;

    // this.room.onStateChange += onStateChange;
    this.room.state.onChange = onStateChange;
    this.room.onError += function onError(code: Int, message: String) {
      trace("ROOM ERROR: " + code + " => " + message);
    };
    var onLeave = function() {
      trace("ROOM LEAVE");
      js.Browser.alert("Server Disconnected! Will reload the browser.");
      document.location.reload();
    };
    this.room.onLeave += onLeave;
    // this.room.onMessage(State.DISCONNECTED, function(_){ // not handled yet
    //   js.Browser.alert("Server Disconnected! Will reload the browser.");
    //   document.location.reload();
    // });

    window.onbeforeunload = function(_){
      this.room.onLeave -= onLeave;
      this.room.leave();
      return null;
    }

    this.goToScene(scenes.FormAlias);
  }

  // ALWAYS ON
  private inline function onStateChange(changes:Array<DataChange>) {
    for(change in changes){
      switch(change.field){
        case "scene":
          if(this.gmControlledScenes){
            switch(Std.string(change.value)){
              case "Lobby":
                goToScene(scenes.Lobby);
              case "Tut1":
                goToScene(scenes.Tut1);
              case "Tut2":
                goToScene(scenes.Tut2);
              case "Tut3":
                goToScene(scenes.Tut3);
              case "Practice":
                goToScene(scenes.Practice);
              case "RealNet":
                goToScene(scenes.RealNet);
              default:
                trace('WARN: unhandled change scene in Main.onStateChange[scene]: ${change.value}');
            }
          }
        case "pauseOverlay":
          trace("Main.onStateChange pauseOverlay");
        // case "tutStep":
        // case "players":
        // case "gm":
        // case "practiceNet":
        // default:
        //   trace('WARN: unhandled change in Main.onStateChange: ${change.field}');
      }
    }
  }

  public var sceneUpdate:Float->Void;

  override function update(dt:Float) {
    if(sceneUpdate != null) sceneUpdate(dt);
  }

  public static var instance:Main;
  static function main() {
    instance = new Main();
  }
}
