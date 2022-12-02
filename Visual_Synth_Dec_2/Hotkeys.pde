
// -----------------------------------------------------------

// HOT KEYS

// -----------------------------------------------------------


void keyPressed() {

  // If we press r, start or stop recording!
  if (key == 'r' || key == 'R') {
    recording = !recording;
  }
  //OSC1 Menu / First Menu
  if (key == '1') {
    controls=1;
  }
  //Osc 2 Menu
  if (key == '2') {
    controls=2;
  }
  //Main Menu - Last Menu
  if (key == '3') {
    controls=3;
  }

  //From the JSON save code
  if (key==ESC) {
    key=0; // kill Escape
  }
}
