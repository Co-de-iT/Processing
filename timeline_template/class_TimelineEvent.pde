class TimelineEvent {
  int year;
  String event;
  String description;
  color idle, highlight;

  TimelineEvent(int year, String event, String description, color idle, color highlight) {
    this.year = year;
    this.event = event;
    this.description = description;
    this.idle = idle;
    this.highlight = highlight;
  }

  TimelineEvent(int year, String event, String description) {
    this(year, event, description, color(100, 100), color(255, 0, 0));
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
      stroke(highlight);
      fill(highlight);
      text (year, x+25, y+170);
      text (description, x+25, y+190);
    } else {
      strokeWeight(0.5);
      stroke(idle);
      fill(idle);
    }
    line (x, y, x, y+150);
    line (x, y+150, x+20, y+150);

    text(event, x+25, y+150);
  }
}
