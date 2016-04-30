class MuGroupVolumeKnob extends MuGroupKnob{
  MuGroupVolumeKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(MuLoop mloop){
    mainBus.sendControllerChange(2, mloop.volumeCtrl, value);
  }
}

class MuGroupReverbKnob extends MuGroupKnob{
  MuGroupReverbKnob(TuioObject tobj){ super(tobj); }
  
  void knobChange(MuLoop mloop){
    mainBus.sendControllerChange(2, mloop.reverbCtrl, value);
  }
  
  void knobRemove(MuLoop mloop){
    mainBus.sendControllerChange(2, mloop.reverbCtrl, 0); 
  }
}
