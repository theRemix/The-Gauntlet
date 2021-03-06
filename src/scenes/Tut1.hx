/*
- scene.Tut1 -> Goals
    - You start with 600 seconds of in game time to access the Encrypted Backup Server that holds the data you are stealing
    - You will know if you have succeeded because you will see this sign [RUN SUCCESSFUL][YOU STOLE THE DATA]
    - You may fail by getting caught in game
    - You may fail by running out of time, this can cause Intrusion Detection Systems to lock out all your connections, and/or SysOps tracing one of you, and/or brain damage on BMI connected
    - You will know if you have failed by the GM pausing the simulation and telling you how you failed
*/

package scenes;

import io.colyseus.serializer.schema.Schema;

class Tut1 extends h2d.Scene{

  private var font:h2d.Font;
  private var headline:h2d.Text;
  private var steps:Array<h2d.Text>;

  public function new(){
    super();

    font = hxd.res.DefaultFont.get();

    headline = new h2d.Text(font, this);
    headline.text = "GOALS";
    headline.scale(2);
    headline.x = 200;
    headline.y = 20;

    var x = 20;
    var y = 60;
    var yspace = 40;

    steps = [
      createStep("You start with 600 seconds to access the ENCRYPTED DATA STORE.", x, y),
      createStep("You will know if you have succeeded because you will see this sign [RUN SUCCESSFUL][YOU STOLE THE DATA].", x, y+yspace),
      createStep("You will know if you have failed by the GM pausing the simulation and telling you how you failed.", x, y+yspace*2),
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

  public override function dispose(){
    if(Main.instance.room.state.tutStep.onChange == onTutStepChange){
      Main.instance.room.state.tutStep.onChange = null;
    }

    super.dispose();
  }
}
