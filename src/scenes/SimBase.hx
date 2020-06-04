package scenes;

import h2d.Graphics;
import h2d.col.Bounds;

import entities.Program;
import entities.Box;
import entities.Firewall;

using Lambda;

class SimBase extends h2d.Scene{

  private var subsystems:Array<Box>;
  private var programs:List<Program>;
  private var firewalls:List<Firewall>;

  private var _stageBounds:Bounds;

  public function new(){
    super();

    _stageBounds = Bounds.fromValues(0,0,1000,1000);

    Main.instance.sceneUpdate = update;
    Main.instance.room.state.practiceNet.onChange = onPracticeNetChange;
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

    for(s in subsystems){
      if(s.getBounds().intersects(activeProgram.getBounds())){
        s.hackAttempt(activeProgram);
        activeProgram.resetPos();
      }
    }

    if(!_stageBounds.intersects(activeProgram.getBounds())){
      activeProgram.resetPos();
    }

  }

  public override function dispose(){
    super.dispose();
    Main.instance.sceneUpdate = null;

    if(Main.instance.room.state.practiceNet.onChange == onPracticeNetChange){
      Main.instance.room.state.practiceNet.onChange = null;
    }
  }

}
