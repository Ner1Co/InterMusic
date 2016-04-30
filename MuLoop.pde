class MuLoop implements MuObject {
  TuioObject tobj; 
  Knob knob;
  int volumeCtrl;

  MuLoop(TuioObject tobj) {
    this.tobj = tobj;
    init();
  }

  void beat() {
  }

  void update() {
  }

  void init() {
    action();
  }

  void display() {
    stroke(0);
    //fill(0, 0, 0);
    noFill();
    strokeWeight(1);
    pushMatrix();
    translate(tobj.getScreenX(width), tobj.getScreenY(height));
    rotate(tobj.getAngle());

    rect(-obj_size/2, -obj_size/2, obj_size, obj_size);

    popMatrix();
    fill(0);
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
  }

  void action() {
    perfBus.sendNoteOn(0, tobj.getSymbolID(), 100);
  }

  //TODO
  void dismiss() {
    perfBus.sendNoteOn(0, tobj.getSymbolID(), 0);
    //knob.remove();
  }
}
