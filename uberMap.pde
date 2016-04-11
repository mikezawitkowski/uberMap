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
AbstractMapProvider provider1;
AbstractMapProvider provider2;
AbstractMapProvider provider3;

int circleSize = 0;


void setup() {
  size(800, 600, P2D);

  // Info about the cirlce I'll be adding
  ellipseMode(CENTER);
  frameRate(1);
  noStroke();
  background(220, 220, 255);
  fill(255, 0, 255);
  smooth();

  // Ability to change the map background
  provider1 = new Microsoft.RoadProvider();
  provider2 = new OpenStreetMap.OpenStreetMapProvider();
  provider3 = new Microsoft.AerialProvider();


  // map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
  map = new UnfoldingMap(this, provider5);
  // map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  map.zoomAndPanTo(new Location(37.87f, -122.07f), 10);

  MapUtils.createDefaultEventDispatcher(this, map);
}

void draw() {
  map.draw();

  Location mapLocation1 = new Location(37.87f, -122.07f);

  // Create point markers for locations
  SimplePointMarker mapMarker1 = new SimplePointMarker(mapLocation1);
  map.addMarkers(mapMarker1);

  // Animate the circle
  if (circleSize <= 100) {
      circleSize += 1;
  }
  ellipse(width/2, height/2, circleSize, circleSize);

  // Mouse shows the location coordinates
  Location location = map.getLocation(mouseX, mouseY);
  fill(0);
  text(location.getLat() + ", " + location.getLon(), mouseX, mouseY);
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
