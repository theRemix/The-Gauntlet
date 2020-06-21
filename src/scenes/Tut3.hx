/*
- scene.Tut3 -> Hacking Instructions
    - Run Programs on subsystems to break in
    - To run a program, simply drag the program onto the subsystem
    - If the program was not the correct one, it will flash red
    - If the program was the correct one, it will flash blue, the subsystem will be ACCESSED and your team can now connect to any connected subsystems
    - Some SubSystems are not accessible from the net, so you must enter through other systems
    - Firewalls block programs, avoid them!
    - Multiple programs can be used to access a subsystem, having lots of programs is generally a good thing
    - Depending on your Skills and Int levels, you will each have different programs.
*/

package scenes;

import io.colyseus.serializer.schema.Schema;
import entities.Program;
import entities.Box;

class Tut3 extends h2d.Scene{

  private var font:h2d.Font;
  private var headline:h2d.Text;
  private var steps:Array<h2d.Object>;

  public function new(){
    super();

    font = hxd.res.DefaultFont.get();

    headline = new h2d.Text(font, this);
    headline.text = "HACKING INSTRUCTIONS";
    headline.scale(2);
    headline.x = 200;
    headline.y = 20;

    var x = 20;
    var y = 60;
    var yspace = 40;

    steps = [
      createStep1(x, y),
      createStep2(x, y+yspace),
      createStep("Some subsystems are not accessible from the net, so you must enter through other systems.", x, y+yspace*2),
      createStep4(x, y+yspace*3),
      createStep("Firewalls block programs, avoid them!", x, y+yspace*4),
      createStep("Multiple programs can be used to access a subsystem.\n  Having lots of programs is generally a good thing.", x, y+yspace*5),
    ];

    var stepVals = Main.instance.room.state.tutStep.items;
    for(i in 0...steps.length) steps[i].visible = stepVals[i];

    Main.instance.room.state.tutStep.onAdd =
    Main.instance.room.state.tutStep.onRemove =
    Main.instance.room.state.tutStep.onChange = onTutStepChange;
  }

  private inline function createStep1(x, y):h2d.Object{
    var step = new h2d.Object(this);
    step.x = x;
    step.y = y;

    var line = new h2d.Text(font, step);
    line.text = "Run Programs on subsystems to break in.";

    var program1 = new Program(step, "Subzero", Colors.PROG_3, 400, 0);
    var program2 = new Program(step, "Tron",    Colors.PROG_2, 500, 0);
    var program3 = new Program(step, "Supr AI", Colors.PROG_4, 600, 0);

    var progLabel = new h2d.Text(font, step);
    progLabel.text = "Programs";
    progLabel.x = 510;
    progLabel.y = 40;

    var accessibleSys = new Box(step, "Door Locks", 740, -20);
    var inaccessibleSys = new Box(step, "Door Locks", 860, -20);
    inaccessibleSys.makeInaccessible();

    var sysLabel = new h2d.Text(font, step);
    sysLabel.text = "Accessible             Inaccessible\nSubSytem               SubSystem";
    sysLabel.x = 760;
    sysLabel.y = 70;

    return step;
  }

  private inline function createStep2(x, y):h2d.Object{
    var step = new h2d.Object(this);
    step.x = x;
    step.y = y;

    var line = new h2d.Text(font, step);
    line.text = "To run a program, drag the program onto the subsystem.";

    var accessibleSys = new Box(step, "Door Locks\nNoise\nWhizzard", 740, 120);

    var sysLabel = new h2d.Text(font, step);
    sysLabel.text = "Runners\n Listed";
    sysLabel.x = 760;
    sysLabel.y = 210;
    return step;
  }

  private inline function createStep4(x, y):h2d.Object{
    var step = new h2d.Object(this);
    step.x = x;
    step.y = y;

    var line = new h2d.Text(font, step);
    line.text = "If the program is correct,\n  the subsystem will be PWNED and your team can access any connected subsystems.";

    var ownedSys = new Box(step, "Door Locks", 860, 40);
    var ss = new SubSystem();
    ss.owned = true;
    ss.ownedBy = "Whizzard";
    ownedSys.syncProps(ss);

    var sysLabel = new h2d.Text(font, step);
    sysLabel.text = "   Pwned\nSubSystem";
    sysLabel.x = 876;
    sysLabel.y = 130;
    return step;
  }

  private inline function createStep(text, x, y):h2d.Text{
    var step = new h2d.Text(font, this);
    step.text = text;
    step.x = x;
    step.y = y;

    return step;
  }

  private inline function onTutStepChange(item:Bool, key:Int) {
    var stepVals = Main.instance.room.state.tutStep.items;
    steps[key].visible = item;
  }

  public override function dispose(){
    if(Main.instance.room.state.tutStep.onChange == onTutStepChange){
      Main.instance.room.state.tutStep.onChange = null;
    }

    super.dispose();
  }
}
