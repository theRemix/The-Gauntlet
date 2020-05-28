class Players {

  public static inline function onAdd(player, key) {
    trace("PLAYER ADDED AT: ", key);
    // var cat = Assets.getMovieClip("library:NyanCatAnimation");
    // this.cats[key] = cat;
    // cat.x = player.x;
    // cat.y = player.y;
    // addChild(cat);
  }

  public static inline function onChange(player, key) {
      trace("PLAYER CHANGED AT: ", key);
      // this.cats[key].x = player.x;
      // this.cats[key].y = player.y;
  }

  public static inline function onRemove(player, key) {
      trace("PLAYER REMOVED AT: ", key);
      // removeChild(this.cats[key]);
  }
}
