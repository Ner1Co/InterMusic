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

  void setChannels() {
    this.volumeCtrl = tobj.getSymbolID();
    this.reverbCtrl = tobj.getSymbolID() + 10;
    this.gateCtrl = tobj.getSymbolID() + 20;
    this.equalizerCtrl = tobj.getSymbolID() - 30;
    this.delayCtrl = tobj.getSymbolID() - 20;
  }


  void update() {
    mainBus.sendNoteOff(channel, MuMusic.currentScale[(int)value], 20);
    value = 10 + (int)(tobj.getAngle() / (2.0*PI)*30);
    mainBus.sendNoteOn(channel, MuMusic.currentScale[(int)value], 100);
  }

  MuObjectType getType() {
    return MuObjectType.INSTRUMENT;
  }


  void init() {
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
    polygon(0, 0, obj_size/1.6, 6);

    popMatrix();
    fill(0);
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));


  }

  void action() {
    value = 10 + (int)(tobj.getAngle() / (2.0*PI)*30);
    mainBus.sendNoteOn(channel, MuMusic.currentScale[(int)value], 100);
  }

  //TODO
  void dismiss() {
    mainBus.sendNoteOff(channel, MuMusic.currentScale[(int)value], 0);
  }
}
