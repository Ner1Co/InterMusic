class MuBPM extends MuKnob {
  int radius;
  int alpha;
  
   //note: need to assign the knob to the bpm controller in the DAW
  MuBPM(TuioObject tobj) {
    super(tobj);
    
    this.alpha = 255;
    this.radius = 200;
  }

  MuObjectType getType() {
    return MuObjectType.BPM;
  }
  
  void update(){
    super.update();
    panel.bpm.setValue(value);
  }

  void display() {
    super.display();

    if(alpha < beatValue+193)
      alpha+=10;
    else alpha-=10;
    fill(50, 100, 50, alpha);
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
  }

  //TODO
  void dismiss() {
    knob.setVisible(false);
  }
}