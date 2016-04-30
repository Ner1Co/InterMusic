class Instrument implements MuObject {
  TuioObject tobj; 
  Knob knob;
  ArrayList waves = new ArrayList();

  Instrument(TuioObject tobj) {
    this.tobj = tobj;
    init();
  }
  
  void update(){
  }
  
  MuObjectType getType(){
    return MuObjectType.INSTRUMENT;
  }

  void beat(){
    waves.add(new Wave(0));
  }

  void init() {
    // knob = cp5.addKnob(str(tobj.getSymbolID()))
    //   .setRange(0, 127)
    //   .setValue(50)
    //   .setPosition(100, 70)
    //   .setRadius(130)
    //   .setStringValue("")
    //   .setColorBackground(color(255, 255, 255))
    //   .setViewStyle(Knob.ARC)
    //   .setDragDirection(Knob.VERTICAL);

    // knob.setLabelVisible(false);
    //knob.setVisible(false);
    
    waves.add(new Wave(0));
    action();
  }

  void display() {
    stroke(0);
    fill(0, 0, 0);
    pushMatrix();
    translate(tobj.getScreenX(width), tobj.getScreenY(height));
    rotate(tobj.getAngle());
    
     for (int j = waves.size()-1; j >= 0; j--) {
        Wave wave = (Wave) waves.get(j);
        wave.display();
        if (wave.power<=0) {
            waves.remove(j);
        }
    }

    // knob.setVisible(true);
    // knob.setPosition(tobj.getScreenX(width), tobj.getScreenY(height));
    // knob.setValue(tobj.getAngle() / (2.0*PI)*127);
    
    popMatrix();
    fill(255);
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
  }
  
  void action(){
       mainBus.sendNoteOn(0, tobj.getSymbolID(), 100);
  }
  
  //TODO
  void dismiss(){
    mainBus.sendControllerChange(0, tobj.getSymbolID(), 0);
    //knob.remove();
  }
}
