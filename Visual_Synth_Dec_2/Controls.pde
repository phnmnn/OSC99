// -----------------------------------------------------------

// USER INTERFACE

// -----------------------------------------------------------


class Controls {

    PFont font;
    PFont titleFont;
  
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
    
    
    String recordPrompt = "Press to Render";

    String topTitle = "Oscillator 99";

  // These passed values aren't totally necessary
  Controls(PFont font, PFont titleFont) {
    
    this.font = font;
    this.titleFont = titleFont;
    

  }
  
  
  
// -----------------------------------------------------------

// ADDING CONTROLP5 BUTTONS/SLIDERS

// -----------------------------------------------------------

  void addButtons(){
    
        
    // TOGGLE SWITCH / TOP CONTROLS
     
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
  
      
      
      

// OSC1 MENU - FIRST MENU

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
      
      
      ////XSpacing (only visible when square is on I need to change that)
      cp5.addSlider("xspacing")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col3, row2)
      .setSize(sliderW, sliderH)
      .setRange(8, 14)
      .setFont(font)
      .setColorValue(color(0, 0, 0))
      .setColorBackground(color(0, 0, 0))
      .setColorForeground(color(0, 0, 255))
      .setColorActive(color(0, 0, 255))
      .setValue(squareWidth)
      .setLabel("Xspacing")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
            
      ////Wave Wiggle (not functional)
      //cp5.addSlider("waveWiggle")
      //.setGroup(osc1)
      //.setBroadcast(false)
      //.setPosition(col3, row2)
      //.setSize(sliderW, sliderH)
      //.setRange(0, 255)
      //.setFont(font)
      //.setColorValue(color(0, 0, 0))
      //.setColorBackground(color(0, 0, 0))
      //.setColorForeground(color(0, 0, 255))
      //.setColorActive(color(0, 0, 255))
      //.setLabel("Wiggle (broken)")
      //.setSliderMode(Slider.FIX)
      //.setBroadcast(true)
      //.getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      //;
      
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
      .setLabel("Hue LFO Speed")
      .setSliderMode(Slider.FIX)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      
      
      
      
      
      // C O L U M N    F O U R
      
      
      
      cp5.addToggle("osc1Sleep")
       .setGroup(osc1)
       .setPosition(col4+80,row1)
       .setSize(40,sliderH)
       .setFont(font)
       .setColorValue(color(0, 0, 0))
        .setColorBackground(color(0, 0, 0))
        .setColorForeground(color(0, 0, 255))
        .setColorActive(color(0, 0, 255))
        .setValue(osc1Sleep)
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
      
   

      
// OSCILLATOR 2 MENU
      
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
      cp5.addToggle("osc2Sleep")
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
       
       

    
//MAIN CONTROLS GROUP / LAST MENU
    
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
      .setRange(1, 5)
      .setMin(1)
      .setFont(font)
      .setNumberOfTickMarks(5)
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
       //.setValue(false)
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
       
       //cp5.getController("symmetry").setValue(false);
      
      //Push/Pull Toggle
      cp5.addToggle("pushPull")
       .setGroup(main)
       .setPosition(col3+80,row4)
       //.setValue(false)
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
  
  
// -----------------------------------------------------------

// SHOWING AND HIDING BUTTON GROUPS FOR EACH MENU

// -----------------------------------------------------------

  
  void toggle(){
    
       //if(controls==1||controls==4){
       //    if(sine==true){
       //       controls = 1;

       //     }
       //   else if(sine==false){
       //       controls = 4;

       //     }
       //}


   
    
          //Control Toggle Show/Hide
      if (controls == 1){
        cp5.getGroup("osc1").show();
        cp5.getGroup("osc2").hide();
        cp5.getGroup("main").hide();
        //cp5.getGroup("osc1").hide();
        current_control = "OSC1";
      }

      if (controls == 2){
        cp5.getGroup("osc2").show();
        cp5.getGroup("osc1").hide();
        cp5.getGroup("main").hide();
        //cp5.getGroup("osc1_square").hide();
        current_control = "OSC2";
      }
      if (controls == 3){
        cp5.getGroup("main").show();
        cp5.getGroup("osc2").hide();
        cp5.getGroup("osc1").hide();
        //cp5.getGroup("osc1_square").hide();
        current_control = "MAIN";
      }
      

      if(sine==true){
        cp5.getController("squareWidth").hide();
        //cp5.getController("xspacing").show();
      }
      
      if(sine==false){
        cp5.getController("squareWidth").show();
        //cp5.getController("xspacing").hide();
      }
        
      
      if(sine2==true){
        cp5.getController("squareWidth2").hide();
      }
      
      if(sine2==false){
        cp5.getController("squareWidth2").show();
      }
  
  }
  
  
// -----------------------------------------------------------

// DRAWING UI ELEMENTS OTHER THAN P5 SLIDERS/BUTTONS

// -----------------------------------------------------------

  
  
  void drawUI(){
    //println("drawing");
    
    blendMode(blendType);

    //UI Rectangles
    fill(bgr_hue, 255, bgr_val);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width, 60);
    rect(0, height-uiHeight, width, height);
    
    
    blendMode(BLEND);
    
    textFont(font);
    textAlign(CENTER, CENTER);
    fill(255);
    
    text(current_control, 140, 28);
    
    textAlign(LEFT, CENTER);
    text(recordPrompt, 840, 30);
    
    noFill();
    stroke(255);
    strokeWeight(3);
  
  
    // UI Toggle Box
    rect(40, 22, 60, 16);
    
    //Render Button Circle
    ellipse(1060, 30, 23, 23);
    
  
    blendMode(SCREEN);
  
    cp5.draw(); 
    
    
    blendMode(BLEND);

    
    
    // Drawing the extra UI elements when toggling through menus
    // This needs some attention bc i could parameterize this, col1+40, and if the value added is the same for a lot make it a "nudge" variable
    
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
      
      
      //Toggle Boxes
      rect(678, 720, 40, 13); //Symmetry 
      rect(678, 786, 40, 13); //Push/Pull 
      
      
      //Blending Modes
      
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
      else if(type==5){
        blendName = "Normal"; 
      }
     // else if(type==6){
     //   blendName = "DARKEST"; 
     // }
     //else if(type==7){
     //   blendName = "DIFFERENCE"; 
     // }
     //else if(type==8){
     //   blendName = "EXCLUSION"; 
     // }
     //else if(type==9){
     //   blendName = "MULTIPLY"; 
     // }
  
     
      else{
        blendName = "SCREEN";
      }
      
      rect(597, 583-10, 208, 23);
      textAlign(CENTER, CENTER);
      text(blendName, 597 + 208/2, 583);
      
      // Blend Modes Toggle Box
      rect(597, 651, 208, 13);
      
      blendMode(BLEND);
      fill(bgr_hue, 255, bgr_val);
      text("Load Patch", width-132, 582);
      text("Save Patch", width-132, 651);
      text("Randomize", width-132, height-97);
      text("Restore Default", width-132, height-30);
  }
  
  

  
    //Title
  
  textFont(titleFont);
  textAlign(CENTER, CENTER);
  //Title Font Color
  fill(255);
  text(topTitle, width/2, 30);
  
  

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


  // Special UI for when Blend mode is "Lightest"
  // i THINK i fixed it in here with my strategic use of blending modes
   //if(type==4&&bgr_val<200){
   //   //rect(0, 547, 1111, 812);
   //   bgr_val = 255;
   // }
   // else{
      
   // }
 
  }
  
// -----------------------------------------------------------

// UPDATING THE TITLE AFTER A PRESET IS LOADED IN

// -----------------------------------------------------------

  
  void presetTitle(String loadedTitle){
     topTitle = loadedTitle; 
  
}
}
