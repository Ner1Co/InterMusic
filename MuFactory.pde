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
  else if(id >= 100){
    return new MuKnob(tobj);
  } else {
    cubeId = id / 16;
    return new MuLoop(tobj, cubeId);
  }
}

enum MuObjectType {
  LOOP,
  KNOB,
  GROUP_KNOB,
  INSTRUMENT
};
