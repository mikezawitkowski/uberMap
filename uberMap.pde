/**
 * An application with a basic interactive map.
 * You can zoom and pan the map.
 * The map is populated with uber NYC data.
 * TODO: the circle needs a ton of work
 * TODO: Add in the data from the input/ folder
 * TODO: steal the shape of the earthquake circle
 * TODO: animate it like found on the processing page for "pulse"
 * TODO: add scrollbar https://processing.org/examples/scrollbar.html
 *
 */
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.mapdisplay.MapDisplayFactory;
import de.fhpotsdam.unfolding.marker.*;

UnfoldingMap map;
ArrayList<PVector> pastMouses;

SimplePointMarker diabloMarker;
SimplePointMarker sfoMarker;
SimplePointMarker nycMarker;

AbstractMapProvider provider1;
AbstractMapProvider provider2;
AbstractMapProvider provider3;

int MAX_PULSES = 1000; // max number of events on-screen
int numPulses = 0; // initial number of events on-screen

Pulse pulses[] = new Pulse[MAX_PULSES]; // pulse array

// int circleSize = 0;
// int num = 60;
// float mx[] = new float[num];
// float my[] = new float[num];


void setup() {

  size(800, 600, P2D);

  // Info about the cirlce I'll be adding
  // ellipseMode(CENTER);
  // frameRate(30);
  // noStroke();
  // background(220, 220, 255);
  // fill(255, 0, 255);
  // fill(255, 50);
  smooth();

  // Ability to change the map background
  provider1 = new Microsoft.RoadProvider();
  provider2 = new OpenStreetMap.OpenStreetMapProvider();
  provider3 = new Microsoft.AerialProvider();

  map = new UnfoldingMap(this, provider2);
  map.zoomAndPanTo(new Location(37.87f, -122.07f), 5);
  MapUtils.createDefaultEventDispatcher(this, map);

  Location diabloLocation = new Location(37.87f, -122.07f);
  diabloMarker = new SimplePointMarker(diabloLocation);
  Location sfoLocation = new Location(37.61f, -122.37f);
  sfoMarker = new SimplePointMarker(sfoLocation);
  Location nycLocation = new Location(40.7586f, -73.9706f);
  nycMarker = new SimplePointMarker(nycLocation);

  pastMouses = new ArrayList<PVector>();
}

void draw() {
  map.draw();

  ScreenPosition diabloPos = diabloMarker.getScreenPosition(map);
  strokeWeight(5);
  // stroke(67, 211, 227, 100);
  stroke(178, 34, 34, 200); // Red
  noFill();
  ellipse(diabloPos.x, diabloPos.y, 16, 16); // was 36. 36

  ScreenPosition nycPos = nycMarker.getScreenPosition(map);
  strokeWeight(3);
  // stroke(67, 211, 227, 100);
  stroke(178, 34, 34, 100); // Red
  noFill();
  ellipse(nycPos.x, nycPos.y, 26, 26); // was 36. 36


  ScreenPosition sfoPos = sfoMarker.getScreenPosition(map);
  strokeWeight(5);
  // stroke(67, 211, 227, 100);
  stroke(178, 34, 34, 50); // Red
  noFill();
  ellipse(sfoPos.x, sfoPos.y, 36, 36); // was 36. 36

  // map.addMarkers(diabloMarker);

  // Adapt style
  // diabloMarker.setColor(color(255, 0, 0, 100));
  // diabloMarker.setStrokeColor(color(255, 0, 0));
  // diabloMarker.setStrokeWeight(1);

  // Animate the circle
  // if (circleSize <= 100) {
  //     circleSize += 3;
  // }
  // ellipse(width/2, height/2, circleSize, circleSize);

  // more circle animation stuff
  // Cycle through the array, using a different entry on each frame.
  // Using modulo (%) like this is faster than moving all the values over.
  // int which = frameCount % num;
  // mx[which] = mouseX;
  // my[which] = mouseY;
  //
  // for (int i = 0; i < num; i++) {
  //   // which+1 is the smallest (the oldest in the array)
  //   int index = (which+1 + i) % num;
  //   ellipse(mx[index], my[index], i, i);
  //   tint(255, 127);
  // }
  //
  // Mouse shows the location coordinates
  Location location = map.getLocation(mouseX, mouseY);
  fill(0);
  text(location.getLat() + ", " + location.getLon(), mouseX, mouseY);

  for (int i=0; i < numPulses; i++) { // for all of the pulses that exist
    pulses[i].draw(); // draw ALL THE PULSES!!!!1
  }

}

// void keyPressed() {
//     if (key == '1') {
//         map.mapDisplay.setProvider(provider1);
//     } else if (key == '2') {
//         map.mapDisplay.setProvider(provider2);
//     } else if (key == '3') {
//         map.mapDisplay.setProvider(provider3);
//     }
// }


void mousePressed() { // on left click
  addPulse(mouseX, mouseY); // add another pulse
}

// void mouseDragged() { // when the mouse is moved
//   addPulse(mouseX, mouseY); // place another pulse at the mouse coords
// }

void keyPressed() { // when a key is pressed
  if (key == 32) {  // if it is the space bar
    numPulses = 0; // clear the screen
  }
}

void addPulse(int newX, int newY) { // new function to add pulse to the screen
  if (numPulses < MAX_PULSES) { // if we have not reached our limit
    pulses[numPulses] = new Pulse(newX, newY); // set a new pulse in the array
    numPulses++; // increase our numPulses variable by one
  }
}

class Pulse {
  float SCALE = random(10,40); // random size from 10-40px in diameter
  int x;    // x-coordinate of the pulse
  int y;    // y-coordinate of the pulse
  float s;  // size of the pulse

  Pulse(int pulseX, int pulseY) { // set the initial pulse variables
    x = pulseX; // set the y-coordinate of the pulse to the determined mouse location
    y = pulseY; // same for x
    s = 0; // reset the size
  }

  void draw() { // this actually draws the pulse ellipse shapes
    fill(random(200,255),random(200,255),random(200,255),random(255)); // random color
    // ellipse(x, y, sin(s)*SCALE+random(10), sin(s)*SCALE+random(10)); // draw the ellipse, randomize the H and W a little and make it all wibbly wobbly!
    ellipse(x, y, sin(s)*SCALE+random(2), sin(s)*SCALE+random(2)); // draw the ellipse, randomize the H and W a little and make it all wibbly wobbly!
    // s += random(0.05); // determine the speed of the pulse based on how much the size changes each frame
    s += random(0.01);

  }
}
