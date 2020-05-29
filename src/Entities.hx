class Entities {

  public static inline function onAdd(entity, key) {
      trace("entity added at " + key + " => " + entity);

      entity.onChange = function (changes) {
        trace("entity changes => " + changes);
      }
  }

  public static inline function onChange(entity, key) {
      trace("entity changed at " + key + " => " + entity);
  }

  public static inline function onRemove(entity, key) {
      trace("entity removed at " + key + " => " + entity);
  }

}
