MuObject createMuObject(TuioObject tobj){
  int id = tobj.getSymbolID();
  int cubeId;
  
  if(id == 103){
    return new MuGroupReverbKnob(tobj);
  }
  else if(id == 102){
    return new MuGroupVolumeKnob(tobj);
  }
  else if(id == 100){
    return new MuGroupVolumeKnob(tobj);
  }
  else if(id == 132){
    return new MuPlay(tobj);
  }
  else if(id == 133){
    return new Instrument(tobj, 0);
  }
  else if(id == 134){
    return new Instrument(tobj, 1);
  }
  else if(id == 135){
    return new Instrument(tobj, 2);
  }
  else if(id == 200){
    return new MuRecord(tobj);
  } 
  else if(id == 201){
    return new MuBPM(tobj);
  } 
  else if(id >= 100){
    return new MuKnob(tobj);
  }
  else {
    cubeId = id / 16;
    return new MuLoop(tobj, cubeId);
  }
}

enum MuObjectType {
  LOOP,
  KNOB,
  GROUP_KNOB,
  INSTRUMENT,
  PLAY,
  RECORD,
  BPM
};
