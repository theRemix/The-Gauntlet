/*

   loadNoobProgs : hacking = 0
   loadHackerProgs : hacking > 0

*/
package scenes;

import entities.Program;
import entities.Box;
import entities.Firewall;

class RealNet extends SimBase{

  public function new(){
    super();

    var font = hxd.res.DefaultFont.get();

    var tf = new h2d.Text(font, this);
    tf.text = "MegaCorp Network";
    tf.scale(2);
    tf.x = 20;
    tf.y = 10;

#if design_mode
  #if design_hacker
      loadHackerProgs();
  #elseif design_noob
      loadNoobProgs();
  #end
  designSubSystems();
#else
    var net = switch (Main.instance.room.state.scene) {
      case "Practice":
        Main.instance.room.state.practiceNet;
      case "RealNet":
        Main.instance.room.state.realNet;
      default:
        trace('ERROR: unhandled scene ${Main.instance.room.state.scene}');
        null;
    }

    for(s in net){
      subsystems.push(new Box(this, s.name, s.x, s.y));
    }

    if( Main.instance.curPlayer.hacking > 0 || Main.instance.curPlayer.sysops > 0 ){
      loadHackerProgs();
    } else {
      loadNoobProgs();
    }
#end

    for(p in programs){
      p.colliders = firewalls;
    }

    createNetConns();
  }

  function loadNoobProgs(){

    var group = [
      { x: 110, y: 760 },
      { x: 210, y: 760 },
      { x: 310, y: 760 },
      { x: 410, y: 760 },
      { x: 510, y: 760 },
      { x: 610, y: 760 },
      { x: 710, y: 760 },
      { x: 810, y: 760 },
    ];

    programs.add(new Program(this, "Shroomz",       Colors.PROG_3, group[0].x, group[0].y));
    programs.add(new Program(this, "AOHell",        Colors.PROG_2, group[0].x, group[0].y+40));
    programs.add(new Program(this, "GodPunter",     Colors.PROG_1, group[0].x, group[0].y+80));

    programs.add(new Program(this, "Subzero",       Colors.PROG_3, group[1].x, group[1].y));
    programs.add(new Program(this, "Firetoolz",     Colors.PROG_2, group[1].x, group[1].y+40));
    programs.add(new Program(this, "Daemon",        Colors.PROG_1, group[1].x, group[1].y+80));

    programs.add(new Program(this, "Lambda",        Colors.PROG_3, group[2].x, group[2].y));
    programs.add(new Program(this, "Shodan",        Colors.PROG_2, group[2].x, group[2].y+40));
    programs.add(new Program(this, "Tron",          Colors.PROG_1, group[2].x, group[2].y+80));

    programs.add(new Program(this, "Supr AI",       Colors.PROG_3, group[3].x, group[3].y));
    programs.add(new Program(this, "Mega ML",       Colors.PROG_2, group[3].x, group[3].y+40));
    programs.add(new Program(this, "The Engine",    Colors.PROG_1, group[3].x, group[3].y+80));

    programs.add(new Program(this, "Misfit",        Colors.PROG_3, group[4].x, group[4].y));
    programs.add(new Program(this, "The Brain",     Colors.PROG_2, group[4].x, group[4].y+40));
    programs.add(new Program(this, "Logic",         Colors.PROG_1, group[4].x, group[4].y+80));

    programs.add(new Program(this, "MARAK",         Colors.PROG_3, group[5].x, group[5].y));
    programs.add(new Program(this, "Kosmokrator",   Colors.PROG_2, group[5].x, group[5].y+40));
    programs.add(new Program(this, "EPICAC",        Colors.PROG_1, group[5].x, group[5].y+80));

    programs.add(new Program(this, "XMARK V",       Colors.PROG_3, group[6].x, group[6].y));
    programs.add(new Program(this, "Prime Radiant", Colors.PROG_2, group[6].x, group[6].y+40));
    programs.add(new Program(this, "Mima",          Colors.PROG_1, group[6].x, group[6].y+80));

    programs.add(new Program(this, "XGold",         Colors.PROG_3, group[7].x, group[7].y));
    programs.add(new Program(this, "Bossy",         Colors.PROG_2, group[7].x, group[7].y+40));
    programs.add(new Program(this, "XMultivac",     Colors.PROG_1, group[7].x, group[7].y+80));

    // first layer                   persist x    y    width
    firewalls.add(new Firewall(this,  true,    0, 730, 400, 3));
    firewalls.add(new Firewall(this,  true,  600, 730, 400, 3));

    // 2nd layer
    firewalls.add(new Firewall(this, false,  120, 660, 760, 3));

    // 3rd layer left path
    firewalls.add(new Firewall(this, false,    0, 590, 400, 3));

    // 4th layer left path
    firewalls.add(new Firewall(this, false,  120, 520, 400, 3));

    // 5th layer left path
    firewalls.add(new Firewall(this, false,    0, 450, 400, 3));

    // mid vertical
    firewalls.add(new Firewall(this, false,  520, 450, 3, 170));

    // 3rd layer right path
    firewalls.add(new Firewall(this, false,  780, 590, 100, 3));
    firewalls.add(new Firewall(this, false,  880, 590, 3, 73));

    // 4th layer right path
    firewalls.add(new Firewall(this, false,  660, 520, 360, 3));
    firewalls.add(new Firewall(this, false,  660, 520, 3, 73));

    // 5th layer right path
    firewalls.add(new Firewall(this, false,  520, 450, 320, 3));

    // side borders
    firewalls.add(new Firewall(this,  true,  -3,   450, 3, 280));
    firewalls.add(new Firewall(this,  true,  1000, 450, 3, 280));

  }

  function loadHackerProgs(){

    var group = [
      { x: 110, y: 625 },
      { x: 210, y: 625 },
      { x: 310, y: 625 },
      { x: 410, y: 625 },
      { x: 510, y: 625 },
      { x: 610, y: 625 },
      { x: 710, y: 625 },
      { x: 810, y: 625 },

      { x: 110, y: 765 },
      { x: 210, y: 765 },
      { x: 310, y: 765 },
      { x: 410, y: 765 },
      { x: 510, y: 765 },
      { x: 610, y: 765 },
      { x: 710, y: 765 },
      { x: 810, y: 765 },
    ];

    programs.add(new Program(this, "Shroomz",       Colors.PROG_3, group[0].x, group[0].y));
    programs.add(new Program(this, "AOHell",        Colors.PROG_2, group[0].x, group[0].y+40));
    programs.add(new Program(this, "GodPunter",     Colors.PROG_1, group[0].x, group[0].y+80));

    programs.add(new Program(this, "Subzero",       Colors.PROG_3, group[1].x, group[1].y));
    programs.add(new Program(this, "Firetoolz",     Colors.PROG_2, group[1].x, group[1].y+40));
    programs.add(new Program(this, "Daemon",        Colors.PROG_1, group[1].x, group[1].y+80));

    programs.add(new Program(this, "Lambda",        Colors.PROG_3, group[2].x, group[2].y));
    programs.add(new Program(this, "Shodan",        Colors.PROG_2, group[2].x, group[2].y+40));
    programs.add(new Program(this, "Tron",          Colors.PROG_1, group[2].x, group[2].y+80));

    programs.add(new Program(this, "Supr AI",       Colors.PROG_3, group[3].x, group[3].y));
    programs.add(new Program(this, "Mega ML",       Colors.PROG_2, group[3].x, group[3].y+40));
    programs.add(new Program(this, "The Engine",    Colors.PROG_1, group[3].x, group[3].y+80));

    programs.add(new Program(this, "Misfit",        Colors.PROG_3, group[4].x, group[4].y));
    programs.add(new Program(this, "The Brain",     Colors.PROG_2, group[4].x, group[4].y+40));
    programs.add(new Program(this, "Logic",         Colors.PROG_1, group[4].x, group[4].y+80));

    programs.add(new Program(this, "MARAK",         Colors.PROG_3, group[5].x, group[5].y));
    programs.add(new Program(this, "Kosmokrator",   Colors.PROG_2, group[5].x, group[5].y+40));
    programs.add(new Program(this, "EPICAC",        Colors.PROG_1, group[5].x, group[5].y+80));

    programs.add(new Program(this, "XMARK V",       Colors.PROG_3, group[6].x, group[6].y));
    programs.add(new Program(this, "Prime Radiant", Colors.PROG_2, group[6].x, group[6].y+40));
    programs.add(new Program(this, "Mima",          Colors.PROG_1, group[6].x, group[6].y+80));

    programs.add(new Program(this, "XGold",         Colors.PROG_3, group[7].x, group[7].y));
    programs.add(new Program(this, "Bossy",         Colors.PROG_2, group[7].x, group[7].y+40));
    programs.add(new Program(this, "XMultivac",     Colors.PROG_1, group[7].x, group[7].y+80));


    programs.add(new Program(this, "LEVIN",         Colors.PROG_4, group[8].x, group[8].y));
    programs.add(new Program(this, "Arius",         Colors.PROG_4, group[8].x, group[8].y+40));
    programs.add(new Program(this, "Tokugawa",      Colors.PROG_4, group[8].x, group[8].y+80));

    programs.add(new Program(this, "Ghostwheel",    Colors.PROG_3, group[9].x, group[9].y));
    programs.add(new Program(this, "Mandarax",      Colors.PROG_3, group[9].x, group[9].y+40));
    programs.add(new Program(this, "Teletran",      Colors.PROG_4, group[9].x, group[9].y+80));

    programs.add(new Program(this, "Valentina",     Colors.PROG_2, group[10].x, group[10].y));
    programs.add(new Program(this, "Loki 7281",     Colors.PROG_2, group[10].x, group[10].y+40));
    programs.add(new Program(this, "Cyclops",       Colors.PROG_4, group[10].x, group[10].y+80));

    programs.add(new Program(this, "VALIS",         Colors.PROG_1, group[11].x, group[11].y));
    programs.add(new Program(this, "Spartacus",     Colors.PROG_1, group[11].x, group[11].y+40));
    programs.add(new Program(this, "JEVEX",         Colors.PROG_4, group[11].x, group[11].y+80));

    programs.add(new Program(this, "UNITRACK",      Colors.PROG_1, group[12].x, group[12].y));
    programs.add(new Program(this, "Proteus",       Colors.PROG_1, group[12].x, group[12].y+40));
    programs.add(new Program(this, "Extro",         Colors.PROG_4, group[12].x, group[12].y+80));

    programs.add(new Program(this, "Minerva",       Colors.PROG_2, group[13].x, group[13].y));
    programs.add(new Program(this, "Pallas Athena", Colors.PROG_2, group[13].x, group[13].y+40));
    programs.add(new Program(this, "Project 79",    Colors.PROG_4, group[13].x, group[13].y+80));

    programs.add(new Program(this, "The Berserker", Colors.PROG_3, group[14].x, group[14].y));
    programs.add(new Program(this, "Little Brother",Colors.PROG_3, group[14].x, group[14].y+40));
    programs.add(new Program(this, "Merlin",        Colors.PROG_4, group[14].x, group[14].y+80));

    programs.add(new Program(this, "Colossus",      Colors.PROG_4, group[15].x, group[15].y));
    programs.add(new Program(this, "Frost",         Colors.PROG_4, group[15].x, group[15].y+40));
    programs.add(new Program(this, "Vulcan 3",      Colors.PROG_4, group[15].x, group[15].y+80));

    // first layer                    persist x    y    width
    firewalls.add(new Firewall(this,   true,    0, 600, 400, 3));
    firewalls.add(new Firewall(this,   true,  600, 600, 400, 3));

    // 2nd layer
    firewalls.add(new Firewall(this,  false,  120, 530, 720, 3));

    // 3rd layer left path
    firewalls.add(new Firewall(this,  false,    0, 460, 200, 3));
    firewalls.add(new Firewall(this,  false,  400, 460, 200, 3));
    firewalls.add(new Firewall(this,  false,  800, 460, 200, 3));

    // side borders
    firewalls.add(new Firewall(this,   true,   -3, 460, 3, 130));
    firewalls.add(new Firewall(this,   true, 1000, 460, 3, 130));
  }


  function createNetConns(){
    createNetCnx(subsystems[0], subsystems[3]);
    createNetCnx(subsystems[1], subsystems[5]);
    createNetCnx(subsystems[2], subsystems[6]);
    createNetCnx(subsystems[3], subsystems[7]);
    createNetCnx(subsystems[4], subsystems[8]);
    createNetCnx(subsystems[5], subsystems[9]);
    createNetCnx(subsystems[5], subsystems[4]);
    createNetCnx(subsystems[6], subsystems[10]);
    createNetCnx(subsystems[7], subsystems[11]);
    createNetCnx(subsystems[8], subsystems[12]);
    createNetCnx(subsystems[9], subsystems[10]);
    createNetCnx(subsystems[10], subsystems[14]);
    createNetCnx(subsystems[10], subsystems[9]);
    createNetCnx(subsystems[11], subsystems[12]);
    createNetCnx(subsystems[12], subsystems[13]);
    createNetCnx(subsystems[13], subsystems[15]);
    createNetCnx(subsystems[14], subsystems[16]);
    createNetCnx(subsystems[16], subsystems[15]);
  }


  // this is only used for design, these will be loaded on server state
  // this function won't be called in real game
  function designSubSystems(){

    var cols = [ 80, 325, 570, 815 ];
    var rows = [ 364, 272, 182, 92, 2 ];

    // 1st layer [0]
    subsystems.push(new Box(this, "Mail Server",         cols[0], rows[0]));
    subsystems.push(new Box(this, "Proxy",               cols[2], rows[0]));
    subsystems.push(new Box(this, "VPN",                 cols[3], rows[0]));

    // 2nd layer [3]
    subsystems.push(new Box(this, "Backup Server",       cols[0], rows[1]));
    subsystems.push(new Box(this, "Web Server",          cols[1], rows[1]));
    subsystems.push(new Box(this, "Router",              cols[2], rows[1]));
    subsystems.push(new Box(this, "Intranet svc",        cols[3], rows[1]));

    // 3rd layer [7]
    subsystems.push(new Box(this, "Domain Control",      cols[0], rows[2]));
    subsystems.push(new Box(this, "Web Database",        cols[1], rows[2]));
    subsystems.push(new Box(this, "Auth Control",        cols[2], rows[2]));
    subsystems.push(new Box(this, "R&D Beta svc",        cols[3], rows[2]));

    // 4th layer [11]
    subsystems.push(new Box(this, "FIREWALL A\nCONTROLLER",cols[0], rows[3]));
    subsystems.push(new Box(this, "Admin Portal",        cols[1], rows[3]));
    subsystems.push(new Box(this, "Admin DB",            cols[2], rows[3]));
    subsystems.push(new Box(this, "AI/ML Control",       cols[3], rows[3]));

    // 5th layer [15]
    subsystems.push(new Box(this, "ENCRYPTED\nDATA STORE",cols[2], rows[4]));
    subsystems.push(new Box(this, "FIREWALL B\nCONTROLLER", cols[3], rows[4]));

  }
}
