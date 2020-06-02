class StatefulScene extends h2d.Scene{

  public function onStateChange(state) {
    trace('Scene ${Type.getClassName(Type.getClass(this))} did not override onStateChange');
  }
}
