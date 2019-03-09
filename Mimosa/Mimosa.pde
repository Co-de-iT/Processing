/* 
 
 Based on Raven Kwok (aka Guo Ruiwen) Processing rewriting
 of the original idea and Cinder code by Robert Hodgin
 https://www.openprocessing.org/sketch/84094
 https://libcinder.org/docs/guides/tour/hello_cinder.html

 */

import processing.pdf.*;


ParticleSystem partSys;
boolean mouseDown, recordVid, savePdf;
PVector mouseLoc, mousePLoc, mouseVel;
PImage baseImg;

String imgName = "Zaha Hadid";
String extension = ".jpg";
String fileName;
color bgCol = #7F815A;

void setup() {
  size(900, 900, P2D);

  fileName = imgName + extension;

  baseImg = loadImage(fileName);

  baseImg.resize(width, height);
  //surface.setSize(pattern.width, pattern.height);

  partSys = new ParticleSystem();
  mouseLoc = new PVector(0, 0, 0);
  mousePLoc = new PVector(0, 0, 0);
  mouseVel = new PVector(0, 0, 0);

  recordVid = false;
  savePdf = false;
  
  stroke(255, 255, 0, 150);
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
  partSys.repel(5.0);
  partSys.update(baseImg);
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
    saveFrame("images/"+imgName+"_####.png");
  }
  if (key=='r'||key=='R') {
    recordVid = !recordVid;
  }

  if (key == 'p' || key == 'P')
    savePdf = true;

  if (key == 'f' || key == 'F')
  {
    saveFrame("images/"+imgName+"_####.png");
    savePdf = true;
  }
}
