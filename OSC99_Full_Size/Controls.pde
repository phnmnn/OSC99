// -----------------------------------------------------------

// USER INTERFACE

// -----------------------------------------------------------


class Controls {

  PFont font;
  PFont titleFont;

  int totalCol = 5;
  int totalRow = 5;
  int spacing = 40; // like margins
  int v_spacing = 30;
  
  int buffer = 70;
  int sliderW = round(width/totalCol-buffer);
  int sliderH = 13;

  int col1 = spacing;
  int col2 = width/totalCol+spacing;
  int col3 = width/2-(sliderW/2); //centers it
  int col4 = (width/totalCol) *3 + (spacing);
  int col5 = (width/totalCol) *4 + (spacing);

  int row_area = ((uiHeight-(v_spacing*2))/totalRow);
  int row1 = (height-uiHeight) + v_spacing*2; 
  int row2 = row1 + row_area; 
  int row3 = row2 + row_area;
  int row4 = row3 + row_area;
  int row5 = row4 + row_area;
  
  
  int toggleBufferX = 80;
  int toggleW = 40;
  int buttonWBuffer = 50;
  
  //Control P5 Colors
  int valueColor = color(0, 0, 0);
  int buttonBackground = color(0, 0, 0);
  int buttonForeground = color(0, 0, 255);
  int activeColor = color(0, 0, 255); 
  
  
  boolean menuDown = false;
  boolean valueView = false;
  boolean toolTipOn = true;
  boolean messageOnScreen = false; 


  String recordPrompt = "Press to Render";
  String topTitle = "Oscillator 99";
  String dropdownTitle = "Blending Modes ";
  String content;
  
  float frameCounter = 0;
  
  List blendModeOptions = Arrays.asList("SCREEN", "ADD", "SUBTRACT", "LIGHTEST", "NORMAL");
  
  // These passed values aren't totally necessary
  Controls(PFont font, PFont titleFont) {
    this.font = font;
    this.titleFont = titleFont;
  }


  // -----------------------------------------------------------

  // ADDING CONTROLP5 BUTTONS/SLIDERS

  // -----------------------------------------------------------

  void addButtons() {

    // TOGGLE SWITCH / TOP CONTROLS

    cp5.addSlider("controls")
      .setPosition(28, 23)
      .setSize(70, 20)
      .setRange(0, 3)
      .setMin(1)
      .setFont(font)
      .setNumberOfTickMarks(3)
      .snapToTickMarks(true)
      .showTickMarks(false)
      .setValueLabel("")
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("")
      .setSliderMode(Slider.FLEXIBLE)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;



// OSC1 MENU - FIRST MENU

    Group osc1 = cp5.addGroup("osc1"); // I cannot get parameter settings on the groups to work properly


// C O L U M N    O N E

    //Oscillator Speed
    cp5.addSlider("osc_speed")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row1)
      .setSize(sliderW, sliderH)
      .setRange(.05, 1)
      .setFont(font)
      .setColorValue(valueColor) // The number in the slider
      .setColorBackground(buttonBackground) // The black backgroun of slider, not visible bc of SCREEN blending mode
      .setColorForeground(buttonForeground) // Color of slider
      .setColorActive(activeColor) // Color when button/slider is clicked
      .setLabel("Oscillator Speed")
      .setSliderMode(Slider.FIX)
      .setValue(osc_speed)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Period
    cp5.addSlider("period")  
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row2)
      .setSize(sliderW, sliderH)
      .setRange(20, 1100)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Period Of Wave")
      .setSliderMode(Slider.FIX)
      .setValue(period)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Amplitude 
    cp5.addSlider("amplitude")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row3)
      .setSize(sliderW, sliderH)
      .setRange(.15, .99)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Amplitude")
      .setSliderMode(Slider.FIX)
      .setValue(amplitude)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Band Spacing
    cp5.addSlider("band_spacing")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col1, row4)
      .setSize(sliderW, sliderH)
      .setRange(440, 840)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Band Spacing")
      .setSliderMode(Slider.FIX)
      .setValue(band_spacing)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;


// C O L U M N    T W O

    //Modulo Effect
    cp5.addSlider("modulo_amt")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col2, row1)
      .setSize(sliderW, sliderH)
      .setRange(.1, 30)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Modulo Effect")
      .setSliderMode(Slider.FIX)
      .setValue(modulo_amt)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Filler Lines")
      .setSliderMode(Slider.FIX)
      .setValue(filler_lines)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Sine/Square
    cp5.addToggle("sine")
      .setGroup(osc1)
      .setPosition(col2+toggleBufferX, row3)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
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
      .setRange(300, 440)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setValue(squareWidth)
      .setLabel("Square Width")
      .setSliderMode(Slider.FIX)
      .setValue(squareWidth)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue Of Wave")
      .setSliderMode(Slider.FIX)
      .setValue(wave_hue)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Hue LFO On/Off
    cp5.addToggle("hueLFOSleep")
      .setGroup(osc1)
      .setPosition(col3+toggleBufferX, row2)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue LFO")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Hue LFO
    cp5.addSlider("lfo_amt")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col3, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 100)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue LFO Amt")
      .setSliderMode(Slider.FIX)
      .setValue(lfo_amt)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue LFO Speed")
      .setSliderMode(Slider.FIX)
      .setValue(lfo_speed)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;


// C O L U M N    F O U R

    // OSC1 Sleep
    cp5.addToggle("osc1Sleep")
      .setGroup(osc1)
      .setPosition(col4+toggleBufferX, row1)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setValue(osc1Sleep)
      .setLabel("Osc 1 On/Off")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Oscillator Direction
    cp5.addToggle("oscDir")
      .setGroup(osc1)
      .setPosition(col4+toggleBufferX, row2)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Period Dialation")
      .setSliderMode(Slider.FIX)
      .setValue(dialationScalar)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Frequency Modulation
    cp5.addSlider("mysteryModulation")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col4, row4)
      .setSize(sliderW, sliderH)
      .setRange(16, 700)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Time Warp")
      .setSliderMode(Slider.FIX)
      .setValue(mysteryModulation)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;
      

// C O L U M N   F I V E
    
     //Symmetry
    cp5.addToggle("symmetry")
      .setGroup(osc1)
      .setPosition(col5+toggleBufferX, row1)
      //.setValue(false)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Symmetry")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Push/Pull Toggle
    cp5.addToggle("pushPull")
      .setGroup(osc1)
      .setPosition(col5+toggleBufferX, row2)
      //.setValue(false)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Push/Pull")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    // Oscillator 1 Opacity
    cp5.addSlider("osc1_opacity")
      .setGroup(osc1)
      .setBroadcast(false)
      .setPosition(col5, row3)
      .setSize(sliderW, sliderH)
      .setRange(5, 255)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("OSC 1 Opacity")
      .setSliderMode(Slider.FIX)
      .setValue(osc1_opacity)
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
      .setRange(.05, .5)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Osc Speed 2")
      .setSliderMode(Slider.FIX)
      .setValue(osc_speed2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Period
    cp5.addSlider("period2")  
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col1, row2)
      .setSize(sliderW, sliderH)
      .setRange(40, 700)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Period")
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
      .setRange(50, 650)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Amplitude 2")
      .setSliderMode(Slider.FIX)
      .setValue(amplitude2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Band Spacing
    cp5.addSlider("band_spacing2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col1, row4)
      .setSize(sliderW, sliderH)
      .setRange(450, 1100)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Band Spacing 2")
      .setSliderMode(Slider.FIX)
      .setValue(band_spacing2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;


// C O L U M N    T W O

    //Modulo Effect
    cp5.addSlider("modulo_amt2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col2, row1)
      .setSize(sliderW, sliderH)
      .setRange(.1, 100)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Modulo Effect 2")
      .setSliderMode(Slider.FIX)
      .setValue(modulo_amt2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Filler Lines
    cp5.addSlider("filler_lines2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col2, row2)
      .setSize(sliderW, sliderH)
      .setRange(12, 6)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Filler Lines 2")
      .setSliderMode(Slider.FIX)
      .setValue(filler_lines2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Sine vs Square
    cp5.addToggle("sine2")
      .setGroup(osc2)
      .setPosition(col2+toggleBufferX, row3)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setValue(squareWidth2)
      .setLabel("Square Width 2")
      .setSliderMode(Slider.FIX)
      .setValue(squareWidth2)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue Of Wave 2")
      .setSliderMode(Slider.FIX)
      .setValue(wave_hue2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Hue LFO On/Off
    cp5.addToggle("hueLFOSleep2")
      .setGroup(osc2)
      .setPosition(col3+toggleBufferX, row2)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue LFO")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Hue LFO
    cp5.addSlider("lfo_amt2")
      .setGroup(osc2)
      .setBroadcast(false)
      .setPosition(col3, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 100)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Hue LFO Amt 2")
      .setSliderMode(Slider.FIX)
      .setValue(lfo_amt2)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("LFO Speed 2")
      .setSliderMode(Slider.FIX)
      .setValue(lfo_speed2)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;


// C O L U M N    F O U R

    //On/Off Switch
    cp5.addToggle("osc2Sleep")
      .setGroup(osc2)
      .setPosition(col4+toggleBufferX, row1)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Osc 2 On/Off")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Oscillator Direction
    cp5.addToggle("oscDir2")
      .setGroup(osc2)
      .setPosition(col4+toggleBufferX, row2)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
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
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Opacity")
      .setSliderMode(Slider.FIX)
      .setValue(osc2_opacity)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;



//MAIN CONTROLS GROUP / LAST MENU

    Group main = cp5.addGroup("main");
    

// C O L U M N    O N E

    //Background Hue
    cp5.addSlider("bgr_hue")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col1, row1)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Background Hue")
      .setSliderMode(Slider.FIX)
      .setValue(bgr_hue)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    //Background Brightness
    cp5.addSlider("bgr_val")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col1, row2)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Bgr Bright")
      .setSliderMode(Slider.FIX)
      .setValue(bgr_val)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

   //Background Saturation
    cp5.addSlider("bgr_sat")
      .setGroup(main)
      .setBroadcast(false)
      .setPosition(col1, row3)
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Bgr Saturation")
      .setSliderMode(Slider.FIX)
      .setValue(bgr_sat)
      .setBroadcast(true)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;

    // Invert Filter Mode
    cp5.addToggle("invertFilter")
      .setGroup(main)
      .setPosition(col1+toggleBufferX, row4)
      //.setValue(false)
      .setSize(toggleW, sliderH)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(buttonBackground)
      .setColorForeground(buttonForeground)
      .setColorActive(activeColor)
      .setLabel("Invert Filter")
      .setMode(ControlP5.SWITCH)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE)
      ;


// C O L U M N    T W O

    //Blend Modes - Scrollable List
    //These parameters are a little different in name
     cp5.addScrollableList("dropdown")
       .setGroup(main)
       .setBroadcast(false)
       .setPosition(col2 - (buttonWBuffer/2), row1-sliderH)
       .setSize(sliderW + buttonWBuffer, 200)
       .setFont(font)
       .setBackgroundColor(color(0,0,0))   // little lines in between elements and background i guess
       .setColorActive(color(0,0,0))   // the element when its clicked
       .setColorValue(color(0, 0, 255))    // text in drop down elements
       .setColorBackground(color(0,0,0) )   // color of the background of options, and display option
       .setColorLabel(color(0, 0, 0))   //text on main element
       .setColorForeground(color(0,0,220))   // background when hovering
       .setBarHeight(sliderH*2)
       .setItemHeight(sliderH*2)
       .setOpen(false)
       .setLabel(" ")
       .setBroadcast(true)
       .addItems(blendModeOptions)
      //.setType(ScrollableList.DROPDOWN) // currently supported DROPDOWN and LIST
       ;



    // C O L U M N    F I V E


    //Load Button
    cp5.addButton("loadPatch")
      .setGroup(main)
      .setPosition(col5, row1-sliderH)
      .setSize(sliderW, sliderH*2)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(color(0, 0, 255))
      .setColorForeground(color(0, 0, 220))
      .setColorActive(activeColor)
      .getCaptionLabel().setVisible(false)
      ;

    //Save Patch Button
    cp5.addButton("savePatch")
      .setGroup(main)
      .setPosition(col5, row2-sliderH)
      .setSize(sliderW, sliderH*2)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(color(0, 0, 255))
      .setColorForeground(color(0, 0, 220))
      .setColorActive(activeColor)
      .getCaptionLabel().setVisible(false)
      ;

    //Randomize Parameters
    cp5.addButton("randomize")
      .setGroup(main)
      .setPosition(col5, row3-sliderH)
      .setSize(sliderW, sliderH*2)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(color(0, 0, 255))
      .setColorForeground(color(0, 0, 220))
      .setColorActive(activeColor)
      .getCaptionLabel().setVisible(false)
      ;
    
    // Random Mode
    cp5.addButton("randomMode")
      .setGroup(main)
      .setPosition(col5, row4-sliderH)
      .setSize(sliderW, sliderH*2)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(color(0, 0, 255))
      .setColorForeground(color(0, 0, 220))
      .setColorActive(activeColor)
      .getCaptionLabel().setVisible(false)
      ;

    //Restore Default Button
    cp5.addButton("init")
      .setGroup(main)
      .setPosition(col5, row5-sliderH)
      .setSize(sliderW, sliderH*2)
      .setFont(font)
      .setColorValue(valueColor)
      .setColorBackground(color(0, 0, 255))
      .setColorForeground(color(0, 0, 220))
      .setColorActive(activeColor)
      .getCaptionLabel().setVisible(false)
      ;
}


        
  
// -----------------------------------------------------------

// SHOWING AND HIDING BUTTON GROUPS FOR EACH MENU

// -----------------------------------------------------------


  void toggle() {

    //Control Toggle Show/Hide
    if (controls == 1) {
      cp5.getGroup("osc1").show();
      cp5.getGroup("osc2").hide();
      cp5.getGroup("main").hide();
      current_control = "OSC1";
    }

    if (controls == 2) {
      cp5.getGroup("osc2").show();
      cp5.getGroup("osc1").hide();
      cp5.getGroup("main").hide();
      current_control = "OSC2";
    }
    if (controls == 3) {
      cp5.getGroup("main").show();
      cp5.getGroup("osc2").hide();
      cp5.getGroup("osc1").hide();
      current_control = "MAIN";
    }


    //Some loose ends:

    //Show/Hide Square Width Slider
    if (sine==true) {
      cp5.getController("squareWidth").hide();
    }

    if (sine==false && controls == 1) {
      cp5.getController("squareWidth").show();
    }

    if (sine2==true) {
      cp5.getController("squareWidth2").hide();
    }

    if (sine2==false && controls == 2) {
      cp5.getController("squareWidth2").show();
    }
    
    
    //Show/Hide Hue LFO Parameters
    if (hueLFOSleep == true){
      cp5.getController("lfo_amt").hide();
      cp5.getController("lfo_speed").hide();
    }else if (controls == 1){
      cp5.getController("lfo_amt").show();
      cp5.getController("lfo_speed").show();
    }
    
    if (hueLFOSleep2 == true){
      cp5.getController("lfo_amt2").hide();
      cp5.getController("lfo_speed2").hide();
    }else if (controls == 2){
      cp5.getController("lfo_amt2").show();
      cp5.getController("lfo_speed2").show();
    }

  }
  


  // -----------------------------------------------------------

  // DRAWING UI ELEMENTS OTHER THAN P5 SLIDERS/BUTTONS

  // -----------------------------------------------------------



  void drawUI() {

    blendMode(BLEND);

    //UI Background Rectangles
    fill(bgr_hue, bgr_sat, bgr_val);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width, topNavHeight); //Top Nav
    rect(0, height-uiHeight, width, height); //Bottom UI
    
    // Creat Elements for the dropdown menu here:
    // It needs to be up here because its behind the cp5 elements / needs to be drawn first
    if (controls==3) {
      //Rect behind drop down Title
      fill(0, 0, 255);
      rect(col2 - (buttonWBuffer/2), row1-sliderH, sliderW + buttonWBuffer, sliderH*2);
      fill(bgr_hue, bgr_sat, bgr_val); 
        }
        
        
        
    //This is where the CP5 Elements are actually drawn to the screen

    blendMode(SCREEN); // i had to go back to this bc i ran in to too many issues trying to remove black background from sliders
    cp5.draw(); 
    blendMode(BLEND);

    textFont(font);
    textSize(17);
    textAlign(CENTER, CENTER);
    fill(255);

    text(current_control, 144, 31); //Which menu youre currently on

    textAlign(LEFT, CENTER);
    
    if (backupFont == true) {
      textSize(20);
      text(recordPrompt, 950, 33);
      textSize(15);
    } else {
      text(recordPrompt, 950, 33);
    }

    noFill();
    stroke(255);
    strokeWeight(3);

    // Menu Toggle Box
    rect(28, 23, 70, 20);

    //Render Button Circle
    ellipse(width-40, 32, 23, 23);


    // Drawing the extra UI elements when toggling through menus
    // This needs some attention bc it could be the same for osc1 and 2 and should be associated with the slider objects somehow

    if (controls==1) {
      //Toggle Boxes
      rect(col2+toggleBufferX, row3, toggleW, sliderH); //Sine/Square
      rect(col3+toggleBufferX, row2, toggleW, sliderH); //LFO On/Off
      rect(col4+toggleBufferX, row1, toggleW, sliderH); //On/Off
      rect(col4+toggleBufferX, row2, toggleW, sliderH); //Wave Direction
      rect(col5+toggleBufferX, row1, toggleW , sliderH); //Symmetry 
      rect(col5+toggleBufferX, row2, toggleW , sliderH); //Push/Pull

      //Slider Boxes
      //Column 1
      rect(col1, row1, sliderW, sliderH);
      rect(col1, row2, sliderW, sliderH);
      rect(col1, row3, sliderW, sliderH);
      rect(col1, row4, sliderW, sliderH);
      
      //Column 2
      rect(col2  , row1, sliderW, sliderH);
      rect(col2  , row2, sliderW, sliderH);
      if (sine == false) {
        rect(col2  , row4, sliderW, sliderH);
      }
      
      //Column 3
      rect(col3, row1, sliderW, sliderH);
      if (hueLFOSleep == false){
        rect(col3, row3, sliderW, sliderH);
        rect(col3, row4, sliderW, sliderH);
      }

      //Column 4
      rect(col4, row3, sliderW, sliderH);
      rect(col4, row4, sliderW, sliderH);
      
    }

    if (controls==2) {
      //Toggle Boxes
      rect(col2+toggleBufferX, row3, toggleW, sliderH); // Sine/Square
      rect(col3+toggleBufferX, row2, toggleW, sliderH); //LFO On/Off
      rect(col4+toggleBufferX, row1, toggleW, sliderH); //On/Off
      rect(col4+toggleBufferX, row2, toggleW, sliderH); //Wave Direction

      //Slider Boxes
      //Column 1
      rect(col1, row1, sliderW, sliderH);
      rect(col1, row2, sliderW, sliderH);
      rect(col1, row3, sliderW, sliderH);
      rect(col1, row4, sliderW, sliderH);
      
      //Column 2
      rect(col2, row1, sliderW, sliderH);
      rect(col2, row2, sliderW, sliderH);
      if (sine2 == false) {
        rect(col2, row4, sliderW, sliderH);
      }

      // Column 3
      rect(col3, row1, sliderW, sliderH);
      //rect(col3, row2, sliderW, sliderH);
      if (hueLFOSleep2 == false){
        rect(col3, row3, sliderW, sliderH);
        rect(col3, row4, sliderW, sliderH);
      }

      // Column 4
      rect(col4, row3, sliderW, sliderH); //Opacity
    }


    if (controls==3) {
      
      //Toggle Boxes 
      rect(col1+toggleBufferX, row4, toggleW, sliderH); // Invert Filter
      

      //Slider Boxes
      //Column 1
      rect(col1, row1, sliderW, sliderH);
      rect(col1, row2, sliderW, sliderH);
      rect(col1, row3, sliderW, sliderH);
      
      //dropdown triangle
      push();
        stroke(bgr_hue, bgr_sat, bgr_val); //i made the triangle too small so its actually the stroke color that matters
        translate(486, 846);
        triangle(0, 0, 8, 0, 4, 6);
      pop();


      //Blending Modes
      if (type==0) {
        blendName = "SCREEN";
      } else if (type==1) {
        blendName = "ADD";
      } else if (type==2) {
        blendName = "SUBTRACT";
      } else if (type==3) {
        blendName = "LIGHTEST";
      } else if (type==4) {
        blendName = "Normal";
      }
       else {
        blendName = "SCREEN";
      }

      //BLEND MODE LABEL
      textAlign(CENTER, CENTER);
      textSize(14);
      blendMode(BLEND);
      fill(255);
      
      text("Blend Mode:", ui.col2+90, row4);
      text(blendName, ui.col2+90, row5);
      fill(bgr_hue, 255, bgr_val);
      text(dropdownTitle, (col2 + sliderW/2)-7, row1);
      

      //Column 4
      text("Load Patch", col5+(sliderW/2), row1);
      text("Save Patch", col5+(sliderW/2), row2);
      text("Randomize", col5+(sliderW/2), row3);
      text("Random Mode", col5+(sliderW/2), row4);
      text("Restore Default", col5+(sliderW/2), row5);
      

    }
    

  

    //TOP NAVIGATION

      textFont(titleFont);
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(255); //Title Font Color
      text(topTitle, width/2, 33);
  
      //Recording 
      textSize(17);
      if (recording == true) {
        recordPrompt = "Press to Stop"; 
        fill(255);
        ellipse(width-40, 32, 15, 15);
      }
      if (recording == false) {
        recordPrompt = "Press to Render";
      }
      
      
    // Other Modes and Options
      
      if(messageOnScreen == true){
        ui.displayMessage();
      }
      
      if(toolTipOn == true){
        ui.toolTip();
      }
      
      if(valueView==true){
      
          ui.showValueView();
      }
   
  }
  


  // -----------------------------------------------------------

  // UPDATING THE TITLE AFTER A PRESET IS LOADED IN

  // -----------------------------------------------------------


  void presetTitle(String loadedTitle) {
    topTitle = loadedTitle;
  }
  
  void defaultTitle() {
    topTitle = "OSC 99";
  }
  
  
  
// -----------------------------------------------------------

// DROPDOWN MENU - IDK IF I NEED THIS

// -----------------------------------------------------------

void dropdown() {
  /* request the selected item based on index n */
  //println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));
  //println(cp5.get(ScrollableList.class, "dropdown").toString());

  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */
  
  //CColor c = new CColor();
  //c.setBackground(color(255,0,0));
  //cp5.get(ScrollableList.class, "dropdown").getItem(n).put("text", c);
  
}


// -----------------------------------------------------------

// UPDATE UI VALUES

// -----------------------------------------------------------

  void updateValues(){
   //Update the slider values after they were changed by the program internally 
   cp5.getController("osc_speed").setValue(osc_speed);
   cp5.getController("osc1_opacity").setValue(osc1_opacity); 
   cp5.getController("period").setValue(period);
   cp5.getController("amplitude").setValue(amplitude);
   cp5.getController("band_spacing").setValue(band_spacing);
   
   cp5.getController("modulo_amt").setValue(modulo_amt);
   cp5.getController("filler_lines").setValue(filler_lines);
   cp5.getController("squareWidth").setValue(squareWidth);
   
   cp5.getController("wave_hue").setValue(wave_hue);
   cp5.getController("lfo_amt").setValue(lfo_amt);
   cp5.getController("lfo_speed").setValue(lfo_speed);
   
   cp5.getController("dialationScalar").setValue(dialationScalar);
   cp5.getController("mysteryModulation").setValue(mysteryModulation);
   
   cp5.getController("osc_speed2").setValue(osc_speed2);
   cp5.getController("osc2_opacity").setValue(osc2_opacity);
   cp5.getController("period2").setValue(period2);
   cp5.getController("amplitude2").setValue(amplitude2);
   cp5.getController("band_spacing2").setValue(band_spacing2);
   
   cp5.getController("modulo_amt2").setValue(modulo_amt2);
   cp5.getController("filler_lines2").setValue(filler_lines2);
   cp5.getController("squareWidth2").setValue(squareWidth2);
   
   cp5.getController("wave_hue2").setValue(wave_hue2);
   cp5.getController("lfo_amt2").setValue(lfo_amt2);
   cp5.getController("lfo_speed2").setValue(lfo_speed2);
   
   cp5.getController("bgr_hue").setValue(bgr_hue);
   cp5.getController("bgr_sat").setValue(bgr_sat);
   cp5.getController("bgr_val").setValue(bgr_val);
   
  }


  
// -----------------------------------------------------------

// TOOLTIPS WHEN HOVERING

// -----------------------------------------------------------

  void toolTip() {
    
    String tip;

    if (mousePressed == false) {
      if(controls == 1){
          if (cp5.getController("osc_speed").isMouseOver() == true) {
              if (mouseX == pmouseX&&mouseY == pmouseY){
                frameCounter = frameCounter+1;
              }
              else{
                frameCounter = 0;
              }
              if (frameCounter > 10){
                  tip = "Oscillator Speed";
                  displayTooltip(tip);
              }
            
          }
          if (cp5.getController("period").isMouseOver() == true) {
              if (mouseX == pmouseX&&mouseY == pmouseY){
                frameCounter = frameCounter+1;
              }
              else{
                frameCounter = 0;
              }
              if (frameCounter > 10){
                  tip = "How long before the wave repeats";
                  displayTooltip(tip);
              }
            
          }
          if (cp5.getController("amplitude").isMouseOver() == true) {
              if (mouseX == pmouseX&&mouseY == pmouseY){
                frameCounter = frameCounter+1;
              }
              else{
                frameCounter = 0;
              }
              if (frameCounter > 10){
                  tip = "Height of the Wave";
                  displayTooltip(tip);
              }
            
          }
      }
    }
    
  }
  
  void displayTooltip(String tip) {
    float rectW;
    float rectH;
    float boxMargin = 12;
    push();
      translate(mouseX+10, mouseY-30);
      textSize(15);
      rectW = textWidth(tip) + boxMargin;
      rectH = textAscent() + boxMargin; //textAscent is the height of the current font
      fill(0);
      noStroke();
      rect(0, 0, rectW, rectH); 
      fill(255);
      textAlign(CENTER);
      text(tip, rectW/2, 15);
    pop();


  }
  
  void messageContent(String message){
    
    if(message == "tooltip"){
      if(toolTipOn == true){
        content = "Tooltips: Off";
      }else{
        content = "Tooltips: On";
      }
    }
      
    if(message == "random"){
      if(randomModeOn == true){
        content = "Random Mode: Off";
      }else{
        content = "Random Mode: On";
      }
      messageOnScreen = true;
      frameCounter = 0;
    }
    if(message == "graph"){
      if(graph == true){
        content = "Graph Mode: Off";
      }else{
        content = "Graph Mode: On";
      }
      messageOnScreen = true;
      frameCounter = 0;
    }
 }

void displayMessage(){
  
  int margin = 25; 
  int TTL = 50; 
  
  if(frameCounter < TTL){
      rectMode(CENTER);
      noStroke();
      if(frameCounter > 10){
        float multiplier = frameCounter-10;
        int percetage = 255/TTL; 
        fill(255, 255-(multiplier*percetage));
      }
      
      rect(width/2, 200, textWidth(content) + margin, textAscent() + margin);
      fill(0);
      text(content, width/2, 200);
      frameCounter += 1; 
  }
  else{
    messageOnScreen = false;
  }
  
}
   
  
  void showValueView(){

      rectMode(CORNER);
      fill(0);
      rect(0, 0, width, height-uiHeight);
      fill(255);
      
      int i = 30;
      int space = 25;
      int column1 = 15; 
      int column2 = 330;
      int column3 = 645;
      
      textSize(16);
      textAlign(LEFT);

      text("osc1_sleep: " + osc1Sleep, column1, i);
      text("oscDir: " + oscDir, column1, i+=space);
      text("osc1_opacity: " + osc1_opacity, column1, i+=space);
      text("amplitude: " + amplitude, column1, i+=space);
      text("period: " + period, column1, i+=space);
      text("osc_speed: " + osc_speed, column1, i+=space);
      text("xspacing: " + xspacing, column1, i+=space);
      text("filler_lines: " + filler_lines, column1, i+=space);
      text("band_spacing: " + band_spacing, column1, i+=space);
      text("modulo_amt: " + modulo_amt, column1, i+=space);
      text("wave_hue: " + wave_hue, column1, i+=space);
      text("hueLFOSleep: " + hueLFOSleep, column1, i+=space);
      text("lfo_amt: " + lfo_amt, column1, i+=space);
      text("lfo_speed: " + lfo_speed, column1, i+=space);
      text("sine: " + sine, column1, i+=space);
      text("squareWidth: " + squareWidth, column1, i+=space);
      text("dialationSc: " + dialationScalar, column1, i+=space);
      text("mysteryMod: " + mysteryModulation, column1, i+=space);
      text("pushPull: " + pushPull, column1, i+=space);
      text("symmetry: " + symmetry, column1, i+=space);
      
      i = 30;
      text("osc2Sleep: " + osc2Sleep, column2, i);
      text("oscDir2: " + oscDir2, column2, i+=space);
      text("osc2_opacity: " + osc2_opacity, column2, i+=space);
      text("amplitude2: " + amplitude2, column2, i+=space);
      text("period2: " + period2, column2, i+=space);
      text("osc_speed2: " + osc_speed2, column2, i+=space);
      text("xspacing2: " + xspacing2, column2, i+=space);
      text("filler_lines2: " + filler_lines2, column2, i+=space);
      text("band_spacing2: " + band_spacing2, column2, i+=space);
      text("modulo_amt2: " + modulo_amt2, column2, i+=space);
      text("wave_hue2: " + wave_hue2, column2, i+=space);
      text("hueLFOSleep2: " + hueLFOSleep2, column2, i+=space);
      text("lfo_amt2: " + lfo_amt2, column2, i+=space);
      text("lfo_speed2: " + lfo_speed2, column2, i+=space);
      text("sine2: " + sine2, column2, i+=space);
      text("squareWidth2: " + squareWidth2, column2, i+=space);
      
      i = 30;
      text("blendType: " + blendType, column3, i);
      text("type: " + type, column3, i+=space);
      text("invertFilter: " + invertFilter, column3, i+=space);
      text("Random Mode: " + randomModeOn, column3, i+=space);
      text("Graph Mode: " + graph, column3, i+=space);
      text("bgr_hue: " + bgr_hue, column3, i+=space);
      text("bgr_sat: " + bgr_sat, column3, i+=space);
      text("bgr_val: " + bgr_val, column3, i+=space);
      
      textAlign(CENTER);
      text("Press V to Exit View Values Mode", width/2, (height-uiHeight) - 30);

  }
  


} //END OF CLASS BRACKET
