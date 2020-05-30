import io.colyseus.serializer.schema.Schema;
class Player extends Schema {

	@:type("string")
	public var key: String = null;

	@:type("string")
	public var alias: String = null;

}
