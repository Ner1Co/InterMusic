class Panel {
  Slider2D slider;
  Slider bpm;
  
  Panel(){
    
    init();
  }

  void init() {
    slider = cp5.addSlider2D("wave")
      .setPosition(0 + 20, 0 + 280)
        .setSize(300, 100)
        .setColorBackground(color(230,230,255,100))
        .setArrayValue(new float[] {50, 50})
      //.disableCrosshair()
      ;
      
              
     bpm = cp5.addSlider("slider")
       .setPosition(0 + 20, 0 + 250)
       .setSize(300,20)
       .setRange(0,127)
       .setValue(50);

    smooth();
  }

//  float cnt;
  // void draw() {
  //   background(0);
  //   pushMatrix();
  //   translate(160, 140);
  //   noStroke();
  //   fill(50);
  //   rect(0, -100, 400, 200);
  //   strokeWeight(1);
  //   line(0, 0, 200, 0);
  //   stroke(255);

  //   for (int i=1; i<400; i++) {
  //     float y0 = cos(map(i-1, 0, s.arrayValue()[0], -PI, PI)) * s.arrayValue()[1]; 
  //     float y1 = cos(map(i, 0, s.arrayValue()[0], -PI, PI)) * s.arrayValue()[1];
  //     line((i-1), y0, i, y1);
  //   }

  //   popMatrix();
  // }
}