abstract class MuObject {
  TuioObject tobj;
  
  MuObject(TuioObject tobj){
    this.tobj = tobj;
  }
  void init(){};
  void display(){};
  void dismiss(){};
  void action(){};
  void update(){};
  abstract MuObjectType getType();
}
