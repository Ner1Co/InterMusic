class Instrument extends Effected {
  Knob knob;
  int value;
  int channel;
  //ArrayList waves = new ArrayList();
  
  Instrument(TuioObject tobj, int channel) {
    super(tobj);
    this.channel = channel;
    
    setChannels();
      
    init();
  }
  
  void setChannels(){
    this.volumeCtrl = tobj.getSymbolID();
    this.reverbCtrl = tobj.getSymbolID() + 10;
    this.gateCtrl = tobj.getSymbolID() + 20;
    this.equalizerCtrl = tobj.getSymbolID() + 30;
  }

  
  void update(){
    mainBus.sendNoteOff(channel, MuMusic.currentScale[(int)value], 20);
    value = (int)(tobj.getAngle() / (2.0*PI)*127);
    mainBus.sendNoteOn(channel, MuMusic.currentScale[(int)value], 100);
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

    //rect(-obj_size/2, -obj_size/2, obj_size, obj_size);
    polygon(0, 0, obj_size, 6);

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
       mainBus.sendNoteOn(channel, MuMusic.currentScale[(int)value], 100);
  }
  
  //TODO
  void dismiss(){
    mainBus.sendNoteOff(channel, MuMusic.currentScale[(int)value], 0);
  }
}
