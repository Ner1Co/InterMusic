class Wave {
    int xpos,ypos;
    int radius;
    int power;
    int pitch;
    Wave (int p) {
        xpos = 0;
        ypos = 0;
        pitch = p;
        radius = 100;
        power = 100;
    }
    void display() {
       // colorMode(HSB, 127);
        stroke(pitch,127,127,power);
        strokeWeight(1);
        noFill();
        ellipse (xpos,ypos,radius,radius);     
        
        radius++;
        if (radius>230) {
            power--;
        }
    }
}
