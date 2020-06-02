package scenes;

class Connecting extends StatefulScene{

  private var backBtn:h2d.TextInput;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "Connecting to the net";

    backBtn = new h2d.TextInput(font, this);
    backBtn.text = "RETURN";
    backBtn.canEdit = false;
    backBtn.textColor = 0xAACCAA;
    backBtn.scale(2);
    backBtn.x = 240;
    backBtn.y = 110;
    backBtn.onClick = backBtnOnClick;
    backBtn.visible = false;
  }

  public function showReturnBtn() {
    backBtn.visible = true;
    backBtn.backgroundColor = 0x8080C080;
  }

  private function backBtnOnClick(?_) {
    backBtn.textColor = 0xFFFFFF;
    Main.instance.goToScene(scenes.FormServer);
  }

  public override function dispose(){
    trace("Scene:Connecting DISPOSE");
    super.dispose();
  }
}
