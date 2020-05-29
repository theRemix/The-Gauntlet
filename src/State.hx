import io.colyseus.serializer.schema.Schema;

class State extends Schema {
  public static inline var CONNECTED = "CONNECTED";
  public static inline var ALIAS_ENTERED = "ALIAS_ENTERED";

	@:type("map", Player)
	public var players: MapSchema<Player> = new MapSchema<Player>();
}
