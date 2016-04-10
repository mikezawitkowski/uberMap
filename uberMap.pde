/**
 * An application with a basic interactive map. You can zoom and pan the map.
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
AbstractMapProvider provider4;
AbstractMapProvider provider5;
AbstractMapProvider provider6;

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

  provider1 = new Microsoft.RoadProvider();
  provider2 = new OpenStreetMap.OpenStreetMapProvider();
  provider3 = new Microsoft.AerialProvider();
  provider4 = new StamenMapProvider.Toner();
  provider5 = new StamenMapProvider.WaterColor();
  provider6 = new Yahoo.RoadProvider();


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

void keyPressed() {
    if (key == '1') {
        map.mapDisplay.setProvider(provider1);
    } else if (key == '2') {
        map.mapDisplay.setProvider(provider2);
    } else if (key == '3') {
        map.mapDisplay.setProvider(provider3);
    } else if (key == '4') {
        map.mapDisplay.setProvider(provider4);
    } else if (key == '5') {
        map.mapDisplay.setProvider(provider5);
    } else if (key == '6') {
        map.mapDisplay.setProvider(provider6);
    }
}
