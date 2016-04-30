MuObject createMuObject(TuioObject tobj){
  if(tobj.getSymbolID() >= 100){
    return new MuKnob(tobj);
  } else {
    return new MuLoop(tobj);
  }
  
}
