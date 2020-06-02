package scenes;

class FormServer extends StatefulScene{
  private var input:h2d.TextInput;
  private var submitBtn:h2d.TextInput;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "Enter server address:";

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
    submitBtn.text = "CONNECT";
    submitBtn.canEdit = false;
    submitBtn.textColor = 0xAACCAA;
    submitBtn.backgroundColor = 0x8080C080;
    submitBtn.scale(2);
    submitBtn.x = 240;
    submitBtn.y = 110;
    submitBtn.onClick = submit;

    hxd.Window.getInstance().addEventTarget(onEvent);
  }

  private function onEvent(event : hxd.Event) {
    switch(event.kind) {
      case EKeyUp:
        if(event.keyCode == 13){
          submit();
        }
      case _:
    }
  }

  private function submit(?_) {
    submitBtn.textColor = 0xFFFFFF;
    Main.instance.client.join(input.text, [], State, Main.instance.onJoin);
    Main.instance.goToScene(scenes.Connecting);
  }

  public override function dispose(){
    trace("Scene:InputServer DISPOSE");
    hxd.Window.getInstance().removeEventTarget(onEvent);
    super.dispose();
  }
}

