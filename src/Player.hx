import io.colyseus.serializer.schema.Schema;
class Player extends Schema {

	@:type("string")
	public var alias: String = null;

}
