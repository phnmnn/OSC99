# OSC99
An oscillator based generate visual synthesizer with UI written in Processing
<br/>
................................................................................................................................
<br/>
It is over the top messy right now. My next step is to clean it up. I didnt plan on spending so much time on it when I started.
I have never made anything near this big. 

In order to run it you have to download and install Processing and the ControlP5 library within it.
Processing is free and open source and can be downloaded here:
https://processing.org/
Once Processing is open install P5 by clicking on "Tools" and then "Add Tool."
Then click on "Libraries" and then search for "ControlP5."
<br/>
................................................................................................................................
<br/>
It uses sin wave values stored in an array to fill in the pixels accordingly. 

Naivagate the 3 menus by using the slider in the top left corner.
Try out the 'Randomize' parameter in the "Main" menu.

Because of how I used blending modes sometimes depending on the settings you choose the text and UI both go black.
It is still functional when this happens. Im working on fixing it. 

There should be a folder called "output" within the folder that you download, but idk how to get it to be on here.
This folder is where your exported frames will be saved. If you dont have one it should create it for you. 
Save frames by clicking the button in the top right corner.

Several of the paremeters are labled "empty" and just for temporary placement.

The "Patch" txt file is just there to eventually be a place to store the data for presets. 
The "Save Patch" button works right now but it only store 3 parameters and you cannot "Load Patch" them. 
Any of the code for this part is heavily borrowed from somewhere I cant remember at the moment. 
It seems to work but I'm waiting until things like variable names and the overall structure are more settled. 

The "Symmetry" and "Push/Pull" toggles only affect OSC1 and their logic is flipped from what it should be. For them (right = off) and (left == on).

<br/>
................................................................................................................................
<br/>

I was inspired to make this by Andrei Jay's WAAVES and Joel Kivelä's Cathodemer. 

WAAVES:
https://github.com/ex-zee-ex/WAAAVES

CATHODEMER is on Steam
