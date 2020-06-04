package scenes;

import h2d.Graphics;
import h2d.Text;
import h2d.col.Bounds;

import entities.Program;
import entities.Box;
import entities.Firewall;

using Lambda;

class SystemCnxLine extends Graphics {
  static inline var LINE_THICKNESS = 3;

  public var source:Box;
  var dest:Box;

  public function new(scene:SimBase, source:Box, dest:Box) {
    super(scene);
    this.source = source;
    this.dest = dest;

    beginFill(Colors.NET_NO_ACCESS);
    drawLine();
    endFill();
  }

  public function enableCnx(){
    beginFill(Colors.NET_ACCESS);
    drawLine();
    endFill();
  }

  function drawLine(){
    if(source.x == dest.x){ // vertical
      drawRect(source.x + Box.WIDTH/2, source.y + Box.HEIGHT/2, LINE_THICKNESS, dest.y - source.y);
    } else { // horizontal
      drawRect(source.x + Box.WIDTH/2, source.y + Box.HEIGHT/2, dest.x - source.x, LINE_THICKNESS);
    }
  }

}

class SimBase extends h2d.Scene{

  private var subsystems:Array<Box>;
  private var programs:List<Program>;
  private var firewalls:List<Firewall>;
  private var cnx:List<SystemCnxLine>;

  private var _stageBounds:Bounds;

  private var timerText:Text;

  private var curPauseOverlay:String;
  private var pauseOverlayDim:Graphics;
  private var pauseOverlayDark:Graphics;

  private var overlayText:Text;

  public function new(){
    super();

    this.programs = new List<Program>();
    this.firewalls = new List<Firewall>();
    this.subsystems = new Array<Box>();
    this.cnx = new List<SystemCnxLine>();

    _stageBounds = Bounds.fromValues(0,0,1000,1000);

    var font = hxd.res.DefaultFont.get();

    timerText = new h2d.Text(font, this);
    timerText.scale(2);
    timerText.x = 20;
    timerText.y = 40;

    overlayText = new h2d.Text(font, this);
    overlayText.scale(2);
    overlayText.x = 400;
    overlayText.y = 400;

    pauseOverlayDim = new Graphics(this);
    pauseOverlayDim.beginFill(Colors.NET_NO_ACCESS, 0.5);
    pauseOverlayDim.drawRect(0,0,1000,1000);
    pauseOverlayDim.endFill();
    pauseOverlayDim.visible = false;

    pauseOverlayDark = new Graphics(this);
    pauseOverlayDark.beginFill(Colors.NET_NO_ACCESS, 1);
    pauseOverlayDark.drawRect(0,0,1000,1000);
    pauseOverlayDark.endFill();
    pauseOverlayDark.visible = false;

    Main.instance.sceneUpdate = update;
    Main.instance.room.state.practiceNet.onChange =
    Main.instance.room.state.realNet.onChange = onNetChange;
  }

  private inline function onNetChange(ss:SubSystem, key:Int) {
    subsystems[key].syncProps(ss);
  }

  public function update(dt:Float) {
    checkCollisions();
    if(timerText.text != Std.string(Main.instance.room.state.timer)){
      timerText.text = Std.string(Main.instance.room.state.timer);
    }
    if(curPauseOverlay != Main.instance.room.state.pauseOverlay){
      curPauseOverlay = Main.instance.room.state.pauseOverlay;
      switch(curPauseOverlay){
        case "dim":
          overlayText.text = "[ PAUSED ]";
          pauseOverlayDim.visible = true;
          pauseOverlayDark.visible = false;
          // bring overlay forward
          this.children.push(this.children.splice(this.children.indexOf(pauseOverlayDim), 1)[0]);
          this.children.push(this.children.splice(this.children.indexOf(overlayText), 1)[0]);
        case "dark":
          overlayText.text = "[ PAUSED ]";
          pauseOverlayDim.visible = false;
          pauseOverlayDark.visible = true;
          // bring overlay forward
          this.children.push(this.children.splice(this.children.indexOf(pauseOverlayDark), 1)[0]);
          this.children.push(this.children.splice(this.children.indexOf(overlayText), 1)[0]);
        case "win":
          overlayText.text = "[RUN SUCCESSFUL]\n[YOU STOLE THE DATA]";
          pauseOverlayDim.visible = true;
          pauseOverlayDark.visible = false;
          // bring overlay forward
          this.children.push(this.children.splice(this.children.indexOf(pauseOverlayDim), 1)[0]);
          this.children.push(this.children.splice(this.children.indexOf(overlayText), 1)[0]);
        case "":
          overlayText.text = "";
          pauseOverlayDim.visible = false;
          pauseOverlayDark.visible = false;
        default:
          trace('WARN: unhandled pauseOverlay: $curPauseOverlay');
      }
    }
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

  public function onBoxOwned(b:Box){
    for(c in cnx.filter(function(a) return a.source == b)){
      c.enableCnx();
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
    if(Main.instance.sceneUpdate == update){
      Main.instance.sceneUpdate = null;
    }
    if(Main.instance.room.state.practiceNet.onChange == onNetChange){
      Main.instance.room.state.practiceNet.onChange = null;
    }
    if(Main.instance.room.state.realNet.onChange == onNetChange){
      Main.instance.room.state.realNet.onChange = null;
    }
  }

}
