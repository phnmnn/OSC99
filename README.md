# OSC99
An oscillator based generated visual synthesizer with UI written in Processing
<hr>
I didnt plan on spending so much time on this when I started and I have never made anything near this big so any advice is appreciated.

In order to run it you have to download and install Processing and the ControlP5 library within it. I have not tried it on Processing 4 yet.
Processing is free and open source and can be downloaded here:
https://processing.org/
Once Processing is open install P5 by clicking on "Tools" and then "Add Tool."
Then click on "Libraries" and then search for "ControlP5."
<br/>
<hr>
<br/>
It uses sine wave values stored in an array to fill in the pixels accordingly. 

Naivagate the 3 menus by using the slider in the top left corner.
Try out the 'Randomize' button in the "Main" menu. Sometimes the screen will seem blank but just randomize again.

There should be a folder called "output" within the project folder (Processing Sketch) that you download, but idk how to get a blank folder on here.
This folder is where your exported/rendered frames will be saved. If you dont want to create it yourself it should create it for you once you actually render. 
Save frames by clicking the button in the top right corner.

You can save a preset by going to the "Main" menu you clicking "Save Patch". All the values for each parameter will be stored in a human readable json file. Click "Load Patch" and select a json file to load it in. The preset must be in the project folder in order to load.  
<br/>
<hr>
<ul>Hotkeys: </ul>
	<li>R - render/stop render</li>
	<li>1 - osc1 menu</li>
	<li>2 - osc2 menu</li>
	<li>3 - main menu</li>
	<li>T - toggle tooltips on/off</li>
	<li>W - random mode on/off</li>
	<li>V - view values mode</li>
	<li>G - view graph</li>

<hr>
<br/>


I was inspired to make this by Andrei Jay's WAAVES and Joel Kivelä's Cathodemer. 

WAAVES:
https://github.com/ex-zee-ex/WAAAVES

CATHODEMER is on Steam
