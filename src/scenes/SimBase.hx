package scenes;

import h2d.Graphics;
import h2d.col.Bounds;

import entities.Program;
import entities.SubSystem;
import entities.Firewall;

using Lambda;

class SimBase extends h2d.Scene{

  private var subsystems:List<SubSystem>;
  private var programs:List<Program>;
  private var firewalls:List<Firewall>;

  private var _stageBounds:Bounds;

  public function new(){
    super();

    _stageBounds = Bounds.fromValues(0,0,1000,1000);
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
}
