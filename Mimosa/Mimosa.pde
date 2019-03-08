/* 
 
 Based on Raven Kwok (aka Guo Ruiwen) Processing rewriting
 of the original idea and Cinder code by Robert Hodgin

 */

import processing.pdf.*;


ParticleSystem partSys;
boolean mouseDown, recordVid, savePdf;
PVector mouseLoc, mousePLoc, mouseVel;
PImage pattern;

String imgName = "Zaha Hadid";
String extension = ".jpg";
String fileName;
color bgCol = #7F815A; //#99AF58;

void setup() {
  size(900, 900, P2D);

  stroke(255, 255, 0, 150);

  fileName = imgName + extension;

  pattern = loadImage(fileName);

  pattern.resize(width, height);
  //surface.setSize(pattern.width, pattern.height);

  partSys = new ParticleSystem();
  mouseLoc = new PVector(0, 0, 0);
  mousePLoc = new PVector(0, 0, 0);
  mouseVel = new PVector(0, 0, 0);

  recordVid = false;
  savePdf = false;
}

void draw() {
  if (savePdf)
  {
    beginRecord(PDF, imgName + "_####.pdf");
    background(bgCol);
    stroke(255, 255, 0, 150);
  } else
  {
    background(bgCol);
    blendMode(ADD);
  }



  if (mouseDown) partSys.addParticles(10, mouseLoc, mouseVel);
  partSys.containment();
  partSys.repel();
  partSys.update(pattern);

  partSys.display();
  if (savePdf)
  {
    endRecord();
    savePdf = false;
  }
  if (recordVid) saveFrame("video_"+ imgName + "/"+ imgName +"_####.jpg");
}

void mouseDragged() {
  mouseMoved();
}

void mousePressed() {
  mouseDown = true;
}

void mouseReleased() {
  mouseDown = false;
}

void mouseMoved() {
  mousePLoc.set(pmouseX, pmouseY, 0);
  mouseLoc.set(mouseX, mouseY, 0);
  mouseVel = PVector.sub(mouseLoc, mousePLoc);
}

void keyPressed() {
  if (key=='i'|| key=='I') {
    saveFrame("images/2019 assistants/"+imgName+"_####.png");
  }
  if (key=='r'||key=='R') {
    recordVid = !recordVid;
  }

  if (key == 'p' || key == 'P')
    savePdf = true;

  if (key == 'f' || key == 'F')
  {
    saveFrame("images/2019 assistants/"+imgName+"_####.png");
    savePdf = true;
  }
}
