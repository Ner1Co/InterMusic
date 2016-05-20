class MuRecord extends MuObject {

  MuRecord(TuioObject tobj) {
    super(tobj);

    init();
  }

  void init() {
    action();
  }

  void action() {
    mainBus.sendMessage(176, 0, 114, 127); //back to start
    mainBus.sendMessage(176, 0, 114, 0);
    mainBus.sendMessage(176, 0, 117, 127);
    mainBus.sendMessage(176, 0, 117, 0);
  }

  MuObjectType getType() {
    return MuObjectType.RECORD;
  }

  void update() {
  }

  void display() {
    stroke(0);
    fill(220, 220, 255);
    //noFill();
    strokeWeight(1);
    pushMatrix();
    translate(tobj.getScreenX(width), tobj.getScreenY(height));
    rotate(tobj.getAngle());

    rect(-obj_size/2, -obj_size/2, obj_size, obj_size);

    popMatrix();
    fill(0);
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
  }

  //TODO
  void dismiss() {
    mainBus.sendMessage(176, 0, 117, 127);
    mainBus.sendMessage(176, 0, 117, 0);
    mainBus.sendMessage(176, 0, 114, 127); //back to start
    mainBus.sendMessage(176, 0, 114, 0);
  }
}
