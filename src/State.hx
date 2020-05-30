import io.colyseus.serializer.schema.Schema;

class State extends Schema {
  // messages server -> client
  public static inline var DISCONNECTED = "DISCONNECTED";
  public static inline var ALIAS_ENTERED = "ALIAS_ENTERED";

  // messages client -> server
  public static inline var SET_ALIAS = "setAlias";

	@:type("map", Player)
	public var players: MapSchema<Player> = new MapSchema<Player>();

}
