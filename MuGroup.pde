class MuGroup implements MuObject {
  int xpos, ypos;
  ArrayList<MuObject> muList = new ArrayList<MuObject>();
  
  void init(){
    
  };
  
  void display(){
    
  };
  
  void dismiss(){};
  void beat(){};
  void action(){};
  
  void update(){
  
  };
  
  void add(MuObject muobj){
    muList.add(muobj);
  }
  
  void remove(MuObject muobj){
    muList.remove(muobj);
  }
}
