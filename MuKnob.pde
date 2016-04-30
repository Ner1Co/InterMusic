class MuKnob implements MuObject {
  TuioObject tobj; 
  Knob knob;
  int knobRadius;
  int value;

  MuKnob(TuioObject tobj) {
    this.tobj = tobj;
    this.knobRadius = 130;
    init();
  }
  
  MuObjectType getType(){
    return MuObjectType.KNOB;
  }

  void beat() {
  }

  void init() {
    knob = cp5.addKnob(str(tobj.getSymbolID()))
      .setRange(0, 127)
        .setValue(value)
          .setPosition(0, 0)
            .setRadius(knobRadius)
              .setStringValue("")
                .setColorBackground(color(255, 255, 255))
                  .setViewStyle(Knob.ARC)
                    .setDragDirection(Knob.VERTICAL);

    knob.setLabelVisible(false);
    knob.setVisible(true);

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
    mainBus.sendControllerChange(2, tobj.getSymbolID(), value); // Send a controllerChange
  }

  //TODO
  void dismiss() {
    mainBus.sendControllerChange(2, tobj.getSymbolID(), 0);
    knob.remove();
  }
}
