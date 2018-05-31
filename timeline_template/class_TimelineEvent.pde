class TimelineEvent {
  int year;
  String event;
  String description;

  TimelineEvent(int year, String event, String description) {
    this.year = year;
    this.event = event;
    this.description = description;
  }

  void display(float timeLen, int timeBegin, int timeEnd) {
    float x, y, mX, mY, t;

    t = tLine.yearStep*0.5;
    x = map(year, timeBegin, timeEnd, 0, timeLen)+t;
    y = 0;
    mX = mouseX-tLine.tX0;
    mY = mouseY-tLine.tY0;


    if (abs(mX-x) < 4*t && (mY-y)<200 && (mY-y)>-10) {
      strokeWeight(1);
      stroke(255, 0, 0);
      fill(255, 0, 0);
      text (year, x+25, y+170);
      text (description, x+25, y+190);
    } else {
      strokeWeight(0.5);
      stroke(200, 0, 0, 100);
      fill(200, 0, 0, 100);
    }
    line (x, y, x, y+150);
    line (x, y+150, x+20, y+150);

    text(event, x+25, y+150);
  }
}
