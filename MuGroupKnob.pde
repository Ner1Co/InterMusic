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
    //stroke(0);
    //noFill();
    fill(255, 230, 230, 100);
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
  }

  void update() {
    value = (int)(tobj.getAngle() / (2.0*PI)*127);

    Iterator it = muObjectMap.keySet().iterator();
    while (it.hasNext ()) {
      MuObject mobj =  muObjectMap.get(it.next());
      if (mobj.getType() == MuObjectType.LOOP || mobj.getType() == MuObjectType.INSTRUMENT) {
        Effected effected = (Effected) mobj;
        if (dist(tobj.getScreenX(width), tobj.getScreenY(height), effected.tobj.getScreenX(width), effected.tobj.getScreenY(height)) < radius/2) {
          knobChange(effected);
        }
      }
    }
  }

  void knobChange(Effected effected) {
  }

  void knobRemove(Effected effected) {
  }

  void knobRemoveAll() {
    Iterator it = muObjectMap.keySet().iterator();
    while (it.hasNext ()) {
      MuObject mobj =  muObjectMap.get(it.next());
      if (mobj.getType() == MuObjectType.LOOP) {
        Effected effected = (Effected) mobj;
        if (dist(tobj.getScreenX(width), tobj.getScreenY(height), effected.tobj.getScreenX(width), effected.tobj.getScreenY(height)) < radius/2) {
          knobRemove(effected);
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
