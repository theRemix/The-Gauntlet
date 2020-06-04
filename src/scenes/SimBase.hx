package scenes;

import h2d.Graphics;
import h2d.col.Bounds;

import entities.Program;
import entities.Box;
import entities.Firewall;

using Lambda;

class SystemCnxLine extends Graphics {
  static inline var LINE_THICKNESS = 3;

  public function new(scene:SimBase, source:Box, dest:Box) {
    super(scene);

    beginFill(Colors.NET_NO_ACCESS);

    if(source.x == dest.x){ // vertical
      drawRect(source.x + Box.WIDTH/2, source.y + Box.HEIGHT/2, LINE_THICKNESS, dest.y - source.y);
    } else { // horizontal
      drawRect(source.x + Box.WIDTH/2, source.y + Box.HEIGHT/2, dest.x - source.x, LINE_THICKNESS);
    }
    endFill();
  }
}

class SimBase extends h2d.Scene{

  private var subsystems:Array<Box>;
  private var programs:List<Program>;
  private var firewalls:List<Firewall>;
  private var cnx:List<SystemCnxLine>;

  private var _stageBounds:Bounds;

  public function new(){
    super();

    this.programs = new List<Program>();
    this.firewalls = new List<Firewall>();
    this.subsystems = new Array<Box>();
    this.cnx = new List<SystemCnxLine>();

    _stageBounds = Bounds.fromValues(0,0,1000,1000);

    Main.instance.sceneUpdate = update;
    // Main.instance.room.state.practiceNet.onChange = onPracticeNetChange;
  }

  private inline function onPracticeNetChange(ss:SubSystem, key:Int) {
    trace(ss);
    subsystems[key].syncProps(ss);
  }

  public function update(dt:Float) {
    checkCollisions();
  }

  private inline function checkCollisions(){
    var activeProgram:Program = programs.find(function(p) return p.active);

    if(activeProgram == null) return;

    for(s in subsystems.filter(function(s) return !s.owned)){
      if(s.getBounds().intersects(activeProgram.getBounds())){
        s.hackAttempt(activeProgram);
        activeProgram.resetPos();
      }
    }

    if(!_stageBounds.intersects(activeProgram.getBounds())){
      activeProgram.resetPos();
    }

  }

  public function createNetCnx(a:Box, b:Box){
    b.cnxFrom(a);
    cnx.add(new SystemCnxLine(this, a, b));
    // bring boxes forward
		this.children.push(this.children.splice(this.children.indexOf(a), 1)[0]);
		this.children.push(this.children.splice(this.children.indexOf(b), 1)[0]);
  }

  public override function dispose(){
    super.dispose();
    Main.instance.sceneUpdate = null;

    if(Main.instance.room.state.practiceNet.onChange == onPracticeNetChange){
      Main.instance.room.state.practiceNet.onChange = null;
    }
  }

}
