import controlP5.*;

// control p5 is what is used to make the buttons / sliders
ControlP5 cp5;

PFont ts;
PFont title;

PImage img;
PImage img2;

JSONObject json; 
String fileNameForScreen = "Not a file";

int uiHeight = 270;

int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 185.0;  // Height of wave
float ampAndrei = 0.5;
float period = 550.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave
float osc_speed = 0.08;

int filler_lines = 10;
float modAmt = .1;
boolean modDir = true;

int line_amt = 0;

int wave_hue = 20;

float new_hue = 20;
int bgr_hue = 0;
float modhue;
float hue_change = 0;
float wavehueLFO = 60;
boolean dir = true;

int bgr_val = 255;
float lfo_speed = 0.2;

boolean sine = true;
int squareWidth = 470;

//blendMode takes ints and 8 is SCREEN
int blendType = 8;
int type = 1;

boolean osc2Toggle = false;

int controls = 1;
String current_control = "OSC1";

boolean osc1Toggle = true;

int band_spacing = 477;

boolean oscDir = true;

float dialationScalar = 0;

float freqMod = 1;

boolean pushPull = false;

boolean symmetry = false;

boolean graph = false;

float mysteryModulation = 16;


//Second Oscillator Variables
float theta2 = 0.0;  // Start angle at 0
float amplitude2 = 85.0;  // Height of wave
float period2 = 250.0;  // How many pixels before the wave repeats
float dx2;  // Value for incrementing X, a function of period and xspacing
float[] yvalues2;  // Using an array to store height values for the wave
float osc_speed2 = 0.2;

int filler_lines2 = 10;
float modAmt2 = .1;
boolean modDir2 = true;

int line_amt2 = 0;

int wave_hue2 = 90;

float new_hue2 = 20;
int bgr_hue2 = 0;
float modhue2;
float hue_change2 = 0;
float wavehueLFO2 = 0;
boolean dir2 = true;

int bgr_val2 = 255;
float lfo_speed2 = 0.4;

boolean sine2 = true;
int squareWidth2 = 470;

int osc2_opacity = 200;

int band_spacing2 = 490;

boolean oscDir2 = true;

//More Variables

boolean recording = false;

String recordPrompt = "Press to Render";

String blendName = "SCREEN";

float noiseInput = 0;


void setup() {

  frameRate(24);
  
  size(1114, 816);
  
  colorMode(HSB);
  
  cp5 = new ControlP5(this);
  
  cp5.setAutoDraw(false);
  
  ts = createFont("D:/Fonts/TSBlockBold.ttf",13);
  
  title = createFont("D:/Fonts/TSBlockBold.ttf",22);
  
  addSliders(ts);
  
  w = width+16;
  
  img = createImage(width, 576, RGB);
  
  img2 = createImage(width, 576, RGB);

  yvalues = new float[w/xspacing];
  
  yvalues2 = new float[w/xspacing];
  
    
  
  
}

void draw() {
  
  dx = (TWO_PI / period) * xspacing;
  
  if (osc1Toggle == true){
  
    calcAndrei(period, ampAndrei, dialationScalar, freqMod);
  }
  
  if (osc2Toggle == true){
  
    calcWave2(period2, amplitude2);
  }
  
  background(bgr_hue, 255, bgr_val);
  
  
  
  
  //Control Toggle Show/Hide
  if (controls == 1){
    cp5.getGroup("osc1").show();
    cp5.getGroup("osc2").hide();
    cp5.getGroup("main").hide();
    current_control = "OSC1";
  }
  
  if (controls == 2){
    cp5.getGroup("osc2").show();
    cp5.getGroup("osc1").hide();
    cp5.getGroup("main").hide();
    current_control = "OSC2";
  }
  if (controls == 3){
    cp5.getGroup("main").show();
    cp5.getGroup("osc2").hide();
    cp5.getGroup("osc1").hide();
    current_control = "MAIN";
  }
  
  
  //Showing and Hiding "Square Width"
  if(sine==true){
    cp5.getController("squareWidth").hide();
  }
  
  if(sine==false){
    cp5.getController("squareWidth").show();
  }
  
  if(sine2==true){
    cp5.getController("squareWidth2").hide();
  }
  
  if(sine2==false){
    cp5.getController("squareWidth2").show();
  }
  
  
  
  //Blend Types Conditionals
  if(type==0){
    blendType = 8;
  }
  else if(type==1){
    blendType = 8;
  }
  else if(type==2){
    blendType = 1;
  }
  else if(type==3){
    blendType = 2;
  }
  else if(type==4){
    blendType = 4;
  }
 
  else{
    blendType = 8;
  }
  
  blendMode(blendType);
  
  
  
  
  
  
  //Color LFO
      
  hue_change = hue_change + lfo_speed;
       
  if(dir==true){
    new_hue = wave_hue+hue_change;
  }
  else if(dir==false){
    new_hue = wave_hue+wavehueLFO-hue_change;
  }
  
  
  if (new_hue<0){
      new_hue= 255 + new_hue;
    }
            
  if(new_hue>255){
      new_hue = new_hue-255;
    }
    
    
  
  if (hue_change>wavehueLFO){
    dir = !dir;
    hue_change = lfo_speed; 
  }
  
  
  
  
   //Color LFO 2
      
  hue_change2 = hue_change2 + lfo_speed2;
    
  if (new_hue2<0){
      new_hue2= 255 + new_hue2;
    }
            
  if(new_hue2>255){
      new_hue2 = new_hue2-255;
    }
            
  if(dir2==true){
    new_hue2 = wave_hue2+hue_change2;
  }
  else if(dir2==false){
    new_hue2 = wave_hue2+wavehueLFO2-hue_change2;
  }
  
  
  if (hue_change2>wavehueLFO2){
    dir2 = !dir2;
    hue_change2 = lfo_speed2; 
  }
  

  
  
  // Oscillator Effects
  if (osc1Toggle == true){
    
    img.loadPixels();  
    
    renderAndreiWave(new_hue, wave_hue);
    
    
    
    if(symmetry == true){
      pushMatrix();
      image(img, -width/2, 0);
      scale(-1.0, 1.0);
      image(img, -width-width/2, 0);
      popMatrix();
    }
    else{
      // Scaling X Axis to Fix the Left Side
      pushMatrix();
      scale(1.1, 1);
      image(img, -20, 60);
      popMatrix();
    
    }
  
    if(pushPull == true){
      
      pushMatrix();
      scale(-1.0, 1.0);
      image(img, -img.width, 0);
      translate(width/2, 0);
      popMatrix();
    
    }
    
    img.updatePixels();
    
  }

  if (osc2Toggle == true){
    
    img2.loadPixels();  
    
    renderWave2(new_hue2);
    
    img2.updatePixels();
    
      pushMatrix();
      translate(1200, 0);
      rotate(PI/2.0);
      scale(.5, 3);
      tint(255, osc2_opacity);
      image(img2, 0, 0);
      popMatrix();
    
  }
  
  blendMode(BLEND);
  
  
  
  //UI Block rectangles
  fill(bgr_hue, 255, bgr_val);
  //fill(0);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, 60);
  rect(0, height-uiHeight, width, height);
  
 

  blendMode(blendType);
  
  textFont(ts);
  textAlign(CENTER, CENTER);
  fill(255);
  
  text(current_control, 140, 28);
  
  textAlign(LEFT, CENTER);
  text(recordPrompt, 840, 30);
  
  noFill();
  stroke(255);
  strokeWeight(3);
  rect(40, 22, 60, 16);
  
  ellipse(1060, 30, 23, 23);
  
   cp5.draw();
  
  
  if(controls==1){
    //Toggle Boxes
    rect(399, 720, 40, 13);
    rect(957, 584, 40, 13);
    rect(957, 652, 40, 13);
    
    //Slider Boxes
    rect(40, 583, 208, 13);
    rect(40, 651, 208, 13);
    rect(40, 719, 208, 13);
    rect(40, 786, 208, 13);
    
    rect(318, 583, 208, 13);
    rect(318, 651, 208, 13);
    if(sine == false){
      rect(318, 786, 208, 13);
    }
    
    rect(597, 583, 208, 13);
    rect(597, 651, 208, 13);
    rect(597, 719, 208, 13);
    rect(597, 786, 208, 13);
    
    rect(876, 719, 208, 13);
    rect(876, 786, 208, 13);
  }
  
  
  if(controls==2){
    //Toggle Boxes
    rect(399, 720, 40, 13);
    rect(957, 584, 40, 13);
    rect(957, 652, 40, 13);
    
    //Slider Boxes
    rect(40, 583, 208, 13);
    rect(40, 651, 208, 13);
    rect(40, 719, 208, 13);
    rect(40, 786, 208, 13);
    
    rect(318, 583, 208, 13);
    rect(318, 651, 208, 13);
    if(sine == false){
      rect(318, 786, 208, 13);
    }
    
    rect(597, 583, 208, 13);
    rect(597, 651, 208, 13);
    rect(597, 719, 208, 13);
    rect(597, 786, 208, 13);
    
    rect(876, 719, 208, 13);
  }
  
  
  if(controls==3){
    //Slider Boxes
    rect(318, 583, 208, 13);
    rect(318, 651, 208, 13);
    rect(318, 719, 208, 13);
    rect(318, 786, 208, 13);
    
    
    
    if(type==1){
      blendName = "SCREEN";
    }
    else if(type==2){
      blendName = "ADD";
    }
    else if(type==3){
      blendName = "SUBTRACT";
    }
    else if(type==4){
      blendName = "LIGHTEST";
    }
   
    else{
      blendName = "SCREEN";
    }
    
    rect(597, 583-10, 208, 23);
    textAlign(CENTER, CENTER);
    text(blendName, 597 + 208/2, 583);
    
    rect(597, 651, 208, 13);
    
    blendMode(BLEND);
    fill(bgr_hue, 255, bgr_val);
    text("Load Patch", width-132, 582);
    text("Save Patch", width-132, 651);
    text("Randomize", width-132, height-97);
    text("Restore Default", width-132, height-30);
    
    blendMode(blendType);
    
  }
  
 
  
  //Title
  
  textFont(title);
  textAlign(CENTER, CENTER);
  fill(255);
  text("OSCILLATOR 99", width/2, 30);

  
  
  //Recording
  
  if (recording == true){
   recordPrompt = "Press to Stop"; 
   fill(255);
   ellipse(1060, 30, 15, 15);
   
   saveFrame("output/frames####.png");
  }
  
  if (recording == false){
   recordPrompt = "Press to Render"; 
  }
}

void calcAndrei(float p, float a, float scalar, float frequencyModulation) {

  if(oscDir == true){
      theta += osc_speed;
      //dialationScalar = dialationScalar + osc_speed;
      //mysteryModulation = mysteryModulation + osc_speed;
  }
  if(oscDir == false){
    theta -= osc_speed;
    //dialationScalar = dialationScalar - osc_speed;
    //mysteryModulation = mysteryModulation - osc_speed;
  }

  float x = theta;
  float x2 = mysteryModulation;
  
  int hei = 1200;
  float qq = a;
  int w2 = 1200;
  float dialation;
  scalar = scalar * x;
  
  for (int i = 0; i < yvalues.length; i++) {
    
    dialation = ((8+x2/16*i/w2)/w2) + scalar;
    yvalues[i] = (1+hei/8*qq)*(1+.5*frequencyModulation*cos(x*(1+i*cos(dialation/8+x2/16*i/w2)/w2)));
    
    x+=dx;
    //x2+=dx;
    if(scalar>0){
      scalar += dx;
    }
  }
  
  //Adrei Jay's Equation
  //here is the bit that generates the waaaves
  //amp=cs*(1+hei/8*qq)*(1+.5*ee*cos(theta*(1+i*cos(theta/8+theta2/16*i/w)/w)));
  
  //ee Frequency Modulation, makes it wonky, values = -1, 1
  //qq height of wave
  //ww speed of wave
  //jj - crazy diffusion
  //hei = height-margin;
  //wid = width-margin
  //cs = 3; a constant for some reason
  //w = wid/cs
}




void calcWave2(float p2, float a2) {
  // Increment theta (try different values for 'angular velocity' here
  if(oscDir2 == true){
      theta2 += osc_speed2;
  }
  if(oscDir2 == false){
    theta2 -= osc_speed2;
  }

  // For every x value, calculate a y value with sine function
  float x2 = theta2;
  for (int i = 0; i < yvalues2.length; i++) {
    yvalues2[i] = sin(x2)*a2;
    x2+=dx;
  }
}



void renderAndreiWave(float oscHue, float originalHue) {

    
    
    int line_spacing = filler_lines+line_amt;
    
    // Generating the Pixel Offset Noise
    float noiseTest = noise(noiseInput);
    float mappedNoise = map(noiseTest*10, 2, 8, -5, 10);
    int columnNoise = round(mappedNoise);
    noiseInput = noiseInput + .1;
    
    
    float localHue = originalHue;
    
    if(lfo_speed > 0){
      localHue = oscHue;  
    }
    
    
    for(int i = 0; i < yvalues.length; i++){
      
      for(int f = 0; f<line_spacing;f++){
    
          int pix_x = i * xspacing + f;
          
          float siny = height/2+yvalues[i];
          
          
          float intensity = map(siny, 430, band_spacing, 0, 255);
          
          //Modulo Computation
          
          float mod_width = (1*i)%modAmt;
          
          modhue = wave_hue + mod_width;
             
         
          
          //Square Wave Boolean
          if(sine==false){
            
                    if(siny > squareWidth){
                        intensity = 0;
                      }
                      else{
                       intensity = 255; 
                      }
                }
          
          
          
          //Modulo
          if(modAmt > 1){
          for(int y = 0; y < img.height-1; y++){   
              
 
              
              img.pixels[pix_x+y*width] = color(modhue, 255, intensity);
            }
          }
          
          //Non Modulo
          else{
            for(int y = 0; y < img.height-1; y++){         
              
              
              
              img.pixels[pix_x+y*width] = color(localHue, 255, intensity);
            }
          
          }
        }
    }
    
    
    
    if(graph == true){
    
    int verticalOffset = -180;
    
          for (int x2 = 0; x2 < yvalues.length; x2++) {
              ellipse(x2*xspacing, height/2+yvalues[x2] + verticalOffset, 12, 12);
          }
        
    }
    
  
}
void renderWave2(float oscHue2) {
    
    int line_spacing = filler_lines2+line_amt2;
    
    
    for(int i = 0; i < yvalues2.length; i++){
      
      for(int f = 0; f<line_spacing;f++){
    
      
          int pix_x = i * xspacing + f;
          
          float siny = height/2+yvalues2[i];
          
          
          float intensity = map(siny, 100, band_spacing2, 0, 255);
          
          
          
          //Modulo Computation
          
          float mod_width = (1*i)%modAmt2;
          
          modhue2 = wave_hue2 + mod_width;
                 
          
          //Square Wave Boolean
          if(sine2==false){
            
                    if(siny > squareWidth2){
                        intensity = 0;
                      }
                      else{
                       intensity = 255; 
                      }
                }
          
          
          //Modulo
          if(modAmt2 > 1){
          for(int y = 0; y < img2.height-1; y++){   
              
 
              
              img2.pixels[pix_x+y*width] = color(modhue2, 255, intensity);
            }
          }
          
          //Non Modulo
          else{
            for(int y = 0; y < img2.height-1; y++){         
              
              
              
              img2.pixels[pix_x+y*width] = color(oscHue2, 255, intensity);
            }
          
          }
        }
    }
  
  
}



void mousePressed() {
  
  if(dist(mouseX, mouseY, 1060,30)<12 ){
        recording = !recording;
      }
      
   //From the JSON Save Code
   
  /*
      // right screen border?
  if ((mouseX>width-235) && (controls == 3)){
    checkMouseOnMenu();
  }
  */
  
  println(mouseX + "  :  " + mouseY);

}



void keyPressed(){
  
    // If we press r, start or stop recording!
    if (key == 'r' || key == 'R') {
      recording = !recording;
    }
    
    //From the JSON save code
    if (key==ESC) {
    key=0; // kill Escape
  }
}




void addSliders(PFont font){
  
    int buffer = 70;
    int sliderW = round(width/4-buffer);
    int sliderH = 13;
  
    int totalCol = 4;
    int totalRow = 4;
    int spacing = 40;
    int v_spacing = 30;
    
    int col1 = spacing;
    int col2 = width/totalCol+spacing;
    int col3 = width/2+spacing;
    int col4 = width-width/totalCol+spacing;
    
    
    int row1 = height-uiHeight+uiHeight/totalRow-v_spacing;
    int row2 = height-uiHeight/2-v_spacing;
    int row3 = height-uiHeight/totalRow-v_spacing;
    int row4 = height-v_spacing;
    
    
    /*
    println("Slider W: " + sliderW);
    println("c1: " + col1);
    println("c2: " + col2);
    println("c3: " + col3);
    println("c4 : " + col4);
    println("r1: " + row1);
    println("r2: " + row2);
    println("r3: " + row3);
    println("r4: " + row4);
    */
    
    
    // TOGGLE SWITCH
     
    cp5.addSlider("controls")
     .setPosition(40,23)
     .setSize(60,15)
     .setRange(0,3)
     .setMin(1)
     .setFont(font)
     .setNumberOfTickMarks(3)
      .snapToTickMarks(true)
      .showTickMarks(false)
      .setValueLabel("")
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
     ;
  
      
      
      
      
      
    
    // OSCILLATOR 1 GROUP
    
    Group osc1 = cp5.addGroup("osc1");
    

    // C O L U M N    O N E
 
    //Oscillator Speed
    cp5.addSlider("osc_speed")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row1)
      .setSize(sliderW, sliderH)
      .setRange(-.8, 1)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Oscillator Speed")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
    
    //Period
    cp5.addSlider("period")  
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row2)
      .setSize(sliderW, sliderH)
      .setRange(50, 800)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Period Of Wave")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Amplitude 
      cp5.addSlider("ampAndrei")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row3)
      .setSize(sliderW, sliderH)
      .setRange(.01, .9)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Amplitude")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Band Spacing
      cp5.addSlider("band_spacing")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row4)
      .setSize(sliderW, sliderH)
      .setRange(450, 600)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Band Spacing")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
        
      
      
      // C O L U M N    T W O
      
      //Modulo Effect
      cp5.addSlider("modAmt")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col2, row1)
      .setSize(sliderW, sliderH)
      .setRange(.1, 30)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Modulo Effect")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Filler Lines
      cp5.addSlider("filler_lines")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col2, row2)
      .setSize(sliderW, sliderH)
      .setRange(18, 2)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Filler Lines")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Sine/Square
      cp5.addToggle("sine")
       .setGroup(osc1)
       .setPosition(col2+80,row3)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setLabel("Sine/Square")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
      
      
      //Square Width
      cp5.addSlider("squareWidth")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col2, row4)
      .setSize(sliderW, sliderH)
      .setRange(220, 590)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setValue(squareWidth)
      .setLabel("Square Width")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      
      
      // C O L U M N    T H R E E
      
      //Hue of Wave
      cp5.addSlider("wave_hue")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col3, row1)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Hue Of Wave")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      //Wave Wiggle (not functional)
      cp5.addSlider("waveWiggle")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col3, row2)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Wiggle (broken)")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      //Hue LFO
      cp5.addSlider("wavehueLFO")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col3, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 123)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Hue LFO Amt")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //LFO Speed
      cp5.addSlider("lfo_speed")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col3, row4)
      .setSize(sliderW, sliderH)
      .setRange(0, 12)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("LFO Speed")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      
      
      // C O L U M N    F O U R
      
      
      
      cp5.addToggle("osc1Toggle")
       .setGroup(osc1)
       .setPosition(col4+80,row1)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
        .setValue(osc1Toggle)
       .setLabel("Osc 1 On/Off")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
      
      
      
      //Oscillator Direction
      cp5.addToggle("oscDir")
       .setGroup(osc1)
       .setPosition(col4+80,row2)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setValue(oscDir)
       .setLabel("Wave Direction")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
      
      
      //Period Dialation
      cp5.addSlider("dialationScalar")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col4, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 6)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Period Dialation")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Frequency Modulation
      cp5.addSlider("mysteryModulation")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col4, row4)
      .setSize(sliderW, sliderH)
      .setRange(16, 600)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Time Warp")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
   
      
      // OSCILLATOR 2 GROUP
      
      Group osc2 = cp5.addGroup("osc2");
      

      // C O L U M N    O N E
      
      //Oscillator Speed
    cp5.addSlider("osc_speed2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col1, row1)
      .setSize(sliderW, sliderH)
      .setRange(-.5, .5)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Oscillator Speed 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
    
    //Period
    cp5.addSlider("period2")  
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col1, row2)
      .setSize(sliderW, sliderH)
      .setRange(100, 700)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Period Of Wave 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Amplitude 
      cp5.addSlider("amplitude2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col1, row3)
      .setSize(sliderW, sliderH)
      .setRange(20, 250)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Amplitude 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Band Spacing
      cp5.addSlider("band_spacing2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col1, row4)
      .setSize(sliderW, sliderH)
      .setRange(100, 800)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Band Spacing 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      
      // C O L U M N    T W O
      
      //Modulo Effect
      cp5.addSlider("modAmt2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col2, row1)
      .setSize(sliderW, sliderH)
      .setRange(.1, 30)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Modulo Effect 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Filler Lines
      cp5.addSlider("filler_lines2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col2, row2)
      .setSize(sliderW, sliderH)
      .setRange(18, 2)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Filler Lines 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Sine vs Square
      cp5.addToggle("sine2")
       .setGroup(osc2)
       .setPosition(col2+80,row3)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setLabel("Sine/Square")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
      
      //Square Width
      cp5.addSlider("squareWidth2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col2, row4)
      .setSize(sliderW, sliderH)
      .setRange(220, 360)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setValue(squareWidth2)
      .setLabel("Square Width 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      
      
      
      
      // C O L U M N    T H R E E
      
      //Hue of Wave
      cp5.addSlider("wave_hue2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col3, row1)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Hue Of Wave 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      //Wave Wiggle (Not Functional)
      cp5.addSlider("waveWiggle2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col3, row2)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("empty")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      //Hue LFO
      cp5.addSlider("wavehueLFO2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col3, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 123)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Hue LFO Amt 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //LFO Speed
      cp5.addSlider("lfo_speed2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col3, row4)
      .setSize(sliderW, sliderH)
      .setRange(0, 12)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("LFO Speed 2")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      
      
      
      // C O L U M N    F O U R
      
      //Empty Slot

      //On/Off Switch
      cp5.addToggle("osc2Toggle")
       .setGroup(osc2)
       .setPosition(col4+80,row1)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setLabel("Osc 2 On/Off")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
       
       
      //Oscillator Direction
      cp5.addToggle("oscDir2")
       .setGroup(osc2)
       .setPosition(col4+80,row2)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setLabel("Wave Direction 2")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
       
       
      //Oscillator 2 Opacity
      cp5.addSlider("osc2_opacity")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col4, row3)
      .setSize(sliderW, sliderH)
      .setRange(5, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Opacity")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Empty Slot
      
         
      
      
    //MAIN CONTROLS GROUP
    
    Group main = cp5.addGroup("main");
    

    
      // C O L U M N    O N E
      
      //Empty Slot
         
      //Empty Slot
          
      //Empty Slot
        
      //Empty Slot
      

 
      // C O L U M N    T W O
      
      //Background Hue
      cp5.addSlider("bgr_hue")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col2, row1)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Background Hue")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      //Background Brightness
      cp5.addSlider("bgr_val")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col2, row2)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Backgrnd Bright")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      //Background LFO
      cp5.addSlider("bgrLFO")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col2, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("empty")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      //Background LFO Speed
      cp5.addSlider("bgrLFOSpeed")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col2, row4)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("empty")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      

      
      // C O L U M N    T H R E E 
      
      //Blend Mode Labels
    
      //Blend Mode
      cp5.addSlider("type")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col3, row2)
      .setSize(sliderW, sliderH)
      .setRange(1, 4)
      .setMin(1)
      .setFont(font)
      .setNumberOfTickMarks(4)
      .snapToTickMarks(true)
      .showTickMarks(false)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setLabel("Blend Modes")
      .setSliderMode(Slider.FLEXIBLE)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
       
      
        
      //Symmetry
      cp5.addToggle("symmetry")
       .setGroup(main)
       .setPosition(col3+80,row3)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setLabel("Symmetry")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
      
      //Push/Pull Toggle
      cp5.addToggle("pushPull")
       .setGroup(main)
       .setPosition(col3+80,row4)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
       .setLabel("Push/Pull")
       .setMode(ControlP5.SWITCH)
       .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
       ;
      
      
      
      
      // C O L U M N    F O U R
      
      
      //Load Button
      cp5.addButton("loadPatch")
       .setGroup(main)
       .setPosition(col4,row1-sliderH)
       .setSize(sliderW,sliderH*2)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 255))
        .setColorForeground(color(0, 0, 220))
        .setColorActive(color(0, 0, 255))
       .getCaptionLabel().setVisible(false)
       ;
     
      //Save Patch Button
      cp5.addButton("savePatch")
       .setGroup(main)
       .setPosition(col4,row2-sliderH)
       .setSize(sliderW,sliderH*2)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 255))
        .setColorForeground(color(0, 0, 220))
        .setColorActive(color(0, 0, 255))
       .getCaptionLabel().setVisible(false)
       ;
        
      //Randomize Parameters
      cp5.addButton("randomize")
       .setGroup(main)
       .setPosition(col4,row3-sliderH)
       .setSize(sliderW,sliderH*2)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 255))
        .setColorForeground(color(0, 0, 220))
        .setColorActive(color(0, 0, 255))
       .getCaptionLabel().setVisible(false)
       ;
      
      
      //Restore Default Button
      cp5.addButton("init")
       .setGroup(main)
       .setPosition(col4,row4-sliderH)
       .setSize(sliderW,sliderH*2)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 255))
        .setColorForeground(color(0, 0, 220))
        .setColorActive(color(0, 0, 255))
       .getCaptionLabel().setVisible(false)
       ;
      
    
      
}


public void loadPatch(){
  
    //Load
    String fileString = dataPath("") + "\\" +"*.json" ;
    println(fileString);
    File toLoad = new File( fileString ) ;
    selectInput("Load a file:", "fileSelectedForLoad", toLoad);
    
    loadValues();
   
}

public void savePatch(){
  
    /*
    String words = "apple bear cat dog";
    String[] list = split(words, ' ');
    
    // Writes the strings to a file, each on a separate line
    saveStrings("nouns.txt", list);
   */
   
   
   /*
   String[] patch = {str(ampAndrei), str(period), str(filler_lines)};
   
   println(patch[1]);
   
   saveStrings("patch.txt", patch);
   */
   
   
   //This was in setup()
   json = new JSONObject();
  //REPLACE THESE WITH THE REAL VARIABLE VALUES
  String[] parameter = { "Amplitude (andre)", "Period", "Osc 1 Speed" };
  String[] cur_values   = { str(ampAndrei), str(period), str(osc_speed) };
  
  JSONArray values = new JSONArray();
  
  for (int i = 0; i < parameter.length; i++) {

    JSONObject states = new JSONObject();

    states.setInt("id", i);
    states.setString("parameter", parameter[i]);
    states.setString("cur_value", cur_values[i]);

    values.setJSONObject(i, states);
  }
  
  json.setJSONArray("states", values);
  
  
   
   //------------------------------------------------------------------
   //This was in draw()
   
   outputJSONArray(json, "states");
   
   
   //Save
    String fileString = dataPath("") + "\\*.json" ;
    println(fileString);
    File toSave = new File( fileString ) ;
    selectOutput("Save to a file:", "fileSelectedForSave", toSave);
   
   
}


public void loadValues(){
  
}


public void randomize(){
  

   theta = 0.0;  // Start angle at 0
   amplitude = 185.0;  // Height of wave
   ampAndrei = random(.1, .9);
   period = random(50, 800);  // How many pixels before the wave repeats
  
   osc_speed = random(-.8, 1);
  
   filler_lines = int(random(2, 12));
   
   float l = random(100);
  if(l > 50){
    modAmt = .1;
  }else{
    modAmt = random(.1, 20);
  }
   
   
   modDir = true;
  
   line_amt = 0;
  
   wave_hue = int(random(0, 255));
  
   new_hue = 20;
   bgr_hue = int(random(0, 255));
   
   hue_change = 0;
   
   float i = random(100);
  if(i > 50){
    wavehueLFO = 0;
  }else{
    wavehueLFO = random(0, 123);
  }
   
   
   
   dir = true;
  
   bgr_val = int(random(0, 255));
   lfo_speed = random(0, 12);
  
  float k = random(100);
  if(k > 25){
    sine = true;
  }else{
    sine = false;
  }
   
   squareWidth = int(random(220, 590));
  
  
   blendType = 8;
   
   float n = random(100);
   if(n > 50){
     type = 1;
   }else{
     type = int(random(1, 5));
   }
   
  
   float d = random(100);
  if(d > 50){
    osc2Toggle = true;
  }else{
    osc2Toggle = false;
  }
  
   //This is important bc it needs to stay on the Main Menu Screen
   controls = 3;
   current_control = "Main";
  
  float e = random(100);
  if(e > 50){
    osc1Toggle = true;
  }else{
    osc1Toggle = false;
  }
  
  //have this to make sure both osc never end up off bc thats boring
   if ((osc1Toggle == false) && (osc2Toggle == false)){
     osc1Toggle = true;
   }
  
   band_spacing = int(random(450, 600));
  
   float h = random(100);
  if(h > 50){
    oscDir = true;
  }else{
    oscDir = false;
  }
   
   
   //probability to see if Dialation is used
   float m = random(100);
  if(m > 50){
    dialationScalar = 16;
  }else{
    dialationScalar = random(0, 6);
  }
  
  
   freqMod = 1;
   
   float a = random(100);
  if(a > 75){
    pushPull = true;
  }else{
    pushPull = false;
  }
  
  float b = random(100);
  if(b > 75){
    symmetry = true;
  }else{
    symmetry = false;
  }
  
  
  //PushPull and Symmetry cant both be true for the time being
  if((pushPull == true) && (symmetry == true)){
    float p = random(100);
    if(p>50){
      pushPull = false;
    }else{
      symmetry = false;
    }
  }
  
   //probability to see if Time Warp is used
   float g = random(100);
  if(g > 50){
    mysteryModulation = 16;
  }else{
    mysteryModulation = random(16, 600);
  }
  
 
 
  
  //Second Oscillator Variables
  
   theta2 = 0.0;  
   amplitude2 = random(80, 250); 
   period2 = random(100, 700);
   
   osc_speed2 = random(-.5, .5);
  
   filler_lines2 = int(random(2, 18));
   
    float o = random(100);
  if(o > 50){
    modAmt2 = .1;
  }else{
    modAmt2 = random(.1, 20);
  }
   
   modDir2 = true;
  
   line_amt2 = 0;
  
   wave_hue2 = int(random(0, 255));
  
   new_hue2 = 20;
   bgr_hue2 = 0;
   
   hue_change2 = 0;
   
   float j = random(100);
  if(j > 50){
    wavehueLFO2 = 0;
  }else{
    wavehueLFO2 = random(0, 123);
  }
   
   dir2 = true;
  
   bgr_val2 = 255;
   lfo_speed2 = random(0, 12);
  
   float f = random(100);
  if(f > 25){
    sine2 = true;
  }else{
    sine2 = false;
  }
   squareWidth2 = int(random(220, 360));
  
   osc2_opacity = int(random(50, 255));
  
   band_spacing2 = int(random(100, 800));
   
   float c = random(100);
  if(c > 50){
    oscDir2 = true;
  }else{
    oscDir2 = false;
  }

  
   recording = false;
  
   recordPrompt = "Press to Render";
  
   blendName = "SCREEN";
}





public void init(){
  
  
   theta = 0.0; 
   amplitude = 185.0;  
   ampAndrei = 0.5;
   period = 550.0;  
  
   osc_speed = 0.08;
  
   filler_lines = 10;
   modAmt = .1;
   modDir = true;
  
   line_amt = 0;
  
   wave_hue = 20;
  
   new_hue = 20;
   bgr_hue = 0;
   
   hue_change = 0;
   wavehueLFO = 60;
   dir = true;
  
   bgr_val = 255;
   lfo_speed = 0.2;
  
   sine = true;
   squareWidth = 270;

   blendType = 8;
   type = 1;
  
   osc2Toggle = false;
  
  
   controls = 1;
   
  
   osc1Toggle = true;
  
   band_spacing = 477;
  
   oscDir = true;
  
   dialationScalar = 0;
  
   freqMod = 1;
  
   pushPull = false;
  
   symmetry = false;
   
   mysteryModulation = 16;
   
   
   
  
  //Second Oscillator Variables
  
   theta2 = 0.0;  
   amplitude2 = 85.0; 
   period2 = 250;
   
   osc_speed2 = 0.2;
  
   filler_lines2 = 10;
   modAmt2 = .1;
   modDir2 = true;
  
   line_amt2 = 0;
  
   wave_hue2 = 90;
  
   new_hue2 = 20;
   bgr_hue2 = 0;
   
   hue_change2 = 0;
   wavehueLFO2 = 0;
   dir2 = true;
  
   bgr_val2 = 255;
   lfo_speed2 = 0.4;
  
   sine2 = true;
   squareWidth2 = 270;
  
   osc2_opacity = 200;
  
   band_spacing2 = 490;
  
   oscDir2 = true;
  
   recording = false;
  
   recordPrompt = "Press to Render";
  
   blendName = "SCREEN";
   
   
   
   //Rerunning Setup()
   setup();
}





// -----------------------------------------------------------

// Saving and Loading Patches with JSON files

// -----------------------------------------------------------



void fileSelectedForLoad(File selection) {
  File loading;
  loading = selection;
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else { 
    println("User loaded " + selection.getAbsolutePath());
    if (loading  != null) { 
      json =  loadJSONObject(loading.getAbsolutePath());
      fileNameForScreen=loading.getName();//https://docs.oracle.com/javase/7/docs/api/java/io/File.html
    }
  }//else 
  //
}

void fileSelectedForSave(File selection) {
  File saving;
  saving = selection;
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String saveString = saving.getAbsolutePath();
    saveString=saveString.trim();
    // ending json ok? 
    if (saveString.indexOf(".json") < 0) {
      saveString+=".json"; // very rough approach...
      saving = new File(saveString);
    }
    println("User saved to " + selection.getAbsolutePath());
    if (saving != null) { 
      saveJSONObject(json, saving.getAbsolutePath());
      fileNameForScreen=saving.getName();//https://docs.oracle.com/javase/7/docs/api/java/io/File.html
    }
  }//else 
  //
}

void outputJSONArray(JSONObject json, String nameOfJSONArray) {

  // output of an JSONArray named "nameOfJSONArray" in an an JSONObject json.
  // The function is not generic since column names "parameter" etc. must be correct as below. 

  // error check I. 
  if (json==null) { 
    fill(255, 33, 0); // red 
    text( "No json object", 30, 30+2);
    println("no json object");
    return;
  }//if 

  JSONArray valuesLoaded =  json.getJSONArray(nameOfJSONArray);

  // error check II. 
  if (valuesLoaded==null) { 
          
    //text(error, 30, 30+2);
    println("No json array named "
      + nameOfJSONArray
      + " in json object.");
    return;
  }//if

  fill(40, 255, 17); // black 

  for (int i = 0; i < valuesLoaded.size(); i++) {

    JSONObject states = valuesLoaded.getJSONObject(i); 

    int id = states.getInt("id");
    String parameter = states.getString("parameter");
    String cur_value = states.getString("cur_value");

    println(id + ", " + parameter + ", " + cur_value);
    text(id + ", " + parameter + ", " + cur_value, 40, 50+35*i); // small table
  }
}
