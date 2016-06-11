void createKnobs(){
   int knobRadius = 130;
  for(int i = 85; i <= 89; i++){
    new CustomKnob(cp5, str(i))
    .setPosition(0, 0)
    .setColorBackground(color(255, 255, 255, 1))
    .setRadius(knobRadius)
    .setRange(0, 127)
    .setValue(100)
    .setStringValue("")
    .setVisible(false)
    .setLabelVisible(false);
  }
  
  new CustomKnob(cp5, str(11))
    .setPosition(0, 0)
    .setColorBackground(color(255, 255, 255, 1))
    .setRadius(knobRadius)
    .setRange(0, 127)
    .setValue(100)
    .setStringValue("")
    .setVisible(false)
    .setLabelVisible(false);
}

void createGroupKnobs(){
  int knobRadius = 130;
  for(int i = 90; i <= 94; i++){
    new CustomKnob(cp5, str(i))
    .setPosition(0, 0)
    .setColorBackground(color(255, 255, 255, 1))
    .setRadius(knobRadius)
    .setRange(0, 127)
    .setValue(100)
    .setStringValue("")
    .setVisible(false)
    .setLabelVisible(false);
  }
}

MuObject createMuObject(TuioObject tobj){
  int id = tobj.getSymbolID();
  int cubeId;
  
  //loops
  //cube 0 (no icons): 0-5 
  //cube 1: 16-20 
  //cube 2: 32-36
  //cube 3: 48-52
  //cube 4: 64-68
  //cube 5: 80-84
  //cube 6 (empty):  
  //cube 7 (big):
  
  //effects + knobs
    //generic knobs: 85-89
  //bpm - 11
  //start - 10
  //record - 12
  //reverb 90
  //volume 91-92
  //gate 93
  //time 94
  //equliazer 95
  //generic effect knobs: find some
  
  //instrments
  //100 - 107
  if(id >= 85 && id <= 89){
    return new MuKnob(tobj);
  }
  else if(id == 90){
    return new MuGroupReverbKnob(tobj);
  }

  else if(id == 91){
    return new MuGroupVolumeKnob(tobj);
  }
  else if(id == 92){
    return new MuGroupVolumeKnob(tobj);
  }
  else if(id == 93){
    return new MuGroupGateKnob(tobj);
  }
  else if(id == 95){
    return new MuGroupEqualizerKnob(tobj);
  }
  else if(id == 10){
    return new MuPlay(tobj);
  }
    else if(id == 9){
    return new MuBPM(tobj);
  } 
    else if(id == 12){
    return new MuRecord(tobj);
  } 
  else if(id >= 100 && id <= 107){
    return new Instrument(tobj, id - 100);
  }
  else if(id >= 0 && id <= 84){
    cubeId = id / 16;
    return new MuLoop(tobj, cubeId);
  } else {
    return new MuKnob(tobj);
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