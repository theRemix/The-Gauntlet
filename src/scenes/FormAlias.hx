package scenes;

import h2d.TextInput;

using StringTools;

private enum InputType {
  Alpha;
  Number;
}

class FormAlias extends h2d.Scene{
  private var font:h2d.Font;
  private var aliasInput:TextInput;
  private var hackingInput:TextInput;
  private var sysopsInput:TextInput;
  private var skullduggeryInput:TextInput;
  private var intInput:TextInput;
  private var submitBtn:TextInput;

  public function new(){
    super();

    font = hxd.res.DefaultFont.get();

    aliasInput = createFormInput("Alias:", 50, Alpha);
    hackingInput = createFormInput("Comp (Hacking):", 90, Number);
    sysopsInput = createFormInput("Comp (Sysops):", 130, Number);
    skullduggeryInput = createFormInput("Skullduggery:", 170, Number);
    intInput = createFormInput("Intellect:", 210, Number);

    submitBtn = new TextInput(font, this);
    submitBtn.text = "LOGIN";
    submitBtn.canEdit = false;
    submitBtn.textColor = 0xAACCAA;
    submitBtn.backgroundColor = 0x8080C080;
    submitBtn.scale(2);
    submitBtn.x = 440;
    submitBtn.y = 290;
    submitBtn.onClick = submit;

    Main.instance.room.onMessage(State.ALIAS_ENTERED, onMessageAliasEntered);
  }

  private function createFormInput(label: String, y:Int, type:InputType): TextInput{
    var _label = new h2d.Text(font, this);
    _label.scale(1.4);
    _label.x = 50;
    _label.y = 50 + y;
    _label.text = label;

    var input = new TextInput(font, this);
    input.backgroundColor = 0x80808080;
    input.textColor = 0xAAAAAA;

    input.scale(2);
    input.x = 190;
    input.y = 50 + y;
    input.inputWidth = type == Alpha ? 240 : 40;
    input.onFocus = function(_) {
      input.textColor = 0xFFFFFF;
    }
    input.onFocusLost = function(_) {
      input.textColor = 0xAAAAAA;
    }

    input.onChange = switch(type){
      case Alpha:
        function() {
          while( input.text.length > 32 )
            input.text = input.text.substr(0, -1);
        }

      case Number:
        function() {
          input.text = ~/([^0-9]+)/gi.replace(input.text,'');
          while( input.text.length > 3 )
            input.text = input.text.substr(0, -1);
        }
    }

    return input;
  }

  private function submit(?_) {
    submitBtn.textColor = 0xFFFFFF;
    Main.instance.room.send(
      State.SET_ALIAS_STATS,
      [
        "alias" => aliasInput.text.trim(),
        "hacking" => hackingInput.text,
        "sysops" => sysopsInput.text,
        "skullduggery" => skullduggeryInput.text,
        "intellect" => intInput.text
      ]
    );
  }

  private function onMessageAliasEntered(_){
    Main.instance.curPlayer = new Player();
    Main.instance.curPlayer.alias = aliasInput.text.trim();
    Main.instance.curPlayer.hacking = Std.parseInt(hackingInput.text);
    Main.instance.curPlayer.sysops = Std.parseInt(sysopsInput.text);
    Main.instance.curPlayer.skullduggery = Std.parseInt(skullduggeryInput.text);
    Main.instance.curPlayer.intellect = Std.parseInt(intInput.text);

    Main.instance.goToScene(scenes.Lobby);
  }

  public override function dispose(){
    Main.instance.room.onMessage(State.ALIAS_ENTERED, null);
    super.dispose();
  }
}
