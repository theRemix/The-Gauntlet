import io.colyseus.serializer.schema.Schema;

class State extends Schema {
  // messages server -> client
  // public static inline var DISCONNECTED = "DISCONNECTED"; // not handled yet
  public static inline var ALIAS_ENTERED = "ALIAS_ENTERED";

  // messages client -> server
  public static inline var SET_ALIAS_STATS = "setAliasAndStats";

	@:type("map", Player)
	public var players: MapSchema<Player> = new MapSchema<Player>();

	@:type("ref", Player)
	public var gm: Player;

	@:type("number")
	public var tutScreen: Int;

	@:type("number")
	public var tutStep: Int;
}
