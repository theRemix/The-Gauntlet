package scenes;

class Connecting extends h2d.Scene{
  public function new(){
    super();

    var tf = new h2d.Text(hxd.res.DefaultFont.get(), this);
    tf.text = "Connecting to the net";
  }
  public override function dispose(){
    trace("Scene:Connecting DISPOSE");
    super.dispose();
  }
}
