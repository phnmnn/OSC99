class Oscillator {

      // each osc has a set of these, osc1.new_hue, osc2.new_hue
      float new_hue = 20; 
      float hue_inc = 0; 
      boolean lfoDir = true; 
      
      // i can't get p5 to recognize values in here,  maybe i need to do "instancing"/"wrapping", i treid "extending" and that caused errors

  Oscillator() {

    //reassign the passed variabled to local verions
    
      
  }


// -----------------------------------------------------------

// CREATING THE IMAGE OBJECT

// -----------------------------------------------------------


  void imgCreation() {
    img = createImage(renderAreaWidth, renderAreaHeight, RGB); // I had the area too big and the UI at bottom was covering a lot of it; wasting resources
  }
  void imgCreation2() {
    img2 = createImage(renderAreaWidth, renderAreaHeight, RGB); 
  }



// -----------------------------------------------------------

// CALCULATING EQUATION AND STORING IN ARRAY

// -----------------------------------------------------------

  void calc() {
    float dx;  // Value for incrementing X, a function of period and xspacing
    dx = (TWO_PI / period) * xspacing; // here xspacing is effecting in real time, but its also used in set up to initialize the yvalue ammount

    // wave moves forward or backward
    if (oscDir == true) {
      theta += osc_speed;
    }
    if (oscDir == false) {
      theta -= osc_speed;
    }

    float local_theta = theta; // i have to have a local one because i have osc_speed seperate from dx

    int hei = 1200; // "height-margin", not sure
    int w2 = 1200; // dont remember
    float dialation;
    float scalar = dialationScalar * local_theta;

    for (int i = 0; i < yvalues.length; i++) {

      dialation = ((8+mysteryModulation/16*i/w2)/w2) + scalar;
      yvalues[i] = (1+hei/8*amplitude)*(1+.5*freqMod*cos(local_theta*(1+i*cos(dialation/8+mysteryModulation/16*i/w2)/w2)));

      local_theta+=dx;
      //x2+=dx;
      if (scalar>0) {
        scalar += dx;
      }
    }

    //Adrei Jay's Equation that I started with:
    
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
  
  // This is a more basic sine wave function
  void calcSimple(){ 
  float dx;  // Value for incrementing X, a function of period and xspacing
   dx = (TWO_PI / period2) * xspacing2;
  
   // Increment theta (try different values for 'angular velocity' here
  if (oscDir2 == true) {
    theta2 += osc_speed2;
  }
  if (oscDir2 == false) {
    theta2 -= osc_speed2;
  }

  // For every x value, calculate a y value with sine function
  float t2 = theta2;
  for (int i = 0; i < xvalues.length; i++) {
    xvalues[i] = sin(t2)*amplitude2;
    t2+=dx;
  }
 }
  
  
// -----------------------------------------------------------

// LFO FOR THE HUE

// -----------------------------------------------------------

  void colorLFO(int base_hue, float lfo_hue, float amount,float speed, boolean direction, float inc) {

    // hue_change starts at zero
    
    if (direction==true) {
      inc += speed;
      lfo_hue = base_hue+inc;
      //println("foward");
    } else {
      inc -= speed;
      lfo_hue = base_hue+inc;
      //println("backwards");
    }


    if (lfo_hue<0) {
      lfo_hue= 255 + lfo_hue; //add new_hue becuase its a negative number at this point
    }
    if (lfo_hue>255) {
      lfo_hue = lfo_hue-255;
    }
    // if the incriment amount gets bigger than the lfo amount, then go backwards, reset incriment to zero
    if (inc>amount) {
      direction = !direction;
      //println("change direction");
    }
    if (direction == false && inc <= speed){
     direction = !direction;  
    }
    //println("inc " + inc);
    //println("amount: " + amount);

    new_hue = lfo_hue;
    hue_inc = inc;
    lfoDir = direction; 
  }
  
  
// -----------------------------------------------------------

// RENDERING THE EQUATION

// -----------------------------------------------------------

  void render() {

    img.loadPixels();
    
    float local_hue = wave_hue; 

    if(hueLFOSleep == false){
      colorLFO(wave_hue, new_hue, lfo_amt, lfo_speed, lfoDir, hue_inc); // there should be an if statement to see if the LFO is on
      local_hue = new_hue;
    }


    for (int i = 0; i < yvalues.length; i++) {
       // im attempting to fill in all the column for the amount of filler_lines
      for (int f = 0; f<filler_lines; f++) {

        int pix_x = i * ARRAY_DIVIDER + f;

        float siny = img.height/2+yvalues[i]; //should this be img.height?

        // 430 - original value for MapLowerBound at old size
        float intensity = map(siny, intensityMapLowerBound, band_spacing, 0, 255); // look here when having trouble resizing
        // map(value, lower bound of current range, upper bound of currrent range, lower bound of target range, upper bound of target range);

        //Square Wave Boolean
        if (sine==false) {
          if (siny > squareWidth) {
            intensity = 0;
          } else {
            intensity = 255;
          }
        }

        //Modulo
        if (modulo_amt > 1) {
          float mod_width = (1*i)%modulo_amt;
          float modhue = local_hue + mod_width;
          for (int y = 0; y < img.height-1; y++) {   
            img.pixels[pix_x+y*width] = color(modhue, 255, intensity);
          }
        }
        //Non Modulo, i can't get this working with just if(modulo_amt>1) local_hue=modhue, even tho i would think it would
        else {
          for (int y = 0; y < img.height-1; y++) {         
            img.pixels[pix_x+y*width] = color(local_hue, 255, intensity);
            }
          }    
      }
    } // end of yvalue iterations

     if(invertFilter == true){
       filter(INVERT);
     }

     tint(255, osc1_opacity);

    //The logic on symmetry and push/pull has to be flipped for it to show up right on the UI, I dont understand why
    if (symmetry == false) {
      pushMatrix();
        image(img, -width/2, topNavHeight);
        scale(-1.0, 1.0);
        image(img, -width-width/2, topNavHeight);
      popMatrix();
    } 
    // Regular Wave
    else {
      // Scaling X Axis to Fix the Left Side
      pushMatrix();
        scale(1.1, 1);
        image(img, -(ARRAY_DIVIDER + filler_lines), topNavHeight);
      popMatrix();
    }
    //Push/Pull is just another image flipped on top, so it needs a see through blending mode to work
    //The logic on symmetry and push/pull has to be flipped for it to show up right on the UI
    if (pushPull == false) {
      pushMatrix();
        blendMode(SCREEN);
        scale(-1.1, 1.0);
        image(img, -img.width + (ARRAY_DIVIDER + filler_lines), topNavHeight);
        translate(width/2, 0);
      popMatrix();
    }

    img.updatePixels();
    
    tint(255, 255);

  }
  
  void render2(){
    
    img2.loadPixels();  
        
    float local_hue = wave_hue; 

    if(hueLFOSleep2 == false){
      colorLFO(wave_hue2, new_hue, lfo_amt2, lfo_speed2, lfoDir, hue_inc); // some of these are part of the object variables for this class
      local_hue = new_hue;
    }
        
    int line_spacing = filler_lines2+line_amt2;

    for (int i = 0; i < xvalues.length-1; i++) {
      
      for (int f = 0; f<line_spacing; f++) {
      
        int pix_y = i * ARRAY_DIVIDER + f;

        float siny = img2.width/2+xvalues[i];

        float intensity = map(siny, intensityMapLowerBound2, band_spacing2, 0, 255);
  
        //Modulo Computation
        // Changing this from "1" to "2" makes it work for the horizontal (in addition to flipping the for loops)
        float mod_width = (2*i)%modulo_amt2;
  
        modhue2 = local_hue + mod_width;

        //Square Wave Boolean
        if (sine2==false) {
  
          if (siny > squareWidth2) {
            intensity = 0;
          } else {
            intensity = 255;
          }
        }
  
        //Modulo
        if (modulo_amt2 > 1) {
          for (int x = 0; x < img2.width-1; x++) {    
  
  
  
            img2.pixels[x+pix_y*width] = color(modhue2, 255, intensity);
          }
        }
  
        //Non Modulo
        else {
          for (int x = 0; x < img2.width-1; x++) {         
            img2.pixels[x+pix_y*width] = color(local_hue, 255, intensity);
          }
        }
      }
    }
           
    img2.updatePixels();
    
   if(invertFilter == true){
       filter(INVERT);
     }

    pushMatrix();
      scale(1, 1.1);
      tint(255, osc2_opacity);
      image(img2, 0, topNavHeight);
    popMatrix();

    tint(255, 255);
  }

void showGraph(){
      if (graph == true) {
      int verticalOffset = -190; // should be some parameter involving render area and amplitude
      
      for (int x2 = 0; x2 < yvalues.length; x2++) {
        //if sine == false, then everything above a threshold is certain height, else other height
        push();
          translate(0, 200);
          blendMode(BLEND);
          noStroke();
          fill(255, 0, 255);
          ellipse((x2*ARRAY_DIVIDER) , img.height/2+yvalues[x2] + verticalOffset, 12, 12);
        pop();
      }
    }
}


// -----------------------------------------------------------

// RESTORING THE OSCs TO DEFAULT VALUES

// -----------------------------------------------------------

  void initOsc() {
    
    //First Osc Variables
    
    theta = 0.0;
    
    osc1Sleep = false;
    oscDir = true;
    osc1_opacity = 255;
    amplitude = 0.5;
    period = 550.0;  
    osc_speed = 0.08;
    xspacing = 8;
    filler_lines = 10;
    band_spacing = 477;
    modulo_amt = .1;
    wave_hue = 20;
    hueLFOSleep = false;
    new_hue = 20;
    hue_inc = 0;
    lfo_amt = 60;
    lfo_speed = 0.2;
    lfoDir = true;
    sine = true;
    squareWidth = 270;
    dialationScalar = 0;
    freqMod = 1;
    mysteryModulation = 16;
    pushPull = true;
    symmetry = true;
    

    //Second Oscillator Variables

    theta2 = 0.0;  
    
    osc2Sleep = true;
    oscDir2 = true;
    osc2_opacity = 200;
    amplitude2 = 85.0; 
    period2 = 250;
    osc_speed2 = 0.2;
    xspacing2 = 8;
    filler_lines2 = 10;
    line_amt2 = 0;
    band_spacing2 = 490;
    modulo_amt2 = .1;
    wave_hue2 = 90;
    hueLFOSleep2 = false;
    new_hue2 = 20;
    hue_change2 = 0;
    lfo_amt2 = 0;
    lfo_speed2 = 0.4;
    sine2 = true;
    squareWidth2 = 270;

  }
  
  
  
// -----------------------------------------------------------

// RANDOMIZING THE OSC VALUES

// -----------------------------------------------------------


  void randomizeOsc() {
    
    // Deciding which osc are asleep
    osc1Sleep = (random(100) > 50) ? false : true;
    osc2Sleep = (random(100) > 50) ? false : true;
    //have this to make sure both osc never end up off bc thats boring
    if ((osc1Sleep == true) && (osc2Sleep == true)) {
      osc1Sleep = false;
    }
    
    //We dont want a low opacity if only one OSC is on
    if(osc2Sleep == true){
      osc1_opacity = 255;
    }
    else{
      osc1_opacity = int(random(50, 255));
    }
    if(osc1Sleep == true){
      osc2_opacity = 255;
    }
    else{
    osc2_opacity = int(random(50, 255));
    }
    
    // First OSC
    
    theta = 0.0;  // I think this has to be zero to start the wave over
    
    oscDir = (random(100)>50) ? true : false;
    amplitude = random(.15, .99);
    period = random(50, 1100);
    osc_speed = random(.05, 1);
    xspacing = 8;
    filler_lines = (random(100) > 40) ? 10 : int(random(2,12));
    band_spacing = int(random(440, 840));
    modulo_amt = (random(100) > 40) ? 0 : random(.1,20);
    wave_hue = int(random(0, 255));
    hueLFOSleep = (random(100)>80) ? true : false;
    new_hue = 20; // This is lfo internal stuff
    hue_inc = 0;
    lfo_amt = (random(100) > 50) ? 0 : random(0,100);
    lfo_speed = random(0, 12);
    lfoDir = true;
    sine = (random(100) > 25) ? true : false;
    squareWidth = int(random(300, 440));
    dialationScalar = (random(100)>50) ? 16 : random(0,6);
    freqMod = 1;
    mysteryModulation = (random(100)>50) ? 16: random(16, 600);
    pushPull = (random(100)>75) ? false : true;
    symmetry = (random(100)>75) ? false : true;
    //PushPull and Symmetry cant both be true for the time being, dont know if thats still true
    if ((pushPull == false) && (symmetry == false)) {
      pushPull = (random(100)>50) ? true : false;
      symmetry = !pushPull;
    }


    //Second Oscillator Variables

    theta2 = 0.0;  
    
    oscDir2 = (random(100)>50) ? true : false;
    amplitude2 = random(50, 650); 
    period2 = random(40, 700);
    osc_speed2 = random(.05, .5);
    xspacing2 = 8;
    filler_lines2 = int(random(6, 12));
    line_amt2 = 0;
    band_spacing2 = int(random(450, 1100));
    modulo_amt2 = (random(100)>50) ? .1 : random(.1, 100);
    wave_hue2 = int(random(0, 255));
    hueLFOSleep2 = (random(100)>80) ? true : false;
    new_hue2 = 20;
    hue_change2 = 0;
    lfo_amt2 = (random(100)>50) ? 0 : random(0, 90);
    lfo_speed2 = random(0, 12);
    sine2 = (random(100)>25) ? true : false;
    squareWidth2 = int(random(220, 360));

  }
  
  void randomChange(){
    
    float speed = 1/randomSpeed;
    float interval = speed * 48;
    
    if(frameCount % int(interval) == 0){
      int i = int(random(0, 48));
      //println("12 frames");
      println(i);
      switch(i){
        case 0:
        if (osc2Sleep == false) {
          if (osc1Sleep == false){
            osc1Sleep = (random(100) > 20) ? false : true;
          }
          else{
            osc1Sleep = false;
          }
        } 
        case 1:
        oscDir = (random(100)>50) ? true : false;
        break;
        case 2:
        if (osc2Sleep == false) {
          osc1_opacity = int(random(50, 255));
          cp5.getController("osc1_opacity").setValue(osc1_opacity);
        } 
        break;
        case 3:
        amplitude = random(.15, .99);
        cp5.getController("amplitude").setValue(amplitude);
        break;
        case 4:
        period = random(50, 1100);
        cp5.getController("period").setValue(period);
        break;
        case 5:
        osc_speed = random(.05, 1);
        cp5.getController("osc_speed").setValue(osc_speed);
        break;
        case 6:
        //blank
        break;
        case 7:
        filler_lines = int(random(2, 12));
        cp5.getController("filler_lines").setValue(filler_lines);
        break;
        case 8:
        //blank
        break;
        case 9:
        band_spacing = int(random(440, 840));
        cp5.getController("band_spacing").setValue(band_spacing);
        break;
        case 10:
        modulo_amt = (random(100) > 80) ? 0 : random(.1,20);
        cp5.getController("modulo_amt").setValue(modulo_amt);
        break;
        case 11:
        wave_hue = int(random(0, 255));
        cp5.getController("wave_hue").setValue(wave_hue);
        break;
        case 12:
        hueLFOSleep = (random(100)>20) ? true : false;
        break;
        case 13:
        lfo_amt = (random(100) > 50) ? 0 : random(0,100);
        cp5.getController("lfo_amt").setValue(lfo_amt);
        break;
        case 14:
        lfo_speed = random(0, 12);
        cp5.getController("lfo_speed").setValue(lfo_speed);
        break;
        case 15:
        // blank
        break;
        case 16:
        sine = (random(100) > 25) ? true : false;
        break;
        case 17:
        squareWidth = int(random(300, 440));
        cp5.getController("squareWidth").setValue(squareWidth);
        break;
        case 18:
        dialationScalar = (random(100)>50) ? 16 : random(0,6);
        cp5.getController("dialationScalar").setValue(dialationScalar);
        break;
        case 19:
        // blank
        break;
        case 20:
        mysteryModulation = (random(100)>50) ? 16: random(16, 600);
        cp5.getController("mysteryModulation").setValue(mysteryModulation);
        break;
        case 21:
        pushPull = (random(100)>75) ? false : true;
        break;
        case 22:
        symmetry = (random(100)>75) ? false : true;
        break;
        
        // OSC2 Variables
        case 23:
        if (osc1Sleep == false) {
          if(osc2Sleep == false){
            osc2Sleep = (random(100) > 50) ? false : true;
          }else{
            osc2Sleep = false;
          }
        } 
        break;
        case 24:
        oscDir2 = (random(100)>50) ? true : false;
        break;
        case 25:
        if (osc1Sleep == false) {
          osc1_opacity = int(random(50, 255));
          cp5.getController("osc2_opacity").setValue(osc2_opacity);
        } 
        break;
        case 26:
        amplitude2 = random(50, 650);
        cp5.getController("amplitude2").setValue(amplitude2);
        break;
        case 27:
        period2 = random(40, 700);
        cp5.getController("period2").setValue(period2);
        break;
        case 28:
        osc_speed2 = random(.05, .5);
        cp5.getController("osc_speed2").setValue(osc_speed2);
        break;
        case 29:
        //blank
        break;
        case 30:
        filler_lines2 = int(random(6, 12));
        cp5.getController("filler_lines2").setValue(filler_lines2);
        break;
        case 31:
        //blank
        break;
        case 32:
        band_spacing2 = int(random(450, 1100));
        cp5.getController("band_spacing2").setValue(band_spacing2);
        break;
        case 33:
        modulo_amt2 = (random(100)>80) ? .1 : random(.1, 100);
        cp5.getController("modulo_amt2").setValue(modulo_amt2);
        break;
        case 34:
        wave_hue2 = int(random(0, 255));
        cp5.getController("wave_hue2").setValue(wave_hue2);
        break;
        case 35:
        hueLFOSleep2 = (random(100)>40) ? true : false;
        break;
        case 36:
        lfo_amt2 = (random(100)>50) ? 0 : random(0, 90);
        cp5.getController("lfo_amt2").setValue(lfo_amt2);
        break;
        case 37:
        lfo_speed2 = random(0, 12);
        cp5.getController("lfo_speed2").setValue(lfo_speed2);
        break;
        case 38:
        //blank
        break;
        case 39:
        sine2 = (random(100)>25) ? true : false;
        break;
        case 40:
        squareWidth2 = int(random(220, 360));
        cp5.getController("squareWidth2").setValue(squareWidth2);
        break;

        //Some Global Stuff
        case 41:
        bgr_hue = int(random(0, 255));
        break;
        case 42:
        bgr_sat = (random(100) > 20) ? 255 : int(random(0, 255));
        break;
        case 43:
        bgr_val = int(random(0, 255));
        break;
        case 44:
        invertFilter = (random(100) > 95) ? true : false;
        break;
        case 45:
        // Blend Modes : not sure if this is a good fit for this mode
        break;
        
      }
      
    }
    
  }
  

}
