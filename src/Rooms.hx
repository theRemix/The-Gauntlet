class Rooms {
  public static inline function onStateChange(state) {
      trace("STATE CHANGE: " + Std.string(state));
  }

  public static inline function onMessagePlayerConnected(message) {
      trace("onMessage: 'PlayerConnected' => " + message);
  }

  public static inline function onError(code: Int, message: String) {
      trace("ROOM ERROR: " + code + " => " + message);
  }

  public static inline function onLeave() {
      trace("ROOM LEAVE");
  }
}
