package entities;

import h2d.Scene;
import h2d.Graphics;
import h2d.Interactive;
import h2d.Text;
import hxd.Event;
import h2d.col.Bounds;
import h2d.col.Line;
import h2d.col.Point;

class Firewall extends Graphics{

  public var colLine:Line;
  public var persist:Bool; // even when fw is disabled, these remain

  public function new(scene:Scene, persist:Bool, x:Int, y:Int, w:Int, h:Int) {
    super(scene);
    this.x = x;
    this.y = y;
    this.persist = persist;

    colLine = new Line(new Point(x, y), new Point(x+w,y+h));

    beginFill(Colors.FIREWALL);
    drawRect(0, 0, w, h);
    endFill();
  }
}

