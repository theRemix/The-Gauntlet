package scenes;

import entities.Program;
import entities.SubSystem;

using Lambda;

class Practice extends SimBase{

  private var subsystems:List<SubSystem>;
  private var programs:List<Program>;

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "PRACTICE";
    tf.scale(2);
    tf.x = 200;
    tf.y = 20;

    programs = new List<Program>();
    programs.add(new Program(this, "test 1", 0xaaffcc, 200, 300, 50, 50));
    programs.add(new Program(this, "test 2", 0xffccaa, 350, 300, 50, 50));

    subsystems = new List<SubSystem>();
    subsystems.add(new SubSystem(this, "system 1", 0xaaffcc, 180, 100, 100, 100));
    subsystems.add(new SubSystem(this, "system 2", 0xffccaa, 360, 100, 100, 100));

    Main.instance.sceneUpdate = update;
  }

  private inline function checkCollisions(){

    var activeProgram = programs.find(function(p) return p.active);

    if(activeProgram == null) return;

    for(s in subsystems){
      if(s.getBounds().intersects(activeProgram.getBounds())){
        s.hackAttempt(activeProgram);
        activeProgram.resetPos();
      }
    }

  }

  public function update(dt:Float) {
    checkCollisions();
  }

  public override function dispose(){
    super.dispose();
    Main.instance.sceneUpdate = null;
  }

}
