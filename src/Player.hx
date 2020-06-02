import io.colyseus.serializer.schema.Schema;
class Player extends Schema {

	@:type("string")
	public var key: String = null;

	@:type("string")
	public var alias: String = null;

	@:type("number")
	public var hacking: Int;

	@:type("number")
	public var sysops: Int;

	@:type("number")
	public var skullduggery: Int;

	@:type("number")
	public var intellect: Int;

}
