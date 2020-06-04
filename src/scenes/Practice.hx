package scenes;

import entities.Program;
import entities.SubSystem;
import entities.Firewall;

class Practice extends SimBase{

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "PRACTICE";
    tf.scale(2);
    tf.x = 200;
    tf.y = 20;

    programs = new List<Program>();
    programs.add(new Program(this, "Shroomz",    Colors.PROG_1, 100, 800));
    programs.add(new Program(this, "AOHell",     Colors.PROG_1, 200, 800));
    programs.add(new Program(this, "GodPunter",  Colors.PROG_1, 300, 800));
    programs.add(new Program(this, "Subzero",    Colors.PROG_3, 100, 860));
    programs.add(new Program(this, "Firetoolz",  Colors.PROG_3, 200, 860));
    programs.add(new Program(this, "Daemon",     Colors.PROG_3, 300, 860));

    programs.add(new Program(this, "Lambda",     Colors.PROG_2, 610, 800));
    programs.add(new Program(this, "Shodan",     Colors.PROG_2, 710, 800));
    programs.add(new Program(this, "Tron",       Colors.PROG_2, 810, 800));
    programs.add(new Program(this, "Supr AI",    Colors.PROG_4, 610, 860));
    programs.add(new Program(this, "Mega ML",    Colors.PROG_4, 710, 860));
    programs.add(new Program(this, "The Engine", Colors.PROG_4, 810, 860));

    subsystems = new List<SubSystem>();
    subsystems.add(new SubSystem(this, "Database",       Colors.SYS_ACCESS, 280, 100));
    subsystems.add(new SubSystem(this, "Admin Terminal", Colors.SYS_ACCESS, 450, 100));
    subsystems.add(new SubSystem(this, "Data Vault",     Colors.SYS_ACCESS, 620, 100));

    firewalls = new List<Firewall>();
    firewalls.add(new Firewall(this,   0, 350, 220, 3));
    firewalls.add(new Firewall(this, 400, 350, 220, 3));
    firewalls.add(new Firewall(this, 800, 350, 220, 3));

    for(p in programs){
      p.colliders = firewalls.map(function(f) return f.getBounds());
    }

    Main.instance.sceneUpdate = update;
  }

  public function update(dt:Float) {
    checkCollisions();
  }

  public override function dispose(){
    super.dispose();
    Main.instance.sceneUpdate = null;
  }

}
