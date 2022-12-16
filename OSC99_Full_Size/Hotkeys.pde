
// -----------------------------------------------------------

// HOT KEYS

// -----------------------------------------------------------


void keyPressed() {

  //From the JSON save code, not sure what its doing
  if (key==ESC) {
    key=0; // kill Escape
  }
  
  switch(key) {
    case('r'):
    case('R'):
    recording = !recording;
    break;

    case('1'):
    controls=1;
    cp5.getController("controls").setValue(1);
    break;
    
    case('2'):
    controls=2;
    cp5.getController("controls").setValue(2);
    break;
    
    case('3'):
    controls=3;
    cp5.getController("controls").setValue(3);
    break;
    
    case('V'):
    case('v'):
    ui.valueView = !ui.valueView;
    break;
    
    case('T'):
    case('t'):
    tooltipMode();
    break;
    
    case('W'):
    case('w'):
    randomMode();
    break;
    
    case('G'):
    case('g'):
    graphMode();
    break;
  }
}
