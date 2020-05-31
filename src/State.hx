import io.colyseus.serializer.schema.Schema;

class State extends Schema {
  public static inline var COLYSEUS_ROOM = "state_handler";
  public static inline var SERVER_ADDRESS = "server_address";

  // messages server -> client
  public static inline var DISCONNECTED = "DISCONNECTED";
  public static inline var ALIAS_ENTERED = "ALIAS_ENTERED";

  // messages client -> server
  public static inline var SET_ALIAS = "setAlias";

	@:type("map", Player)
	public var players: MapSchema<Player> = new MapSchema<Player>();

	@:type("ref", Player)
	public var gm: Player;
}
