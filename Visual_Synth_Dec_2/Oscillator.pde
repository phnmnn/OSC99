class Oscillator {

  // local variables


  //passed variables in here if i have any
  Oscillator() {

    //reassign the passed variabled to local verions
  }




// -----------------------------------------------------------

// CREATING THE IMAGE OBJECT

// -----------------------------------------------------------


  void imgCreation() {
    img = createImage(width, 490, RGB); // I had the area too big and the UI at bottom was covering a lot of it; wasting resources
  }
  void imgCreation2() {
    img2 = createImage(width, 490, RGB); // I had the area too big and the UI at bottom was covering a lot of it; wasting resources
  }



// -----------------------------------------------------------

// CALCULATING EQUATION AND STORING IN ARRAY

// -----------------------------------------------------------

  void calc(float p, float a, float scalar, float frequencyModulation) {
    dx = (TWO_PI / period) * xspacing;


    if (oscDir == true) {
      theta += osc_speed;
      //dialationScalar = dialationScalar + osc_speed;
      //mysteryModulation = mysteryModulation + osc_speed;
    }
    if (oscDir == false) {
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
      if (scalar>0) {
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
  
  void calc2(float p2, float a2){
      // Increment theta (try different values for 'angular velocity' here
  if (oscDir2 == true) {
    theta2 += osc_speed2;
  }
  if (oscDir2 == false) {
    theta2 -= osc_speed2;
  }

  // For every x value, calculate a y value with sine function
  float x2 = theta2;
  for (int i = 0; i < yvalues2.length; i++) {
    yvalues2[i] = sin(x2)*a2;
    x2+=dx;
  }
  }
  
  
// -----------------------------------------------------------

// LFO FOR THE HUE

// -----------------------------------------------------------



  void colorLFO() {
    //Color LFO

    hue_change = hue_change + lfo_speed;

    if (dir==true) {
      new_hue = wave_hue+hue_change;
    } else if (dir==false) {
      new_hue = wave_hue+wavehueLFO-hue_change;
    }


    if (new_hue<0) {
      new_hue= 255 + new_hue;
    }

    if (new_hue>255) {
      new_hue = new_hue-255;
    }



    if (hue_change>wavehueLFO) {
      dir = !dir;
      hue_change = lfo_speed;
    }
    println(new_hue);
  }
  
  void colorLFO2(){
     //Color LFO 2
    
      hue_change2 = hue_change2 + lfo_speed2;
    
      if (new_hue2<0) {
        new_hue2= 255 + new_hue2;
      }
    
      if (new_hue2>255) {
        new_hue2 = new_hue2-255;
      }
    
      if (dir2==true) {
        new_hue2 = wave_hue2+hue_change2;
      } else if (dir2==false) {
        new_hue2 = wave_hue2+wavehueLFO2-hue_change2;
      }
    
    
      if (hue_change2>wavehueLFO2) {
        dir2 = !dir2;
        hue_change2 = lfo_speed2;
      }

  }
  
  
// -----------------------------------------------------------

// RENDERING THE EQUATION

// -----------------------------------------------------------



  void render(float oscHue, float originalHue) {

    img.loadPixels();





    int line_spacing = filler_lines+line_amt;

    // Generating the Pixel Offset Noise
    float noiseTest = noise(noiseInput);
    float mappedNoise = map(noiseTest*10, 2, 8, -5, 10);
    int columnNoise = round(mappedNoise);
    noiseInput = noiseInput + .1;


    float localHue = originalHue;

    if (lfo_speed > 0) {
      localHue = oscHue;
    }


    for (int i = 0; i < yvalues.length; i++) {

      for (int f = 0; f<line_spacing; f++) {

        int pix_x = i * xspacing + f;

        float siny = height/2+yvalues[i];


        float intensity = map(siny, 430, band_spacing, 0, 255);

        //Modulo Computation

        float mod_width = (1*i)%modAmt;

        modhue = wave_hue + mod_width;



        //Square Wave Boolean
        if (sine==false) {

          if (siny > squareWidth) {
            intensity = 0;
          } else {
            intensity = 255;
          }
        }



        //Modulo
        if (modAmt > 1) {
          for (int y = 0; y < img.height-1; y++) {   



            img.pixels[pix_x+y*width] = color(modhue, 255, intensity);
          }
        }

        //Non Modulo
        else {
          for (int y = 0; y < img.height-1; y++) {         



            img.pixels[pix_x+y*width] = color(localHue, 255, intensity);
          }
        }
      }
    }


    // I dont think this is being used right now
    if (graph == true) {

      int verticalOffset = -180;

      for (int x2 = 0; x2 < yvalues.length; x2++) {
        ellipse(x2*xspacing, height/2+yvalues[x2] + verticalOffset, 12, 12);
      }
    }


    //added from area beneath renderAndreiWave()

    //The logic on symmetry and push/pull has to be flipped for it to show up right on the UI, I dont understand why
    if (symmetry == false) {
      pushMatrix();
      image(img, -width/2, 60);
      scale(-1.0, 1.0);
      image(img, -width-width/2, 60);
      popMatrix();
    } else {
      // Scaling X Axis to Fix the Left Side
      pushMatrix();
      scale(1.1, 1);
      image(img, -20, 60);
      popMatrix();
    }
    //The logic on symmetry and push/pull has to be flipped for it to show up right on the UI, I dont understand why
    if (pushPull == false) {

      pushMatrix();
      scale(-1.0, 1.0);
      image(img, -img.width, 60);
      translate(width/2, 0);
      popMatrix();
    }

    img.updatePixels();
  }
  
  void render2(float oscHue2){
        img2.loadPixels();  
        
        
        
          int line_spacing = filler_lines2+line_amt2;
      
      
        for (int i = 0; i < yvalues2.length; i++) {
      
          for (int f = 0; f<line_spacing; f++) {
      
      
            int pix_x = i * xspacing + f;
      
            float siny = height/2+yvalues2[i];
      
      
            float intensity = map(siny, 100, band_spacing2, 0, 255);
      
      
      
            //Modulo Computation
      
            float mod_width = (1*i)%modAmt2;
      
            modhue2 = wave_hue2 + mod_width;
      
      
            //Square Wave Boolean
            if (sine2==false) {
      
              if (siny > squareWidth2) {
                intensity = 0;
              } else {
                intensity = 255;
              }
            }
      
      
            //Modulo
            if (modAmt2 > 1) {
              for (int y = 0; y < img2.height-1; y++) {   
      
      
      
                img2.pixels[pix_x+y*width] = color(modhue2, 255, intensity);
              }
            }
      
            //Non Modulo
            else {
              for (int y = 0; y < img2.height-1; y++) {         
      
      
      
                img2.pixels[pix_x+y*width] = color(oscHue2, 255, intensity);
              }
            }
          }
        }
        
        
    img2.updatePixels();

    pushMatrix();
    translate(1200, 0);
    rotate(PI/2.0);
    scale(.5, 3);
    tint(255, osc2_opacity);
    image(img2, 0, 0);
    popMatrix();

    tint(255, 255);
  }



// -----------------------------------------------------------

// RESTORING THE OSCs TO DEFAULT VALUES

// -----------------------------------------------------------

  void initOsc() {
    //First Osc Variables
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

    lfo_speed = 0.2;

    sine = true;
    squareWidth = 270;


    osc1Sleep = false;

    band_spacing = 477;

    oscDir = true;

    dialationScalar = 0;

    freqMod = 1;

    pushPull = true;

    symmetry = true;

    mysteryModulation = 16;

    xspacing = 8;



    //Second Oscillator Variables

    theta2 = 0.0;  
    amplitude2 = 85.0; 
    period2 = 250;
    osc2Sleep = true;

    osc_speed2 = 0.2;

    filler_lines2 = 10;
    modAmt2 = .1;
    modDir2 = true;

    line_amt2 = 0;

    wave_hue2 = 90;

    new_hue2 = 20;
    //bgr_hue2 = 0;

    hue_change2 = 0;
    wavehueLFO2 = 0;
    dir2 = true;

    //bgr_val2 = 255;
    lfo_speed2 = 0.4;

    sine2 = true;
    squareWidth2 = 270;

    osc2_opacity = 200;

    band_spacing2 = 490;

    oscDir2 = true;
  }
  
  
  
// -----------------------------------------------------------

// RANDOMIZING THE OSC VALUES

// -----------------------------------------------------------


  void randomizeOsc() {

    //Deciding which osc are asleep

    float e = random(100);
    if (e > 50) {
      osc1Sleep = false;
    } else {
      osc1Sleep = true;
    }



    float d = random(100);
    if (d > 50) {
      osc2Sleep = false;
    } else {
      osc2Sleep = true;
    }


    //have this to make sure both osc never end up off bc thats boring
    if ((osc1Sleep == true) && (osc2Sleep == true)) {
      osc1Sleep = false;
    }



    // First OSC

    //not sure why these first two aren't random, there might be a reason
    theta = 0.0;  // Start angle at 0
    amplitude = 185.0;  // Height of wave
    ampAndrei = random(.1, .9);
    period = random(50, 800);  // How many pixels before the wave repeats

    osc_speed = random(-.8, 1);

    filler_lines = int(random(2, 12));

    float l = random(100);
    if (l > 50) {
      modAmt = .1;
    } else {
      modAmt = random(.1, 20);
    }


    modDir = true;

    line_amt = 0;

    wave_hue = int(random(0, 255));

    new_hue = 20;

    hue_change = 0;

    float i = random(100);
    if (i > 50) {
      wavehueLFO = 0;
    } else {
      wavehueLFO = random(0, 123);
    }



    dir = true;
    lfo_speed = random(0, 12);

    float k = random(100);
    if (k > 25) {
      sine = true;
    } else {
      sine = false;
    }

    squareWidth = int(random(220, 590));

    float xx = random(100);
    if (xx<80) {
      xspacing = 8;
    } else {
      xspacing = int(random(8, 10));
    }


    band_spacing = int(random(450, 600));

    float h = random(100);
    if (h > 50) {
      oscDir = true;
    } else {
      oscDir = false;
    }


    //probability to see if Dialation is used
    float m = random(100);
    if (m > 50) {
      dialationScalar = 16;
    } else {
      dialationScalar = random(0, 6);
    }


    freqMod = 1;

    float a = random(100);
    if (a > 75) {
      pushPull = false;
    } else {
      pushPull = true;
    }

    float b = random(100);
    if (b > 75) {
      symmetry = false;
    } else {
      symmetry = true;
    }


    //PushPull and Symmetry cant both be true for the time being, dont know if thats still true
    if ((pushPull == false) && (symmetry == false)) {
      float p = random(100);
      if (p>50) {
        pushPull = true;
      } else {
        symmetry = true;
      }
    }

    //probability to see if Time Warp is used
    float g = random(100);
    if (g > 50) {
      mysteryModulation = 16;
    } else {
      mysteryModulation = random(16, 600);
    }







    //Second Oscillator Variables

    theta2 = 0.0;  
    amplitude2 = random(80, 250); 
    period2 = random(100, 700);

    osc_speed2 = random(-.5, .5);

    filler_lines2 = int(random(2, 18));

    float o = random(100);
    if (o > 50) {
      modAmt2 = .1;
    } else {
      modAmt2 = random(.1, 20);
    }

    modDir2 = true;

    line_amt2 = 0;

    wave_hue2 = int(random(0, 255));

    new_hue2 = 20;
    //bgr_hue2 = 0;

    hue_change2 = 0;

    float j = random(100);
    if (j > 50) {
      wavehueLFO2 = 0;
    } else {
      wavehueLFO2 = random(0, 123);
    }

    dir2 = true;

    //bgr_val2 = 255;
    lfo_speed2 = random(0, 12);

    float f = random(100);
    if (f > 25) {
      sine2 = true;
    } else {
      sine2 = false;
    }
    squareWidth2 = int(random(220, 360));

    osc2_opacity = int(random(50, 255));

    band_spacing2 = int(random(100, 800));

    float c = random(100);
    if (c > 50) {
      oscDir2 = true;
    } else {
      oscDir2 = false;
    }
  }
}
