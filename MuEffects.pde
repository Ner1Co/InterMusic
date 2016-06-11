class MuGroupEqualizerKnob extends MuGroupKnob{
  MuGroupEqualizerKnob(TuioObject tobj){ super(tobj); }
  
  void display() {
    knob.setPosition(tobj.getScreenX(width) - knobRadius, tobj.getScreenY(height) - knobRadius);
    knob.setValue(value);
    fill(218, 112, 214, 60);
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
  }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.equalizerCtrl, value);
  }
}

class MuGroupVolumeKnob extends MuGroupKnob{
  MuGroupVolumeKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.volumeCtrl, value);
  }
}

class MuGroupDelayKnob extends MuGroupKnob{
  void display() {
    knob.setPosition(tobj.getScreenX(width) - knobRadius, tobj.getScreenY(height) - knobRadius);
    knob.setValue(value);
    fill(0, 255, 255, 60);
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
  }
  
  MuGroupDelayKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.delayCtrl, value);
  }
}

class MuGroupReverbKnob extends MuGroupKnob{
  MuGroupReverbKnob(TuioObject tobj){ super(tobj); }
  
  void display() {
    knob.setPosition(tobj.getScreenX(width) - knobRadius, tobj.getScreenY(height) - knobRadius);
    knob.setValue(value);
    fill(230, 255, 230, 100);
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
  }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.reverbCtrl, value);
  }
  
  void knobRemove(Effected effected){
    mainBus.sendControllerChange(2, effected.reverbCtrl, 0); 
  }
}

class MuGroupGateKnob extends MuGroupKnob{
  MuGroupGateKnob(TuioObject tobj){ super(tobj); }
  
  
  void display() {
    knob.setPosition(tobj.getScreenX(width) - knobRadius, tobj.getScreenY(height) - knobRadius);
    knob.setValue(value);
    fill(230, 230, 255, 100);
    ellipse(tobj.getScreenX(width), tobj.getScreenY(height), radius, radius);
    
    int gateNum = round(knob.getValue() / (127.0/35.0));
     if(gateNum >= 0 && gateNum <= 35)
        image(gates[gateNum], tobj.getScreenX(width) -  radius/4, tobj.getScreenY(height) + radius/4, radius/2, radius/8);
  }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.gateCtrl, value);
  }
  
  void knobRemove(Effected effected){
    mainBus.sendControllerChange(2, effected.gateCtrl, 0); 
  }
}
