class MuKnob implements MuObject {
  TuioObject tobj; 
  Knob knob;

  MuKnob(TuioObject tobj) {
    this.tobj = tobj;
    init();
  }

  void beat() {
  }

  void init() {
    knob = cp5.addKnob(str(tobj.getSymbolID()))
      .setRange(0, 127)
        .setValue(50)
          .setPosition(100, 70)
            .setRadius(130)
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
    knob.setPosition(tobj.getScreenX(width), tobj.getScreenY(height));
    knob.setValue(tobj.getAngle() / (2.0*PI)*127);
  }

  void action() {
    
  }

  void update() {
    int value = (int)(tobj.getAngle() / (2.0*PI)*127);
    mainBus.sendControllerChange(2, tobj.getSymbolID(), value); // Send a controllerChange
  }

  //TODO
  void dismiss() {
    mainBus.sendControllerChange(2, tobj.getSymbolID(), 0);
    knob.remove();
  }
}
