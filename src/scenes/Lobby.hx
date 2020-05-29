package scenes;

import io.colyseus.Client;
import io.colyseus.Room;

class Lobby extends h2d.Scene{
  private var client:Client;
  private var room:Room;
  public function new(client:Client, room:Room){
    trace("Lobby init");
    this.client = client;
    this.room = room;
  }
  public function destroy(){
    trace("Scene:Lobby DISPOSE");
  }
}
