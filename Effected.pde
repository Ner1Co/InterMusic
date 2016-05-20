abstract class Effected extends MuObject {
  int volumeCtrl, reverbCtrl, gateCtrl;
  //Loops - channel 3, 0-9 volumes, 10-19 reverb, 20-29 gate
  //Insturments channel 3, 100-109 volumes, 110-119 reverb, 120-129 gate
  abstract void setChannels();
  
  Effected(TuioObject tobj){
      super(tobj);
  }

}
