class TimeLine {
  ArrayList<TimelineEvent> events;

  int timeBegin;
  int timeEnd;
  int timeFocus;//Point in timeline on which to center view
  int zoomLevel;
  int minZoom;
  int maxZoom;
  float tScale;
  float zoomFactor; // % of zoom (0 = nearest, 1 = farthest)

  float timeSpan, timeLen, yearStep; // timeline span, timeline Lenght and year step in screen units
  float tX0; // start x coordinate for timeline
  float tY0;
  float timePos;

  float edgeMargin = 50; // edge empty margin when reaching min or max extreme
  float scaleMargin = 20; // line overshoot
  int yearHighlight = 10;
  int upTick = 60;
  int tickDiff = 50;
  float yearTick;

  //Mouse Dragging
  float mDifX = 0.0; // differential in X for mouse dragging
  // float   mDifY = 0f;

  TimeLine(int timeBegin, int timeEnd, int timeFocus, int minZoom, int maxZoom, int zoomLevel, float tScale) {
    this.timeBegin = timeBegin;
    this.timeEnd = timeEnd;
    this.timeFocus = timeFocus;
    this.minZoom = minZoom;
    this.maxZoom = maxZoom;
    this.zoomLevel = zoomLevel;
    this.tScale = tScale;

    zoomFactor = (maxZoom - zoomLevel)/( float)(maxZoom-minZoom);
    timeSpan = timeEnd-timeBegin; // calculate timeline span
    timeLen = tScale * zoomLevel;   // calculate timeline Length
    yearStep = timeLen / timeSpan; // calculate year Step

    // position time on the timeline current length
    timePos = map(timeFocus, timeBegin, timeEnd, 0, timeLen);

    // center timeFocus on screen center (at the beginning of the sketch)
    tX0 = 0.5 * width - timePos;
    tY0 = 0.5 * height;

    events = new ArrayList<TimelineEvent>();
  }

  void press() {
    mDifX = mouseX - tX0;
    //mDifY = mouseY - mY;
  }

  void drag() {
    tX0 = mouseX - mDifX;
    //tY0 = mouseY - mDifY;
  }

  void zoom(int factor) {
    float currPos = (mouseX-tX0)/timeLen; // curent normalized position (0-1)

    zoomLevel += factor;
    zoomLevel = constrain(zoomLevel, minZoom, maxZoom);
    zoomFactor = (maxZoom - zoomLevel)/( float)(maxZoom-minZoom); // update zoomFactor

    // update timeLen and current zoom position
    timeLen = tScale * zoomLevel;
    yearStep = timeLen / timeSpan; // update year Step
    tX0 = mouseX - timeLen * currPos;
  }


  void display() {
    tX0 = constrain(tX0, -timeLen + width - edgeMargin, edgeMargin);
    pushMatrix();
    translate (tX0, tY0);

    strokeWeight(1);
    stroke(100);
    line(-scaleMargin, 0, timeLen + scaleMargin, 0); // horizontal line
    //line (width *0.5, 0, width *0.5, height); // central vertical line


    for (int i = 0; i < timeSpan; i++) {
      yearTick = i * yearStep;

      if (zoomLevel < 10) yearHighlight = 100;
      else if (zoomLevel < 20) yearHighlight = 50;
      else if (zoomLevel < 40) yearHighlight = 20;
      else if (zoomLevel < 80) yearHighlight = 10;
      else if (zoomLevel < 120) yearHighlight = 5;
      else yearHighlight = 1;

      if (i % yearHighlight == 0) {//Every xx years draw a bold line

        textAlign(LEFT);
        //textFont(font);

        pushMatrix();
        rotate(HALF_PI);

        if (yearHighlight == 1 && i%5 !=0) {
          stroke(160, 100);
          strokeWeight(.5);
          fill (180 + (maxZoom - zoomLevel)*2);
        } else 
        {
          stroke(80, 100);
          strokeWeight(1);
          fill(100);
        }

        text(timeBegin + i, upTick*1.1, -yearTick);
        popMatrix();

        line(yearTick, - upTick, yearTick, upTick);
      } else { //non-text line
        stroke(160, 100);
        strokeWeight(.5);
        //upTick = 50;
        line(yearTick, - upTick+tickDiff*zoomFactor, yearTick, upTick-tickDiff*zoomFactor);
      }
    }

    // draw events
    for (TimelineEvent e : events) {
      e.display(timeLen, timeBegin, timeEnd);
    }

    // println ("yh", yearHighlight, "zl", zoomLevel); // visual check fo zoom levels and year highlight
    popMatrix();
  }
}
