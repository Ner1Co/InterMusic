class Instrument implements MuObject {
  TuioObject tobj; 
  Knob knob;
  int value;
  int channel;
  //ArrayList waves = new ArrayList();

  Instrument(TuioObject tobj, int channel) {
    this.tobj = tobj;
    this.channel = channel;
    init();
  }
  
  void update(){
    mainBus.sendNoteOff(channel, value, 20);
    value = (int)(tobj.getAngle() / (2.0*PI)*127);
    mainBus.sendNoteOn(channel, value, 100);
  }
  
  MuObjectType getType(){
    return MuObjectType.INSTRUMENT;
  }


  void init() {
    //waves.add(new Wave(0));
    action();
  }

  void display() {
    stroke(0);
    fill(255, 220, 255);
    //noFill();
    strokeWeight(1);
    pushMatrix();
    translate(tobj.getScreenX(width), tobj.getScreenY(height));
    rotate(tobj.getAngle());

    rect(-obj_size/2, -obj_size/2, obj_size, obj_size);

    popMatrix();
    fill(0);
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
    
     // for (int j = waves.size()-1; j >= 0; j--) {
     //    Wave wave = (Wave) waves.get(j);
     //    wave.display();
     //    if (wave.power<=0) {
     //        waves.remove(j);
     //    }
    // }
  }
  
  void action(){
       value = (int)(tobj.getAngle() / (2.0*PI)*127);
       mainBus.sendNoteOn(channel, value, 100);
  }
  
  //TODO
  void dismiss(){
    mainBus.sendNoteOff(channel, value, 0);
  }
}
