
// -----------------------------------------------------------

// Saving and Loading Patches with JSON files

// -----------------------------------------------------------




public void loadPatch(){
  
    //Load
    String fileString = dataPath("") + "\\" +"*.json" ;
    println(fileString);
    File toLoad = new File( fileString ) ;
    selectInput("Load a file:", "fileSelectedForLoad", toLoad);

   
}

public void savePatch(){
  
   
       //This was in setup()
       json = new JSONObject();

      String[] parameter = { "Theta", "Amplitude", "AmpAndrei", "Period", "Osc 1 Speed", "Filler Lines", "Mod Amt", "Mod Direction", "Line Amount", "Wave Hue", "New Hue", "Background Hue",
                               "Hue Change", "Wave Hue LFO", "Direction", "Background Value", "LFO Speed", "Sine", "SquareWidth", "Blend Type", "Type", "OSC 2 Sleep", "Controls", "Osc 1 Sleep", 
                             "Band Spacing", "Osc Direction", "Dialation Scalar", "Frequency Modulation", "Push/Pull", "Symmetry", "Mystery Modulation", "Theta 2", "Amplitude 2", "Period 2", "Osc 2 Speed", 
                             "Filler Lines 2", "Mod Amount 2", "Mod Direction 2", "Line Amount 2", "Wave Hue 2", "New Hue 2", "Empty", "Hue Change", "Wave Hue LFO 2", "Direction 2", 
                              "Empty", "LFO Speed 2", "Sine 2", "Square Width 2", "OSC 2 Opacity", "Band Spacing 2", "OSC 2 Direction", "XSpacing"};
      String[] cur_values   = { str(theta), str(amplitude), str(ampAndrei), str(period), str(osc_speed), str(filler_lines), str(modAmt), str(modDir), str(line_amt), str(wave_hue), str(new_hue), str(bgr_hue),
                                str(hue_change), str(wavehueLFO), str(dir), str(bgr_val), str(lfo_speed), str(sine), str(squareWidth), str(blendType), str(type), str(osc2Sleep), str(controls), str(osc1Sleep), 
                                str(band_spacing), str(oscDir), str(dialationScalar), str(freqMod), str(pushPull), str(symmetry), str(mysteryModulation), str(theta2), str(amplitude2), str(period2), str(osc_speed2),
                                str(filler_lines2), str(modAmt2), str(modDir2), str(line_amt2), str(wave_hue2), str(new_hue2), str(emptyVar), str(hue_change2), str(wavehueLFO2), str(dir2), str(emptyVar), str(lfo_speed2), 
                                str(sine2), str(squareWidth2), str(osc2_opacity), str(band_spacing2), str(oscDir2), str(xspacing)};
      
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


public void loadValues(JSONArray States, String fileTitle){
  
      println(States.size());
      
      String[] paraValues = new String[States.size()]; 
      int listSize = States.size();
      
      for(int ob = 0; ob < listSize; ob++){
        JSONObject para = States.getJSONObject(ob);
        paraValues[ob] = para.getString("cur_value");
        
        
        
      }
      
      String titleNoExt = fileTitle.substring(0, fileTitle.lastIndexOf('.'));
      ui.presetTitle(titleNoExt); 
      
      
      println(paraValues);
      println(paraValues.length);
      
      //I NEED A SMARTER WAY OF DOING THIS
      //THIS IS WHERE THE VARIABLE VALUES FROM THE JSON GET UPDATED
      
      theta = float(paraValues[0]);
      amplitude = float(paraValues[1]);
      ampAndrei = float(paraValues[2]);
      period = float(paraValues[3]);
      
      osc_speed = float(paraValues[4]);
  
       filler_lines = int(paraValues[5]);
       modAmt = float(paraValues[6]);
       modDir = boolean(paraValues[7]);
      
       line_amt = int(paraValues[8]);
      
       wave_hue = int(paraValues[9]);
      
       new_hue = float(paraValues[10]);
       bgr_hue = int(paraValues[11]);
       
       hue_change = float(paraValues[12]);
       wavehueLFO = float(paraValues[13]);
       dir = boolean(paraValues[14]);
      
       bgr_val = int(paraValues[15]);
       lfo_speed = float(paraValues[16]);
      
       sine = boolean(paraValues[17]);
       squareWidth = int(paraValues[18]);
    
       blendType = int(paraValues[19]);
       type = int(paraValues[20]);
      
       osc2Sleep = boolean(paraValues[21]);
      
      
       controls = int(paraValues[22]);
       
      
       osc1Sleep = boolean(paraValues[23]);
      
       band_spacing = int(paraValues[24]);
      
       oscDir = boolean(paraValues[25]);
      
       dialationScalar = float(paraValues[26]);
       
       freqMod = float(paraValues[27]);
      
       pushPull = boolean(paraValues[28]);
      
       symmetry = boolean(paraValues[29]);
       
       mysteryModulation = float(paraValues[30]);
       
       
       
       
       
       theta2 = float(paraValues[31]); 
       amplitude2 = float(paraValues[32]); 
       period2 = float(paraValues[33]);
       
       osc_speed2 = float(paraValues[34]);
      
       filler_lines2 = int(paraValues[35]);
       modAmt2 = float(paraValues[36]);
       modDir2 = boolean(paraValues[37]);
      
       line_amt2 = int(paraValues[38]);
      
       wave_hue2 = int(paraValues[39]);
      
       new_hue2 = float(paraValues[40]);
       emptyVar = int(paraValues[41]);
       
       hue_change2 = float(paraValues[42]);
       wavehueLFO2 = float(paraValues[43]);
       dir2 = boolean(paraValues[44]);
      
       emptyVar = int(paraValues[45]);
       lfo_speed2 = float(paraValues[46]);
      
       sine2 = boolean(paraValues[47]);
       squareWidth2 = int(paraValues[48]);
      
       osc2_opacity = int(paraValues[49]);
      
       band_spacing2 = int(paraValues[50]);
      
       oscDir2 = boolean(paraValues[51]);
       
       if (paraValues.length >= 53){
         xspacing = int(paraValues[52]);
         
       }

}




void fileSelectedForLoad(File selection) {
  File loading;
  loading = selection;
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else { 
    println("User loaded " + selection.getAbsolutePath());
    println("test"); 
    if (loading  != null) { 
      json =  loadJSONObject(loading.getAbsolutePath());
      fileNameForScreen=loading.getName();//https://docs.oracle.com/javase/7/docs/api/java/io/File.html
      
      
      JSONObject loadedPatch;
      loadedPatch = loadJSONObject(fileNameForScreen);
      
      JSONArray jsonStates = json.getJSONArray("states");


      

      
      loadValues(jsonStates, fileNameForScreen);
    }
  }
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
