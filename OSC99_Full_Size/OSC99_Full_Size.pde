// -----------------------------------------------------------

// OSC99 - GENERATIVE VISUAL SYNTHESIZER

// -----------------------------------------------------------

import controlP5.*; // control p5 is what is used to make the buttons / sliders
import java.util.*; // for the drop down list feature


ControlP5 cp5; 

Controls ui;

Oscillator osc1;
Oscillator osc2;

PFont font;
PFont titleFont;
boolean backupFont = false;

PImage img;
PImage img2;
float[] yvalues;  // Using an array to store height values for the wave
float[] xvalues;  // Using an array to store height values for the wave
int ARRAY_DIVIDER = 8; //Used with w to decide the number of columns in yvalues, i think it needs to be the same as xspacing
// ARRAY_DIVIDER HAS TO BE WHAT IS THEN MULTIPLIED DURING RENDER, theoritically a bigger number would mean less computation of our arrays (or so i thought)
int w;              // Width of entire wave

JSONObject json; 
String fileNameForScreen = "Not a file";

int uiHeight = 300; //Height of the bottom UI rectangle
int topNavHeight = 70;
int renderAreaWidth = 1280; // Not used yet
int renderAreaHeight = 720; // Not used yet

int fps = 24; // Frame Rate

int controls = 1;
String current_control = "OSC1";
boolean recording = false;

int emptyVar = 0; // this is to use as a place holder in my variable array bc i did it stupid



//  OSC 1 Parameters
boolean osc1Sleep = false; 
boolean oscDir = true;
int osc1_opacity = 255;

float theta = 0.0;  // Start angle at 0
float amplitude = 0.5; // Height of wave, Amplitude
float period = 550.0;  // How many pixels before the wave repeats
float osc_speed = 0.08;
int xspacing = 8;   // effects dx in calc(), I took this away from user parameters but it probably still could be
int xspacingGraph = 8;
int filler_lines = 10;
int band_spacing = 450; // spacing of the color bands, intensity of the gradients, upper bound of the mapped siney values for the intensity
int intensityMapLowerBound = 385; // this and band_spacing may need to be adjusted when resizing

float modulo_amt = .1; // Modulo Effect

int wave_hue = 20; // initial hue of the wave
boolean hueLFOSleep = false; 
float lfo_speed = 0.1;
float lfo_amt = 10; 

boolean sine = true;
int squareWidth = 470;

float dialationScalar = 0;
float freqMod = 1;
float mysteryModulation = 16;
boolean pushPull = true; //The logic on this has to be flipped for it to show up right on the UI
boolean symmetry = true; //Same for this one


//Second Oscillator Variables
boolean osc2Sleep = true; 
boolean oscDir2 = true;
int osc2_opacity = 200;

float theta2 = 0.0;  
float amplitude2 = 345.0;  
float period2 = 280.0;  
float osc_speed2 = 0.2;
int xspacing2 = 8;
int filler_lines2 = 10;
int line_amt2 = 0;
int band_spacing2 = 895;
int intensityMapLowerBound2 = 50; 

float modulo_amt2 = .1;

int wave_hue2 = 90;
float new_hue2 = 20;
boolean hueLFOSleep2 = false; 
float modhue2;
float hue_change2 = 0;
float lfo_amt2 = 0;
float lfo_speed2 = 0.4;
boolean sine2 = true;
int squareWidth2 = 470;


//More Variables
int bgr_hue = 0;
int bgr_sat = 255;
int bgr_val = 255;

int blendType = 8; //blendMode takes ints and 8 is SCREEN, the reason I have two if because one is for blendMode() and the other corresponds to ticks on the slider
int type = 0; //This is also for blend modesfor the blending modes
String blendName = "SCREEN";

boolean invertFilter = false;
boolean graph = false; // Not saved in presets or randomized, or inited
boolean randomModeOn = false;
float randomSpeed = 8;


// Variables that can be modified by the user in the UI
String[] parameter = { "osc1Sleep", "oscDir", "osc1_opacity", "amplitude", "period", "osc_speed", "xspacing", "filler_lines", "band_spacing", "modulo_amt", 
  "wave_hue", "hueLFOSleep", "lfo_amt", "lfo_speed", "sine", "squareWidth", "dialationScalar", "freqMod", "mysteryModulation", "pushPull", "symmetry", "osc2Sleep", 
  "oscDir2", "osc2_opacity", "amplitude2", "period2", "osc_speed2", "xspacing2", "filler_lines2", "band_spacing2", "modulo_amt2", "wave_hue2", "hueLFOSleep2",
  "lfo_amt2", "lfo_speed2", "sine2", "squareWidth2", "blendType", "type", "invertFilter", "bgr_hue", "bgr_sat", "bgr_val" };



void setup() {

  frameRate(fps);

  size(1280, 1090);  // old size (1114, 816)

  colorMode(HSB);

  // Adding a backup font
  try {
    font = createFont("D:/Fonts/TSBlockBold.ttf", 13);
    titleFont = createFont("D:/Fonts/TSBlockBold.ttf", 22);
  } 
  catch (Exception e) {
    font = null;
    titleFont = null;
  }
  if (font == null||titleFont == null) {
    font = createFont("Arial Bold", 15); //"SansSerif" would be another good backup
    titleFont = createFont("Arial Bold", 28);
    backupFont = true;
  } 

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false); // cp5 elements dont get drawn until draw()
  
  ui = new Controls(font, titleFont);
  ui.addButtons(); // this just creates the buttons, it does not display them
  
  osc1 = new Oscillator();
  osc2 = new Oscillator();

  w = width+16; // should this be here?
  
  //should these be in the osc class
  yvalues = new float[w/ARRAY_DIVIDER];
  //for horizontal osc:
  xvalues = new float[renderAreaHeight/ARRAY_DIVIDER];

  osc1.imgCreation(); 
  osc2.imgCreation2(); 
}


void draw() {
  
  background(bgr_hue, bgr_sat, bgr_val);

  ui.toggle();

  blendingMode(); // compute current blending mode
  blendMode(blendType);

  // OSCILLATORS
  if (osc1Sleep == false) {
    osc1.calc(); 
    osc1.render();
  }

  if (osc2Sleep == false) {
    osc2.calcSimple();
    osc2.render2();
  }
  
  //Graph View Mode
  if (graph == true){
    //if osc1 is asleep we still need to calculate the wave
    if(osc1Sleep == true){
      osc1.calc();
    }
    blendMode(BLEND);
    osc1.showGraph();
  }
  
  //Random Walk Mode, changes a parameters every half second
  if(randomModeOn == true){
    osc1.randomChange(); // there should also be a mode where it slides up and down and doesn't jump but this one jumps
  }

  ui.drawUI(); // since autodraw is turned to false it draws the UI here
  
  blendMode(blendType); // does this need to be here?


  //Rendering frames to PNG files
  if (recording == true) {
    saveFrame("output/frames####.png");
  }

}



// -----------------------------------------------------------

// COMPUTING THE BLENDING MODES

// -----------------------------------------------------------
public void blendingMode() {
  
  // this is to get the value from our drop down list (0-4) and convert it to processing's corresponding blending modes (which are int values)
  
  type = int( cp5.getController("dropdown").getValue());

  //Blend Types Conditionals
  if (type==0) {
    blendType = 8; //Screen
  }  else if (type==1) {
    blendType = 1; //Add
  } else if (type==2) {
    blendType = 2; // Subtract
  } else if (type==3) {
    blendType = 4; // Lightest
  } else if (type==4) {
    blendType = 0; // Normal
  }
  //There are other blend modes in processing but I never got them to work
  else {
    blendType = 8;
  }
}


// -----------------------------------------------------------

// RANDOMIZE PARAMETERS

// -----------------------------------------------------------

public void randomize() {

  osc1.randomizeOsc(); //this also randomizes osc2 until i figure that situation out

  // Some Global Settings
  bgr_hue = int(random(0, 255));
  bgr_sat = (random(100) > 20) ? 255 : int(random(0, 255));
  bgr_val = int(random(0, 255));

  invertFilter = (random(100) > 95) ? true : false;
  type = (random(100) > 70) ? 0 : int(random(0, 4));

  //This is important bc it needs to stay on the Main Menu Screen
  controls = 3;
  current_control = "Main";
  recording = false;
  blendName = "SCREEN";
  
  ui.defaultTitle();
  cp5.getController("dropdown").setValue(type);
  ui.updateValues();
 
  ui.drawUI();
}


// -----------------------------------------------------------

// CP5 Controller Inititated Functions

// -----------------------------------------------------------

// I can't get CP5 to recognize functions or variables unless their in this main body

void tooltipMode() {
    ui.messageContent("tooltip");
    ui.toolTipOn = !ui.toolTipOn; 
    
  }
  
void randomMode() {
    println("button worked");
    ui.messageContent("random");
    randomModeOn = !randomModeOn; 
    
  }
  
void graphMode() {
    ui.messageContent("graph");
    graph = !graph; 
    
  }


// -----------------------------------------------------------

// RESTORE TO DEFAULT

// -----------------------------------------------------------
public void init() {

  osc1.initOsc(); // add osc2.initOsc once the variables are the same

  // Some global settings
  bgr_hue = 0;
  bgr_sat = 255;
  bgr_val = 255;

  type = 0;
  blendType = 8;
  invertFilter = false; 
  
  graph = false;
  invertFilter = false;
  randomModeOn = false;

  controls = 3;
  recording = false;
  blendName = "SCREEN";
  
  ui.defaultTitle();
  cp5.getController("dropdown").setValue(type);
  ui.updateValues();
  
  //Rerunning Setup()
  setup();
}

//Have to have this becuase when loading a preset I run init and dont want some stuff to happen
//There is no defaultTitle(), updateValues and setup() in this one
public void initBeforeLoad() {
  
  osc1.initOsc(); // add osc2.initOsc once the variables are the same

  // Some global settings
  bgr_hue = 0;
  bgr_sat = 255;
  bgr_val = 255;

  type = 0;
  blendType = 8;
  invertFilter = false; 
  
  graph = false;
  invertFilter = false;
  randomModeOn = false;

  controls = 3;
  recording = false;
  blendName = "SCREEN";
  
  setup(); // For some reason I still need this to make loading presets work
}


// -----------------------------------------------------------

// MOUSE PRESSED EVENTS

// -----------------------------------------------------------
void mousePressed() {
  
   println(mouseX + "  :  " + mouseY);

  // Clicking the circle to render
  if (dist(mouseX, mouseY, 1241, 30)<12 ) {
    recording = !recording;
  }

  // Clicking the title for loading presets
  if (mouseX>(width/2)-180&&mouseX<(width/2)+180) {
    println("x target");
    if (mouseY>5&&mouseY<60) {
      println("gotem");
      loadPatch();
    }
  }
  
  //closing the open dropdown when user clicks outside of it - NOT WORKING
 //if (cp5.getController("dropdown").isMouseOver() == true){
 //   if (mouseY>ui.row1-ui.sliderH&&mouseY<(ui.row1-ui.sliderH) + 200) {
 //     println("gotem");
 //     menuDown=!menuDown;
 //     ui.dropdown();
 //       }
 //    }
 // if (cp5.getController("dropdown").isMouseOver() == false && menuDown==true){
 //   if (mouseY>ui.row1-ui.sliderH&&mouseY<(ui.row1-ui.sliderH) + 200) {
 //     println("outside of dropdown");
 //     menuDown=false;
 //    }
 // }

}
