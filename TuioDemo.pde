 //<>// //<>//
import java.util.concurrent.ConcurrentHashMap;
import java.util.Iterator;
import themidibus.*; //Import the library //<>//
//import java.util.Map;
import controlP5.*;

ControlP5 cp5;
Panel panel;

MidiBus mainBus, perfBus;

ConcurrentHashMap<Integer, MuObject> muObjectMap = new ConcurrentHashMap<Integer, MuObject>();

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  // println();
  // println("Note On:");
  // println("--------");
  // println("Channel:"+channel);
  // println("Pitch:"+pitch);
  // println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  // println();
  // println("Note Off:");
  // println("--------");
  // println("Channel:"+channel);
  // println("Pitch:"+pitch);
  // println("Velocity:"+velocity);
}

boolean calibrationMode = false;
int beatValue = 0;

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  beatValue = value;
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

// import the TUIO library
import TUIO.*;
// declare a TuioProcessing client
TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

float obj_size = object_size*scale_factor; 
float cur_size = cursor_size*scale_factor; 

PImage calibrationBg;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks

void setup()
{
  calibrationBg = loadImage("calibration.png");
  calibrationBg.resize(displayWidth, displayHeight);

  // GUI setup
  //noCursor();
  size(displayWidth, displayHeight, JAVA2D);
  noStroke();
  fill(0);


  //MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  //                   Parent In Out
  //                     |    |  |
  mainBus = new MidiBus(this, -1, "loopMIDI Port", "PSYN"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  perfBus = new MidiBus(this, "loopMIDI Port Out", "loopMIDI Port Performance", "PSYN"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // periodic updates
  //if (!callback) {
  frameRate(60);
  //  loop();
  //} else noLoop(); // or callback updates 

  font = createFont("Arial", 18);
  scale_factor = height/table_size;

  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);

  cp5 = new ControlP5(this);
  panel = new Panel();
  
  MuMusic.initMajor();
 // MuMusic.initPentatonic();
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
//Iterator<Map.Entry<Integer,MuObject>> it;
Iterator it;
void draw()
{
  if (calibrationMode == true)
    background(calibrationBg);
  else background(255);

  textFont(font, 18*scale_factor);

  try {
    it = muObjectMap.keySet().iterator();
    while (it.hasNext ()) {
      muObjectMap.get(it.next()).display();
    }
  } 
  catch (Exception e) {
    print("Exception!!");
  } 


  ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
  for (int i=0; i<tuioCursorList.size (); i++) {
    TuioCursor tcur = tuioCursorList.get(i);
    int pit = tcur.getScreenX(width)/7;
    //mainBus.sendNoteOn(channel, pit, velocity); // Send a Midi noteOn
    ArrayList<TuioPoint> pointList = tcur.getPath();

    if (pointList.size()>0) {
      stroke(0, 0, 255);
      TuioPoint start_point = pointList.get(0);
      for (int j=0; j<pointList.size (); j++) {
        TuioPoint end_point = pointList.get(j);
        line(start_point.getScreenX(width), start_point.getScreenY(height), end_point.getScreenX(width), end_point.getScreenY(height));
        start_point = end_point;
      }

      stroke(192, 192, 192);
      fill(192, 192, 192);
      ellipse( tcur.getScreenX(width), tcur.getScreenY(height), cur_size, cur_size);
      fill(0);
      text(""+ tcur.getCursorID(), tcur.getScreenX(width)-5, tcur.getScreenY(height)+5);
    }
  }

  ArrayList<TuioBlob> tuioBlobList = tuioClient.getTuioBlobList();
  for (int i=0; i<tuioBlobList.size (); i++) {
    TuioBlob tblb = tuioBlobList.get(i);
    stroke(0);
    fill(0);
    pushMatrix();
    translate(tblb.getScreenX(width), tblb.getScreenY(height));
    rotate(tblb.getAngle());
    ellipse(-1*tblb.getScreenWidth(width)/2, -1*tblb.getScreenHeight(height)/2, tblb.getScreenWidth(width), tblb.getScreenWidth(width));
    popMatrix();
    fill(255);
    text(""+tblb.getBlobID(), tblb.getScreenX(width), tblb.getScreenX(width));
  }
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());

  if (muObjectMap.containsKey(tobj.getSymbolID()) == false)
    muObjectMap.put(tobj.getSymbolID(), createMuObject(tobj));
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
  try {
    muObjectMap.get(tobj.getSymbolID()).update();
  }
  catch (Exception e) {
    print("Exception!!");
  }
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");

  muObjectMap.get(tobj.getSymbolID()).dismiss();
  muObjectMap.remove(tobj.getSymbolID());
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
  
  playNote(tcur);
}

int[] notesOn = new int[10];
// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
  
  playNote(tcur);
}

void playNote(TuioCursor tcur) {
  if (tcur.getScreenX(width) >= panel.slider.getPosition().x &&  tcur.getScreenX(width) <= panel.slider.getPosition().x + panel.slider.getWidth() && 
    tcur.getScreenY(height) >= panel.slider.getPosition().y &&  tcur.getScreenY(height) <= panel.slider.getPosition().y + panel.slider.getHeight()) {
    float pit = -(panel.slider.getPosition().x - tcur.getScreenX(width)) / 2; 
    float velocity = (panel.slider.getPosition().y - tcur.getScreenY(height) + 100);
    
    
    float[] pos = {
      pit, 100- velocity
    };
    
    panel.slider.setArrayValue(pos);
    
    if((int)pit >= 0 && (int)pit < MuMusic.currentScale.length)
      pit = MuMusic.currentScale[(int)pit];

    //mainBus.sendNoteOff(0, notesOn[tcur.getCursorID()], 100);
    int lastNote = notesOn[tcur.getCursorID()];
    notesOn[tcur.getCursorID()] = (int)pit;
    mainBus.sendNoteOn(0, (int)pit, (int)velocity);
    
    mainBus.sendNoteOff(0, lastNote, 100);
  } else {
    mainBus.sendNoteOff(0, notesOn[tcur.getCursorID()], 10);
  }
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");

  //int pit = tcur.getScreenX(width)/7;
  mainBus.sendNoteOff(0, notesOn[tcur.getCursorID()], 10);
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}

void keyPressed() {
  if (key  == 'c') {
    calibrationMode = !calibrationMode;
  }
  if (key  == 'p') {
    //int status_byte = 0xC0;
    int status_byte = 192;
    // This is the status byte for a program change
    int channel = 0;
    // We'll use channel 0
    int byte1 = 2;
    // This will be the preset you are sending with your program change
    int byte2 = 0;
    // This is not used for program change so ignore it and set it to 0

      mainBus.sendMessage(status_byte, channel, byte1, byte2); 
    //Send the custom message

    //mainBus.sendMessage(new byte[]{(byte)240,(byte)127,(byte)127,(byte)1,(byte)1,(byte)0,(byte)0,(byte)4,(byte)0,(byte)247});
  }

  if (key == 'r') {
    mainBus.sendMessage(176, 0, 117, 127);
    mainBus.sendMessage(176, 0, 117, 0);
  }
}
