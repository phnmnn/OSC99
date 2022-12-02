// -----------------------------------------------------------

// OSC99 GENERATIVE VISUAL SYNTHESIZER

// -----------------------------------------------------------

import controlP5.*; // control p5 is what is used to make the buttons / sliders


ControlP5 cp5; 

Controls ui;

Oscillator osc1;
Oscillator osc2;

PFont font;
PFont titleFont;

PImage img;
PImage img2;

JSONObject json; 
String fileNameForScreen = "Not a file";

int uiHeight = 270; //Height of the bottom UI rectangle
int renderAreaWidth = 0;
int renderAreaHeight = 0; 

int emptyVar = 0; // this is to use as a place holder in my variable array bc i did it stupid



//  OSC 1 Parameters
boolean osc1Sleep = false; //The logic on this has to be flipped for it to show up right on the UI, I dont understand why
float[] yvalues;  // Using an array to store height values for the wave
float theta = 0.0;  // Start angle at 0
float amplitude = 185.0;  // Height of wave
float ampAndrei = 0.5;
float period = 550.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float osc_speed = 0.08;
int xspacing = 8;   // How far apart should each horizontal location be spaced
int filler_lines = 10;
float modAmt = .1;
boolean modDir = true;
int line_amt = 0;
int wave_hue = 20; // the way i did the hue lfo is confusing and probably needs changing
float new_hue = 20;
int bgr_hue = 0;
float modhue;
float hue_change = 0;
float wavehueLFO = 60;
boolean dir = true;
float lfo_speed = 0.2;
boolean sine = true;
boolean square = false;
int squareWidth = 470;
boolean oscDir = true;
int band_spacing = 477;
float dialationScalar = 0;
float freqMod = 1;
float mysteryModulation = 16;
boolean pushPull = true; //The logic on this has to be flipped for it to show up right on the UI, I dont understand why
boolean symmetry = true; //Same for this one




//Second Oscillator Variables
boolean osc2Sleep = true; //The logic on this has to be flipped for it to show up right on the UI, I dont understand why
float[] yvalues2;  // Using an array to store height values for the wave
float theta2 = 0.0;  // Start angle at 0
float amplitude2 = 85.0;  // Height of wave
float period2 = 250.0;  // How many pixels before the wave repeats
float dx2;  // Value for incrementing X, a function of period and xspacing
float osc_speed2 = 0.2;
int filler_lines2 = 10;
float modAmt2 = .1;
boolean modDir2 = true;
int line_amt2 = 0;
int wave_hue2 = 90;
float new_hue2 = 20;
//int bgr_hue2 = 0;
float modhue2;
float hue_change2 = 0;
float wavehueLFO2 = 0;
boolean dir2 = true;
float lfo_speed2 = 0.4;
boolean sine2 = true;
int squareWidth2 = 470;
int osc2_opacity = 200;
int band_spacing2 = 490;
boolean oscDir2 = true;





//More Variables

int controls = 1;
String current_control = "OSC1";

int blendType = 8; //blendMode takes ints and 8 is SCREEN, the reason I have two if because one is for blendMode() and the other corresponds to ticks on the slider
int type = 1; //This also if for the blending modes

int fps = 24;

boolean graph = false; // I think this was my idea to render it like the processing example (a sine wave with dots)

int w;              // Width of entire wave

int bgr_val = 255;

boolean recording = false;

String blendName = "SCREEN";

float noiseInput = 0; //Dont think this is being used

//int bgr_val2 = 255;


void setup() {

  frameRate(fps);

  size(1114, 816); //  i might want to adjust this to make the view area more standard size

  colorMode(HSB);

  font = createFont("D:/Fonts/TSBlockBold.ttf", 13);

  titleFont = createFont("D:/Fonts/TSBlockBold.ttf", 22);

  cp5 = new ControlP5(this);

  cp5.setAutoDraw(false); // Not sure if i need this except for text on fourth column of main menu

  ui = new Controls(font, titleFont);
  ui.addButtons();
  //addSliders(font);

  osc1 = new Oscillator();
  osc2 = new Oscillator();
  //osc1.test();

  w = width+16; // should this be here?

  osc1.imgCreation(); 
  osc2.imgCreation2(); 

  //img2 = createImage(width, 490, RGB);

  //should these arrays be in the oscillator class?
  yvalues = new float[w/xspacing];

  yvalues2 = new float[w/xspacing];
}

void draw() {

  background(bgr_hue, 255, bgr_val);

  ui.toggle();

  blendingMode();
  blendMode(blendType);


  // OSCILLATORS
  if (osc1Sleep == false) {
    osc1.calc(period, ampAndrei, dialationScalar, freqMod); 
    osc1.colorLFO(); // there should be an if statement to see if the LFO is on
    osc1.render(new_hue, wave_hue);
  }

  if (osc2Sleep == false) {
    osc2.calc2(period2, amplitude2);
    osc2.colorLFO2(); //needs a conditional check
    osc2.render2(new_hue2);
  }


  ui.drawUI(); // since autodraw is turned to false it draws the UI here

  blendMode(blendType);


  //Recording

  if (recording == true) {
    saveFrame("output/frames####.png");
  }
}




// -----------------------------------------------------------

// COMPUTING THE BLENDING MODES

// -----------------------------------------------------------
public void blendingMode() {
  //Blend Types Conditionals
  if (type==0) {
    blendType = 8; //Screen
  } else if (type==1) {
    blendType = 8; //Screen
  } else if (type==2) {
    blendType = 1; //Add
  } else if (type==3) {
    blendType = 2; // Subtract
  } else if (type==4) {
    blendType = 4; // Lightest
  } else if (type==5) {
    blendType = 0; //
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

  osc1.randomizeOsc(); //this also randomizes osc2 until i fix that

  // Some Global Settings
  bgr_hue = int(random(0, 255));
  bgr_val = int(random(0, 255));

  //im not sure if im actually getting a random blending mode here
  blendType = 8;
  float n = random(100);
  if (n > 50) {
    type = 1;
  } else {
    type = int(random(1, 9));
  }

  //This is important bc it needs to stay on the Main Menu Screen
  controls = 3;
  current_control = "Main";
  recording = false;
  blendName = "SCREEN";
}



// -----------------------------------------------------------

// RESTORE TO DEFAULT

// -----------------------------------------------------------
public void init() {

  osc1.initOsc(); // add osc2.initOsc once the variables are the same

  // Some global settings
  bgr_val = 255;
  blendType = 8;
  type = 1;
  controls = 1;
  recording = false;
  blendName = "SCREEN";
  //Rerunning Setup()
  setup();
}


// -----------------------------------------------------------

// MOUSE PRESSED EVENTS

// -----------------------------------------------------------
void mousePressed() {

  if (dist(mouseX, mouseY, 1060, 30)<12 ) {
    recording = !recording;
  }


  if (mouseX>(width/2)-140&&mouseX<(width/2)+140) {
    println("x target");
    if (mouseY>5&&mouseY<60) {
      println("gotem");
      loadPatch();
    }
  }

  println(mouseX + "  :  " + mouseY);
}
