package scenes;

class InputAlias extends h2d.Scene{
  private var input:h2d.TextInput;
  private var submitBtn:h2d.TextInput;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "Enter your alias:";

    input = new h2d.TextInput(font, this);
    input.backgroundColor = 0x80808080;
    input.textColor = 0xAAAAAA;

    input.scale(2);
    input.x = input.y = 50;
    input.inputWidth = 240;
    input.onFocus = function(_) {
      input.textColor = 0xFFFFFF;
    }
    input.onFocusLost = function(_) {
      input.textColor = 0xAAAAAA;
    }

    input.onChange = function() {
      while( input.text.length > 32 )
        input.text = input.text.substr(0, -1);
    }

    submitBtn = new h2d.TextInput(font, this);
    submitBtn.text = "LOGIN";
    submitBtn.canEdit = false;
    submitBtn.textColor = 0xAACCAA;
    submitBtn.backgroundColor = 0x8080C080;
    submitBtn.scale(2);
    submitBtn.x = 240;
    submitBtn.y = 110;
    submitBtn.onClick = submit;

    Main.instance.room.onMessage(State.ALIAS_ENTERED, onMessageAliasEntered);
  }

  private function submit(_) {
    submitBtn.textColor = 0xFFFFFF;
    Main.instance.room.send("setAlias", input.text);
  }

  private function onMessageAliasEntered(_){
    Main.instance.goToScene(scenes.Lobby);
  }

  public override function dispose(){
    trace("Scene:InputAlias DISPOSE");
    super.dispose();
  }
}
