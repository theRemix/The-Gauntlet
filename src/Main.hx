import io.colyseus.Client;
import io.colyseus.Room;

class Main extends hxd.App {
  private var client:Client;
	private var room:Room<State>;

  public function new() {
    super();

    this.client = new Client('ws://localhost:3000');
    this.client.joinOrCreate("state_handler", [], State, this.onJoinOrCreate);

    var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
    tf.text = "Hello World !";
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

    this.room.state.players.onAdd = Players.onAdd;
    this.room.state.players.onChange = Players.onChange;
    this.room.state.players.onRemove = Players.onRemove;
  }

  static function main() {
      new Main();
  }
}
