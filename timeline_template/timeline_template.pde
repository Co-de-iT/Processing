//import java.awt.event.*;
PFont font;
TimeLine tLine;
ArrayList<TimelineEvent> tEvents;
String fileName = "timeline.txt";
char token = ',';

int timeBegin = 100;
int timeEnd = year() + 1;
int timeFocus = 1900;//Point in timeline on which to center view
int minZoom = 4;
int maxZoom = 150;
int zoomLevel = 40;
float tScale = 400;


void setup() {

  //fullScreen();
  size(1400, 500);
  //font = loadFont("Bebas-24.vlw");
  smooth(8);

  // initialize timeline
  tLine = new TimeLine(timeBegin, timeEnd, timeFocus, minZoom, maxZoom, zoomLevel, tScale);

  // import events
  tLine.events = importEvents(fileName, token);

  cursor(CROSS);
}

void draw() {
  background(240);

  tLine.display();

}
