package entities;

import h2d.Scene;
import h2d.Graphics;
import h2d.Interactive;
import h2d.Text;
import hxd.Event;
import h2d.col.Bounds;

class SubSystem extends Graphics{

  static inline var WIDTH = 100;
  static inline var HEIGHT = 100;

  var owned:Bool;

  // var accessible(get,null):Bool;
  // any incomingCnx are owned


  var label:Text;
  var runnersTxt:Text;
  // var cnxLines:List<SystemCnxLine>;

  // var runners:List<RunnerAlias>;

  public function new(scene:Scene, name:String, color:Int, x:Int, y:Int) {
    super(scene);
    this.name = name;
    this.x = x;
    this.y = y;

    beginFill(color);
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
    // Main.instance.curPlayer.alias
    trace("HACK ATTEMPT", this.name, program.name);
  }

}

