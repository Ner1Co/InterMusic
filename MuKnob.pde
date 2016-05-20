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
    // knob = cp5.addKnob(str(tobj.getSessionID()))
    //   .setRange(0, 127)
    //     .setValue(value)
    //       .setPosition(0, 0)
    //         .setRadius(knobRadius)
    //           .setStringValue("")
    //             .setColorBackground(color(255, 255, 255, 1))
    //               .setViewStyle(Knob.ARC)
    //                 .setDragDirection(Knob.VERTICAL);

    // knob.setLabelVisible(false);
    // knob.setVisible(true);

    knob = new CustomKnob(cp5, str(tobj.getSessionID()))
    .setPosition(0, 0)
    .setColorBackground(color(255, 255, 255, 1))
    .setRadius(knobRadius)
    .setRange(0, 127)
    .setValue(value)
    .setStringValue("")
    .setLabelVisible(false);;

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
    knob.remove();
  }
}
