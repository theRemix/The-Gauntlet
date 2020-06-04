package entities;

import h2d.Scene;
import h2d.Graphics;
import h2d.Interactive;
import h2d.Text;
import hxd.Event;
import h2d.col.Bounds;

import scenes.SimBase;

class Box extends Graphics {

  public static inline var WIDTH = 100;
  public static inline var HEIGHT = 80;

  var scene:SimBase;
  public var owned:Bool;
  var accessible:Bool;

  private var inboundCnx:List<Box>;
  public var outboundCnx:List<Box>;

  var label:Text;

  public function new(scene:SimBase, name:String, x:Int, y:Int) {
    super(scene);
    this.scene = scene;
    this.name = name;
    this.x = x;
    this.y = y;
    this.accessible = true;
    this.inboundCnx = new List<Box>();
    this.outboundCnx = new List<Box>();

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

  public function cnxFrom(a:Box){
    this.accessible = false;
    this.inboundCnx.add(a);
    a.outboundCnx.add(this);

    beginFill(Colors.SYS_NO_ACCESS);
    drawRect(0, 0, WIDTH, HEIGHT);
    endFill();
  }

  public function makeAccessible(){
    this.accessible = true;

    beginFill(Colors.SYS_ACCESS);
    drawRect(0, 0, WIDTH, HEIGHT);
    endFill();
  }

  public function hackAttempt(program){
    if(!this.accessible) return;

    Main.instance.room.send(State.HACK_ATTEMPT, [
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

      // remove cnx to make accessible
      for(b in outboundCnx.filter(function(s) return !s.owned)){
        b.makeAccessible();
      }

      scene.onBoxOwned(this);

    }else if(ss.runners.length > 0){
      // label.text = name + "\nrunners:\n";
      label.text = name + "\n";
      for(r in ss.runners){
        label.text += r + "\n";
      }
    }
  }

}

