package scenes;

import entities.Program;

class Practice extends SimBase{

  private var backBtn:h2d.TextInput;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "PRACTICE";
    tf.scale(2);
    tf.x = 200;
    tf.y = 20;

    var p1 = new Program(this, "test 1", 0xaaffcc, 200, 200, 250, 50);
    var p2 = new Program(this, "test 2", 0xffccaa, 250, 300, 250, 50);
  }


  public override function dispose(){
    super.dispose();
  }
}
