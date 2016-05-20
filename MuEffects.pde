class MuGroupVolumeKnob extends MuGroupKnob{
  MuGroupVolumeKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.volumeCtrl, value);
  }
}

class MuGroupReverbKnob extends MuGroupKnob{
  MuGroupReverbKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.reverbCtrl, value);
  }
  
  void knobRemove(Effected effected){
    mainBus.sendControllerChange(2, effected.reverbCtrl, 0); 
  }
}

class MuGroupGateKnob extends MuGroupKnob{
  MuGroupGateKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(Effected effected){
    mainBus.sendControllerChange(2, effected.gateCtrl, value);
  }
  
  void knobRemove(Effected effected){
    mainBus.sendControllerChange(2, effected.gateCtrl, 0); 
  }
}
