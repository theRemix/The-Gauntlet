/*
- scene.Tut2 -> Rules
    - Players can, and should communicate in real time
    - GM can pause at any time, freezing time for RP
    - Players can ask the GM to pause for reasons of RP, not to strategize on the actual simulation.
    - If players talk about simulation strategy this must happen in game time, GM will unpause.
    - Surely you can discuss strategy while hacking!.
    - GM can manually manipulate some things in the simulation, this power is used for fixing things, or to sync the simulation with any in world events
    - Depending on your Skills and Int levels, you will each have different programs.
    - Program names don't have meaning.
    - SubSystem names DO have meaning.
*/

package scenes;

import io.colyseus.serializer.schema.Schema;

class Tut2 extends h2d.Scene{

  private var font:h2d.Font;
  private var headline:h2d.Text;
  private var steps:Array<h2d.Text>;

  public function new(){
    super();

    font = hxd.res.DefaultFont.get();

    headline = new h2d.Text(font, this);
    headline.text = "RULES";
    headline.scale(2);
    headline.x = 200;
    headline.y = 20;

    var x = 20;
    var y = 60;
    var yspace = 40;

    steps = [
      createStep("Players can, and should communicate in real time.", x, y),
      createStep("GM can pause at any time, freezing time for RP.", x, y+yspace),
      createStep("Players can ask the GM to pause for reasons of RP, not to strategize on the actual simulation.", x, y+yspace*2),
      createStep("If players talk about simulation strategy this must happen in game time, GM will unpause.\n  Surely you can discuss strategy while hacking!", x, y+yspace*3),
      createStep("GM can manually manipulate some things in the simulation, this power is used for fixing things, or to sync the simulation with any in world events.", x, y+yspace*4),
      createStep("Depending on your Skills and Int levels, you will each have different programs.", x, y+yspace*5),
      createStep("Program names don't have meaning.", x, y+yspace*6),
      createStep("SubSystem names DO have meaning.", x, y+yspace*7)
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
