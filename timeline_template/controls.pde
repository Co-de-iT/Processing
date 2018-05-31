

void keyPressed() {
  if (key == '+') tLine.zoom(10);
  if (key == '-') tLine.zoom(-10);
  if (key == 'i') saveFrame("img/timeLine_####.png");
}

void mousePressed() {
  tLine.press();
  cursor(HAND);
}

void mouseReleased() {
  cursor(CROSS);
}

void mouseDragged() {
  tLine.drag();
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  tLine.zoom(e);
}
