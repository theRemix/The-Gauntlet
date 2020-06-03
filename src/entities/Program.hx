package entities;

import h2d.Scene;
import h2d.Graphics;
import h2d.Interactive;
import h2d.Text;
import hxd.Event;
import h2d.col.Bounds;

class Program extends Graphics{

  var label:Text;
  var int:Interactive;
  var origin:{x:Float,y:Float}; // program returns to origin
  var last:{x:Float, y:Float}; // for dnd
  var offset:{x:Float,y:Float}; // for dnd

  public var active(get, null):Bool;
  public function get_active():Bool{
    return int.isOver() && (this.x != origin.x || this.y != origin.y);
  }

  public function new(scene:Scene, name:String, color:Int, x:Int, y:Int, w:Int, h:Int) {
    super(scene);
    this.name = name;
    this.x = x;
    this.y = y;
    this.origin = {x:x,y:y};
    this.last = {x:x,y:y};
    this.offset = {x:x,y:y};

    beginFill(color);
    drawRect(0, 0, w, h);
    endFill();

    var font = hxd.res.DefaultFont.get();
    label = new Text(font, this);
    label.x = 8;
    label.y = 8;
    label.text = name;
    label.textColor = 0x0;

    this.int = new Interactive(w, h, this);
    int.onPush = click;
    int.onRelease = release;
  }

  public function resetPos(){
    this.x = this.origin.x;
    this.y = this.origin.y;
    int.stopDrag();
  }

  function click(e:Event) {
    bring_to_front();
    int.startDrag(drag);
    offset = {x:e.relX, y:e.relY};
    last.x = x;
    last.y = y;
  }

	function release(e:Event) {
		int.stopDrag();
	}

	function drag(e:Event)
	{
		x += e.relX - offset.x;
		y += e.relY - offset.y;
	}

	function bring_to_front()
	{
		parent.children.push(parent.children.splice(parent.children.indexOf(this), 1)[0]);
	}

}

