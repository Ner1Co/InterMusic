class MuGroupKnob extends MuKnob {
  int radius;

  MuGroupKnob(TuioObject tobj) {
    super(tobj);
    this.radius = 400;
  }

  MuObjectType getType() {
    return MuObjectType.GROUP_KNOB;
  }


  void display() {
    super.display();
    stroke(0);
    noFill();
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
  }

  void update() {
    value = (int)(tobj.getAngle() / (2.0*PI)*127);

    for (Map.Entry i : muObjectMap.entrySet ()) {
      MuObject mobj = (MuObject) i.getValue();
      if (mobj.getType() == MuObjectType.LOOP) {
        MuLoop mloop = (MuLoop) mobj;
        if (dist(tobj.getScreenX(width), tobj.getScreenY(height), mloop.tobj.getScreenX(width), mloop.tobj.getScreenY(height)) < radius/2) {
          knobChange(mloop);
        }
      }
    }
  }

  void knobChange(MuLoop mloop) {
  }

  void knobRemove(MuLoop mloop) {
  }

  void knobRemoveAll() {
    for (Map.Entry i : muObjectMap.entrySet ()) {
      MuObject mobj = (MuObject) i.getValue();
      if (mobj.getType() == MuObjectType.LOOP) {
        MuLoop mloop = (MuLoop) mobj;
        if (dist(tobj.getScreenX(width), tobj.getScreenY(height), mloop.tobj.getScreenX(width), mloop.tobj.getScreenY(height)) < radius/2) {
          knobRemove(mloop);
        }
      }
    }
  }

  //TODO
  void dismiss() {
    knobRemoveAll();
    knob.remove();
  }
}
