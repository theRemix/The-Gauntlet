package entities;

import h2d.Scene;
import h2d.Graphics;
import h2d.Interactive;
import h2d.Text;
import hxd.Event;
import h2d.col.Bounds;
import h2d.col.Point;

class Program extends Graphics{

  static inline var WIDTH = 80;
  static inline var HEIGHT = 30;

  var label:Text;
  var int:Interactive;
  var origin:{x:Float,y:Float}; // program returns to origin
  var offset:{x:Float,y:Float}; // for dnd

  public var active(get, null):Bool;
  inline function get_active():Bool{
    return int.isOver() && (this.x != origin.x || this.y != origin.y);
  }

  public var colliders:List<Firewall>;

  public function new(scene:Scene, name:String, color:Int, x:Int, y:Int) {
    super(scene);
    this.name = name;
    this.x = x;
    this.y = y;
    this.origin = {x:x,y:y};
    this.offset = {x:x,y:y};
    this.colliders = new List<Firewall>();

    beginFill(color);
    drawRect(0, 0, WIDTH, HEIGHT);
    endFill();

    var font = hxd.res.DefaultFont.get();
    label = new Text(font, this);
    label.x = 3;
    label.y = 6;
    label.text = name;
    label.textColor = 0x0;

    this.int = new Interactive(WIDTH, HEIGHT, this);
    int.onPush = click;
    int.onRelease = release;

  }

  public function resetPos(){
    this.x = this.origin.x;
    this.y = this.origin.y;
    int.stopDrag();
  }

  // on drag
  function _move(x:Float, y:Float):Bool {
    var maxStep = 5;
    var dx = x - this.x;
    var dy = y - this.y;
    var steps = Math.ceil(Math.sqrt(dx * dx + dy * dy) / maxStep);
    var step = 1 / steps;
    var b = getBounds();
    for (i in 0...steps){
      var a = Bounds.fromValues(x + dx * step * i, y + dy * step * i, WIDTH, HEIGHT);
      for(c in colliders.filter(function(a) return !a.persist && a.visible))
        if(c.getBounds().intersects(a)) return false;

    }

    this.x = x;
    this.y = y;
    return true;
  }

  function click(e:Event) {
    bring_to_front();
    int.startDrag(drag);
    offset = {x:e.relX, y:e.relY};
  }

	function release(e:Event) {
		resetPos();
	}

	function drag(e:Event)
	{
    if(e.kind != hxd.EventKind.EMove) return;

    if (!_move(x + e.relX - offset.x, y + e.relY - offset.y))
      resetPos();
	}

	function bring_to_front()
	{
		parent.children.push(parent.children.splice(parent.children.indexOf(this), 1)[0]);
	}

}

/*
  Some names

  Shroomz
  AOHell
  GodPunter
  Subzero
  Firetoolz

  Daemon
  Lambda
  Shodan
  Tron
  Supr AI
  Mega ML
  The Engine
  Misfit
  The Brain
  Logic
  MARAK
  Kosmokrator
  EPICAC
  MARK V
  Prime Radiant
  Mima
  Gold
  Bossy
  Multivac
  Miniac
  Microvac
  Galactic AC
  Universal AC
  Cosmic AC
  AC
  Vulcan 2
  Vulcan 3
  Coordinator
  Merlin
  Simulacron-3
  GENiE
  Muddlehead
  Colossus
  Guardian
  Frost
  Mycroft Holmes
  The Ox
  Supreme
  WESCAC
  Moxon
  Little Brother
  AM
  The Berserker
  Shalmaneser
  Project 79
  ARDNEH
  Fess
  Maxine
  HARLIE
  TECT
  Dora
  Minerva
  Pallas Athena
  Proteus
  Extro
  UNITRACK
  Peerssa
  Obie
  TOTAL
  ZORAC
  JEVEX
  Spartacus
  VALIS
  Hactar
  Shirka
  Cyclops
  Loki 7281
  Valentina
  Teletran
  Mandarax
  Ghostwheel
  Tokugawa
  Quark II
  Arius
  LEVIN

  Plague
  Trinity
  F8th
  Hauk
  Dark0
  W1n5t0n
  M1K3Y
  Crake
  Apoc
  Cypher
  Dozer
  Ghost
  Morpheus
  Mouse
  Neo
  Switch
  Tank


*/

