package scenes;

class Lobby extends h2d.Scene{
  private var playerListTxt:h2d.Text;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    playerListTxt = new h2d.Text(font, this);
    playerListTxt.text = "Users connected:";


    trace(Main.instance.room.state.players);
    for( player in  Main.instance.room.state.players){
      trace(player);
      player.onChange = function(changes) {
        trace("SINGLE PLAYER CHANGED", changes);
      };
    }

    // Main.instance.room.state.players.onAdd = onAddPlayer;
    // Main.instance.room.state.players.onChange = onChangePlayer;
    // Main.instance.room.state.players.onRemove = onRemovePlayer;
  }

  // rerender all names
  // private inline function onAddPlayer(player, key) {
  //   trace("Lobby PLAYER", player, " ADDED AT: ", key);
  //   renderListOfPlayers();
  // }

  // private inline function onChangePlayer(player, key) {
  //     trace("Lobby PLAYER CHANGED AT: ", key);
  //     // this.cats[key].x = player.x;
  //     // this.cats[key].y = player.y;
  // }

  // private inline function onRemovePlayer(player, key) {
  //   trace("Lobby PLAYER REMOVED AT: ", key);
  //   renderListOfPlayers();
  // }

  public function renderListOfPlayers(){
    playerListTxt.text = "Users connected:" + "List";
    trace('Main.instance.room.state.players', Main.instance.room.state.players);
  }

  public function destroy(){
    trace("Scene:Lobby DISPOSE");

//     if(Main.instance.room.state.players.onAdd == onAddPlayer){
//       Main.instance.room.state.players.onAdd = null;
//     }
//     if(Main.instance.room.state.players.onChange == onChangePlayer){
//       Main.instance.room.state.players.onChange = null;
//     }
//     if(Main.instance.room.state.players.onRemove == onRemovePlayer){
//       Main.instance.room.state.players.onRemove = null;
//     }

    super.dispose();
  }
}
