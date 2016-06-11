abstract class Effected extends MuObject {
  int volumeCtrl, reverbCtrl, gateCtrl, equalizerCtrl, delayCtrl;
  //Loops - channel 3, 0-9 volumes, 10-19 reverb, 20-29 gate, 30-39 equalizer,  40-49 delay
  //Insturments channel 3, 100-109 volumes, 110-119 reverb, 120-129 gate, 70-79 equalizer, 80-89 delay
  abstract void setChannels();
  
  Effected(TuioObject tobj){
      super(tobj);
  }

}
