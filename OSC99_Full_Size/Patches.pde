
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

      //Where it saves the current values of parameters that the user can change
      String[] cur_values = { str(osc1Sleep), str(oscDir), str(osc1_opacity), str(amplitude), str(period), str(osc_speed), str(xspacing), str(filler_lines), str(band_spacing), str(modulo_amt),
        str(wave_hue), str(hueLFOSleep), str(lfo_amt), str(lfo_speed), str(sine), str(squareWidth), str(dialationScalar), str(freqMod), str(mysteryModulation), str(pushPull), str(symmetry), str(osc2Sleep), str(oscDir2), str(osc2_opacity), 
        str(amplitude2), str(period2), str(osc_speed2), str(xspacing2), str(filler_lines2), str(band_spacing2), str(modulo_amt2), str(wave_hue2), str(hueLFOSleep2), str(lfo_amt2), str(lfo_speed2), str(sine2), str(squareWidth2), 
        str(blendType), str(type), str(invertFilter), str(bgr_hue), str(bgr_sat), str(bgr_val) };

      JSONArray values = new JSONArray();
      
      for (int i = 0; i < parameter.length; i++) {
    
        JSONObject states = new JSONObject();
    
        states.setInt("id", i);
        states.setString("parameter", parameter[i]);
        states.setString("cur_value", cur_values[i]);
    
        values.setJSONObject(i, states);
      }
      
      json.setJSONArray("states", values);
      

   //This was in draw() previously:
   
   outputJSONArray(json, "states");
   
   //Save
    String fileString = dataPath("") + "\\*.json" ;
    println(fileString);
    File toSave = new File( fileString ) ;
    selectOutput("Save to a file:", "fileSelectedForSave", toSave);
}


public void loadValues(JSONArray States, String fileTitle){
  
      String[] paraValues = new String[States.size()]; 
      int listSize = States.size();
      
      println(States);
      
      for(int ob = 0; ob < listSize; ob++){
        JSONObject para = States.getJSONObject(ob);
        paraValues[ob] = para.getString("cur_value");
      }
      
      String titleNoExt = fileTitle.substring(0, fileTitle.lastIndexOf('.'));
      ui.presetTitle(titleNoExt); 
     
      println(paraValues.length);
      
      //I NEED A SMARTER WAY OF DOING THIS
      
      int p = 0;
      
      osc1Sleep = boolean(paraValues[p]);
      oscDir = boolean(paraValues[p+=1]);
      osc1_opacity = int(paraValues[p+=1]);
      amplitude = float(paraValues[p+=1]);
      period = float(paraValues[p+=1]);
      osc_speed = float(paraValues[p+=1]);
      xspacing = int(paraValues[p+=1]);
      filler_lines = int(paraValues[p+=1]);
      band_spacing = int(paraValues[p+=1]);
      modulo_amt = float(paraValues[p+=1]);
      wave_hue = int(paraValues[p+=1]);
      hueLFOSleep = boolean(paraValues[p+=1]);
      lfo_amt = float(paraValues[p+=1]); 
      lfo_speed = float(paraValues[p+=1]); 
      sine = boolean(paraValues[p+=1]);
      squareWidth = int(paraValues[p+=1]);
      dialationScalar = float(paraValues[p+=1]);
      freqMod = float(paraValues[p+=1]);
      mysteryModulation = float(paraValues[p+=1]);
      pushPull = boolean(paraValues[p+=1]);
      symmetry = boolean(paraValues[p+=1]);
        
      osc2Sleep = boolean(paraValues[p+=1]);
      oscDir2 = boolean(paraValues[p+=1]);
      osc2_opacity = int(paraValues[p+=1]); 
      amplitude2 = float(paraValues[p+=1]); 
      period2 = float(paraValues[p+=1]); 
      osc_speed2 = float(paraValues[p+=1]);
      xspacing2 = int(paraValues[p+=1]);
      filler_lines2 = int(paraValues[p+=1]);
      band_spacing2 = int(paraValues[p+=1]);
      modulo_amt2 = float(paraValues[p+=1]);
      wave_hue2 = int(paraValues[p+=1]);
      hueLFOSleep2 = boolean(paraValues[p+=1]);
      lfo_amt2 = float(paraValues[p+=1]);
      lfo_speed2 = float(paraValues[p+=1]);
      sine2 = boolean(paraValues[p+=1]);
      squareWidth2 = int(paraValues[p+=1]);
        
      blendType = int(paraValues[p+=1]);
      type = int(paraValues[p+=1]);
      invertFilter = boolean(paraValues[p+=1]);
      bgr_hue = int(paraValues[p+=1]);
      bgr_sat = int(paraValues[p+=1]);
      bgr_val = int(paraValues[p+=1]);
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

      //initBeforeLoad(); //just to make sure everthing is in order and account for the new parameters missing from the old presets
 
      loadValues(jsonStates, fileNameForScreen);
      
      ui.updateValues();
      ui.drawUI();
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
  }

  JSONArray valuesLoaded =  json.getJSONArray(nameOfJSONArray);

  // error check II. 
  if (valuesLoaded==null) { 
          
    println("No json array named "
      + nameOfJSONArray
      + " in json object.");
    return;
  }

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
