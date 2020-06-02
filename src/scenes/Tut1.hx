/*
- scene.Tut1 -> Goals
    - You start with 600 seconds of in game time to access the Encrypted Backup Server that holds the data you are stealing
    - You will know if you have succeeded because you will see this sign [RUN SUCCESSFUL, YOU STOLE THE DATA]
    - You may fail by getting caught in game
    - You may fail by running out of time, this can cause Intrusion Detection Systems to lock out all your connections, and/or SysOps tracing one of you, and/or brain damage on BMI connected
    - You will know if you have failed by the GM pausing the simulation and telling you how you failed
*/

package scenes;

class Tut1 extends StatefulScene{

  private var font:h2d.Font;
  private var headline:h2d.Text;
  private var step1:h2d.Text;

  public function new(){
    super();

    font = hxd.res.DefaultFont.get();

    var x = 80;
    var y = 40;
    var yspace = 40;

    headline = new h2d.Text(font, this);
    headline.text = "GOALS";
    headline.text = "GOALS";

    step1 = new h2d.Text(font, this);
    step1.text = "You start with 600 seconds of in game time to access the Encrypted Backup Server that holds the data you are stealing";

    // playerListTxt = new h2d.Text(font, this);
    // playerListTxt.text = "Users connected:";

    // Main.instance.room.state.onChange += onTutStepChange;
  }

  override function onStateChange(state) {
    trace("Tut1 onstatechange", state);
  }

  // private inline function onTutStepChange(tutData) {
  //   trace('tutData', tutData);
  // }

  public function destroy(){
    trace("Scene:Tut1 DISPOSE");

    super.dispose();
  }
}
