# OSC99
An oscillator based generative visual synthesizer with UI written in Processing
<hr>

![osc1](https://user-images.githubusercontent.com/32662359/208203458-a127ff38-2c64-4f7c-98b6-3da79e943073.png)
<hr>


I didnt plan on spending so much time on this when I started and I have never made anything near this big so any advice is appreciated.

In order to run it you have to download and install Processing and the ControlP5 library within it. I have not tried it on Processing 4 yet.
Processing is free and open source and can be downloaded here:
https://processing.org/
Once Processing is open install ControlP5 by clicking on "Tools" and then "Add Tool."
Then click on "Libraries" and then search for "ControlP5."
Finally just double click on any of the processing files in the sketch folder and then click the play button. 
Once the sketch is running, click and drag the sliders to start changing the output. 
<br/>
<hr>
<br/>
Essentially it uses sine wave values stored in an array to fill in pixels accordingly. 

Naivagate the 3 menus by using the slider in the top left corner. The 3 menus are "OSC1", "OSC2", and "Main".

Try out the 'Randomize' button in the "Main" menu. Sometimes the screen will seem blank but just randomize again.

There should be a folder called "output" within the project folder (Processing Sketch) that you download, but idk how to get a blank folder on here.
This folder is where your exported/rendered frames will be saved. If you dont want to create it yourself it should create it for you once you actually render. Save frames by clicking the button in the top right corner. The output will be a PNG of each frame, you can use Adobe After Effects or ffmpeg to convert them to video format. 

You can save a preset by going to the "Main" menu you clicking "Save Patch". All the values for each parameter will be stored in a human readable json file. Click "Load Patch" and select a json file to load it in. The preset must be in the project folder in order to load.  

By default the first oscillator is running and the second one is off. The default blending mode is "Screen" and can be changed in the main menu. There are many other parameters to adjust. Clicking the randomize button has yielded some suprising results for me so far. The "Random Mode" button (hotkey W) is different from randomizing. It chooses a random parameter once every second and asigns it a random value, so the output is always changing. Press "V" to view the values of all the sliders. Press "G" to see the graph that osc1 is based on. There are tooltips whenever you hover over a slider/button but they are not added for all the sliders yet. 
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


<hr>

![osc99_default](https://user-images.githubusercontent.com/32662359/208203596-cae7057b-8972-4e68-abf7-69f63c9d1f58.png)

![oscMain](https://user-images.githubusercontent.com/32662359/208203935-28dc0849-3abf-4ed7-b158-3c0d237f985b.png)

![osc99_red](https://user-images.githubusercontent.com/32662359/208203946-40fc876e-8b8e-4b48-9159-87564af9b96d.png)







