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
    // tf.text = "MegaCorp Network";
    tf.scale(2);
    tf.x = 20;
    tf.y = 10;

    // for(s in Main.instance.room.state.practiceNet){
    //   subsystems.push(new Box(this, s.name, s.x, s.y));
    // }
    designSubSystems();

    loadNoobProgs();
    // loadHackerProgs();

    for(p in programs){
      p.colliders = firewalls.map(function(f) return f.getBounds());
    }

  }

  function loadNoobProgs(){

    var group = [
      { x: 110, y: 870 },
      { x: 210, y: 870 },
      { x: 310, y: 870 },
      { x: 410, y: 870 },
      { x: 510, y: 870 },
      { x: 610, y: 870 },
      { x: 710, y: 870 },
      { x: 810, y: 870 },
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

    // first layer                   x    y    width
    firewalls.add(new Firewall(this,   0, 830, 400, 3));
    firewalls.add(new Firewall(this, 600, 830, 400, 3));

    // 2nd layer
    firewalls.add(new Firewall(this, 120, 760, 760, 3));

    // 3rd layer left path
    firewalls.add(new Firewall(this,   0, 690, 400, 3));

    // 4th layer left path
    firewalls.add(new Firewall(this, 120, 620, 400, 3));

    // 5th layer left path
    firewalls.add(new Firewall(this,   0, 550, 400, 3));

    // mid vertical
    firewalls.add(new Firewall(this, 520, 550, 3, 170));

    // 3rd layer right path
    firewalls.add(new Firewall(this, 780, 690, 100, 3));
    firewalls.add(new Firewall(this, 880, 690, 3, 73));

    // 4th layer right path
    firewalls.add(new Firewall(this, 660, 620, 360, 3));
    firewalls.add(new Firewall(this, 660, 620, 3, 73));

    // 5th layer right path
    firewalls.add(new Firewall(this, 520, 550, 320, 3));

    // side borders
    firewalls.add(new Firewall(this, -3, 550, 3, 280));
    firewalls.add(new Firewall(this, 1000, 550, 3, 280));

  }

  function loadHackerProgs(){

    var group = [
      { x: 110, y: 720 },
      { x: 210, y: 720 },
      { x: 310, y: 720 },
      { x: 410, y: 720 },
      { x: 510, y: 720 },
      { x: 610, y: 720 },
      { x: 710, y: 720 },
      { x: 810, y: 720 },

      { x: 110, y: 860 },
      { x: 210, y: 860 },
      { x: 310, y: 860 },
      { x: 410, y: 860 },
      { x: 510, y: 860 },
      { x: 610, y: 860 },
      { x: 710, y: 860 },
      { x: 810, y: 860 },
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

    // first layer                   x    y    width
    firewalls.add(new Firewall(this,   0, 680, 400, 3));
    firewalls.add(new Firewall(this, 600, 680, 400, 3));

    // 2nd layer
    firewalls.add(new Firewall(this, 120, 610, 720, 3));

    // 3rd layer left path
    firewalls.add(new Firewall(this,   0, 550, 200, 3));
    firewalls.add(new Firewall(this, 400, 550, 200, 3));
    firewalls.add(new Firewall(this, 800, 550, 200, 3));

    // side borders
    firewalls.add(new Firewall(this, -3, 550, 3, 280));
    firewalls.add(new Firewall(this, 1000, 550, 3, 280));
  }

  // this is only used for design, these will be loaded on server state
  // this function won't be called in real game
  function designSubSystems(){

    var cols = [ 80, 325, 570, 815 ];
    var rows = [ 440, 330, 220, 110, 2 ];

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
    subsystems.push(new Box(this, "FIREWALL\nCONTROLLER",cols[0], rows[3]));
    subsystems.push(new Box(this, "Admin Portal",        cols[1], rows[3]));
    subsystems.push(new Box(this, "Admin DB",            cols[2], rows[3]));
    subsystems.push(new Box(this, "AI/ML Control",       cols[3], rows[3]));

    // 5th layer [15]
    subsystems.push(new Box(this, "ENCRYPTED\nDATA STORE",cols[2], rows[4]));
    subsystems.push(new Box(this, "FIREWALL\nCONTROLLER", cols[3], rows[4]));

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
}
