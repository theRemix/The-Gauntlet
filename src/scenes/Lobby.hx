package scenes;

class Lobby extends h2d.Scene{
  private var playerListTxt:h2d.Text;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    playerListTxt = new h2d.Text(font, this);
    playerListTxt.text = "Users connected:";

    Main.instance.room.state.players.onAdd = onAddPlayer;
    Main.instance.room.state.players.onChange = onChangePlayer;
    Main.instance.room.state.players.onRemove = onRemovePlayer;
  }

  // rerender all names
  private inline function onAddPlayer(player, key) {
    renderListOfPlayers();
  }

  private inline function onChangePlayer(player, key) {
    renderListOfPlayers();
  }

  private inline function onRemovePlayer(player, key) {
    renderListOfPlayers();
  }

  public function renderListOfPlayers(){
    playerListTxt.text = "Users connected:\n\nAlias       Hacking       Sysops       Skullduggery       Int";

    for(player in Main.instance.room.state.players){
      if(player.alias != null){
        playerListTxt.text += "\n"+player.alias;
        if(player.alias != "GM"){
          playerListTxt.text += "       "+player.hacking;
          playerListTxt.text += "       "+player.sysops;
          playerListTxt.text += "       "+player.skullduggery;
          playerListTxt.text += "       "+player.intellect;
        }
      }
    }
  }

  public function destroy(){
    trace("Scene:Lobby DISPOSE");

    if(Main.instance.room.state.players.onAdd == onAddPlayer){
      Main.instance.room.state.players.onAdd = null;
    }
    if(Main.instance.room.state.players.onChange == onChangePlayer){
      Main.instance.room.state.players.onChange = null;
    }
    if(Main.instance.room.state.players.onRemove == onRemovePlayer){
      Main.instance.room.state.players.onRemove = null;
    }

    super.dispose();
  }
}
