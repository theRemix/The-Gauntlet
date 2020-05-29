package scenes;

class InputAlias extends h2d.Scene{
  public function new(){
    super();

    var tf = new h2d.Text(hxd.res.DefaultFont.get(), this);
    tf.text = "Enter your alias:";
  }
  public override function dispose(){
    trace("Scene:InputAlias DISPOSE");
  }
}
