class MuPlay implements MuObject {
  TuioObject tobj; 

  MuPlay(TuioObject tobj) {
    this.tobj = tobj;

    init();
  }

  void init() {
    action();
  }

  void action() {
    mainBus.sendMessage(251);
  }
  
  MuObjectType getType(){
    return MuObjectType.PLAY;
  }
  
  void beat() {
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
    mainBus.sendMessage(252);
  }
}
