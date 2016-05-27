class MuKnob extends MuObject {
  Knob knob;
  int knobRadius;
  int value;

  MuKnob(TuioObject tobj) {
    super(tobj);
    this.knobRadius = 130;
    init();
  }
  
  MuObjectType getType(){
    return MuObjectType.KNOB;
  }

  void init() {

    knob = (CustomKnob)cp5.get(str(tobj.getSymbolID()));
    if(knob == null){
      println("new one");
     knob = new CustomKnob(cp5, str(tobj.getSymbolID()))
    .setPosition(0, 0)
    .setColorBackground(color(255, 255, 255, 1))
    .setRadius(knobRadius)
    .setRange(0, 127)
    .setValue(value)
    .setStringValue("")
    .setLabelVisible(false);
    } else{
      knob.setVisible(true);
    }
    
    action();
  }

  void display() {    
    //knob.setVisible(true);
   knob.setPosition(tobj.getScreenX(width) - knobRadius, tobj.getScreenY(height) - knobRadius);
   knob.setValue(value);
  }

  void action() {
    
  }

  void update() {
    value = (int)(tobj.getAngle() / (2.0*PI)*127);
    mainBus.sendControllerChange(3, tobj.getSymbolID(), value); // Send a controllerChange
  }

  //TODO
  void dismiss() {
    mainBus.sendControllerChange(3, tobj.getSymbolID(), 0);
    knob.setVisible(false);
    //knob.remove();
  }
}
