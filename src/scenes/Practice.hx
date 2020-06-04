package scenes;

import entities.Program;
import entities.Box;
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
    programs.add(new Program(this, "Firetoolz",  Colors.PROG_3, 200, 860)); // key to Database and Data Vault
    programs.add(new Program(this, "Daemon",     Colors.PROG_3, 300, 860));

    programs.add(new Program(this, "Lambda",     Colors.PROG_2, 610, 800));
    programs.add(new Program(this, "Shodan",     Colors.PROG_2, 710, 800));
    programs.add(new Program(this, "Tron",       Colors.PROG_2, 810, 800)); // key to Admin Terminal
    programs.add(new Program(this, "Supr AI",    Colors.PROG_4, 610, 860));
    programs.add(new Program(this, "Mega ML",    Colors.PROG_4, 710, 860));
    programs.add(new Program(this, "The Engine", Colors.PROG_4, 810, 860));

    subsystems = new Array<Box>();
    for(s in Main.instance.room.state.practiceNet){
      subsystems.push(new Box(this, s.name, s.x, s.y));
    }

    firewalls = new List<Firewall>();
    firewalls.add(new Firewall(this,   0, 350, 220, 3));
    firewalls.add(new Firewall(this, 400, 350, 220, 3));
    firewalls.add(new Firewall(this, 800, 350, 220, 3));

    for(p in programs){
      p.colliders = firewalls.map(function(f) return f.getBounds());
    }

  }
}
