/*
- scene.Tut3 -> Hacking Instructions
    - Choose a subsystem to make a run
    - You may jack out of a subsystem to run on another
    - Run Programs on subsystems to break in
    - To run a program, simply drag the program onto the subsystem
    - If the program was not the correct one, it will flash red
    - If the program was the correct one, it will flash blue, the subsystem will be ACCESSED and your team can now connect to any connected subsystems
    - Firewalls block programs, avoid them!
    - Multiple programs can be used to access a subsystem, having lots of programs is generally a good thing
    - Depending on your Skills and Int levels, you will each have different programs.
*/

package scenes;

import io.colyseus.serializer.schema.Schema;

class Tut3 extends h2d.Scene{

  private var font:h2d.Font;
  private var headline:h2d.Text;
  private var steps:Array<h2d.Text>;

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
      createStep("Choose a subsystem to make a run.", x, y),
      createStep("You may jack out of a subsystem to run on another.", x, y+yspace),
      createStep("Run Programs on subsystems to break in.", x, y+yspace*2),
      createStep("To run a program, simply drag the program onto the subsystem.", x, y+yspace*3),
      createStep("If the program was not the correct one, it will flash red.", x, y+yspace*4),
      createStep("If the program was the correct one, it will flash blue,\n  the subsystem will be ACCESSED and your team can now connect to any connected subsystems.", x, y+yspace*5),
      createStep("Firewalls block programs, avoid them!", x, y+yspace*6),
      createStep("Multiple programs can be used to access a subsystem, having lots of programs is generally a good thing.", x, y+yspace*7),
      createStep("Depending on your Skills and Int levels, you will each have different programs.", x, y+yspace*8),
    ];

    var stepVals = Main.instance.room.state.tutStep.items;
    for(i in 0...steps.length) steps[i].visible = stepVals[i];

    Main.instance.room.state.tutStep.onAdd =
    Main.instance.room.state.tutStep.onRemove =
    Main.instance.room.state.tutStep.onChange = onTutStepChange;
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

  public function destroy(){
    if(Main.instance.room.state.tutStep.onChange == onTutStepChange){
      Main.instance.room.state.tutStep.onChange = null;
    }

    super.dispose();
  }
}
