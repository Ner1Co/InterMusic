class MuLoop implements MuObject {
  TuioObject tobj; 
  Knob knob;
  int volumeCtrl, reverbCtrl; //channel 3, 0-9 volumes, 10-19 reverb
  int cubeId;

  MuLoop(TuioObject tobj, int cubeId) {
    this.tobj = tobj;
    this.cubeId = cubeId;
    
    this.volumeCtrl = cubeId;
    this.reverbCtrl = cubeId + 10;
    
    init();
  }
  
  MuObjectType getType(){
    return MuObjectType.LOOP;
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
    perfBus.sendNoteOn(0, 16*cubeId+8, 100);
    //knob.remove();
  }
}
