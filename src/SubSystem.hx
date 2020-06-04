import io.colyseus.serializer.schema.Schema;
class SubSystem extends Schema {

	@:type("string")
	public var name: String;

	@:type("number")
	public var x: Int;

	@:type("number")
	public var y: Int;

	@:type("array", "string")
	public var keys: ArraySchema<String>;

	@:type("boolean")
	public var owned: Bool;

	@:type("string")
	public var ownedBy: String;

	@:type("array", "string")
	public var runners: ArraySchema<String>;

}

