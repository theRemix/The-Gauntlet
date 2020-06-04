package entities;

import h2d.Scene;
import h2d.Graphics;
import h2d.Interactive;
import h2d.Text;
import hxd.Event;
import h2d.col.Bounds;

class Box extends Graphics{

  static inline var WIDTH = 100;
  static inline var HEIGHT = 100;

  var owned:Bool;

  // var accessible(get,null):Bool;
  // any incomingCnx are owned


  var label:Text;
  // var runnersTxt:Text;
  // var cnxLines:List<SystemCnxLine>;

  // var runners:List<String>;

  public function new(scene:Scene, name:String, x:Int, y:Int) {
    super(scene);
    this.name = name;
    this.x = x;
    this.y = y;

    beginFill(Colors.SYS_ACCESS);
    drawRect(0, 0, WIDTH, HEIGHT);
    endFill();

    var font = hxd.res.DefaultFont.get();
    label = new Text(font, this);
    label.x = 8;
    label.y = 8;
    label.text = name;
    label.textColor = 0x0;
  }

  public function hackAttempt(program){
    Main.instance.room.send(State.HACK_ATTEMPT, [
      "mode" => "practice",
      "playerAlias" => Main.instance.curPlayer.alias,
      "subsystem" => this.name,
      "program" => program.name,
    ]);
  }

  public function syncProps(ss:SubSystem){
    if(!owned && ss.owned){
      owned = ss.owned;
      label.text = name + "\nPWNED BY:\n" + ss.ownedBy;

      beginFill(Colors.SYS_OWNED);
      drawRect(0, 0, WIDTH, HEIGHT);
      endFill();

    }else if(ss.runners.length > 0){
      label.text = name + "\nrunners:\n";
      for(r in ss.runners){
        label.text += r + "\n";
      }
    }
  }

}

