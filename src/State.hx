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

	@:type("string")
	public var scene: String; // name

	@:type("string")
	public var pauseOverlay: String; // dim, dark

	@:type("array", "boolean")
	public var tutStep: ArraySchema<Bool> = new ArraySchema<Bool>();
}
