class ParticleSystem {
  ArrayList <Particle> particles;
  int initialRandMag = 5;

  ParticleSystem() {
    particles = new ArrayList <Particle>();
  }

  void addParticles(int amt, PVector mouseLoc, PVector mouseVel) {
    for (int i=0; i<amt; i++) {
      float randRadiansLoc = random(2*PI);
      PVector initLocOffset = new PVector(cos(randRadiansLoc)*5, sin(randRadiansLoc)*5);
      // float randRadiansVel = random(2*PI);
      float randMagVel = random(1, 5);
      PVector initVelOffset = new PVector(cos(randRadiansLoc)*randMagVel, sin(randRadiansLoc)*randMagVel);

      PVector initLoc = PVector.add(initLocOffset, mouseLoc);
      PVector initVel = PVector.add(initVelOffset, mouseVel);

      Particle additionalParticle = new Particle(initLoc, initVel);
      particles.add(additionalParticle);
    }
  }

  void containment() {

    for (int i=0; i<particles.size(); i++) {
      Particle tPar = particles.get(i);
      float thres = 10;
      if (tPar.loc.x <= thres || tPar.loc.x >= width-thres) {
        if (tPar.loc.x < width/2) {
          float pushingForce = pow(thres-tPar.loc.x, 3);
          PVector acc1 = new PVector(pushingForce, 0);
          tPar.acc.add(acc1);
        } else {
          float pushingForce = pow(-(thres+tPar.loc.x-width), 3);
          PVector acc1 = new PVector(pushingForce, 0);
          tPar.acc.add(acc1);
        }
      }
      if (tPar.loc.y <= thres || tPar.loc.y >= height-thres) {
        if (tPar.loc.y < height/2) {
          float pushingForce = pow(thres-tPar.loc.y, 3);
          PVector acc1 = new PVector(0, pushingForce);
          tPar.acc.add(acc1);
        } else {
          float pushingForce = pow(-(thres+tPar.loc.y-height), 3);
          PVector acc1 = new PVector(0, pushingForce);
          tPar.acc.add(acc1);
        }
      }
    }
  }

  void repel() {
    for (int i=0; i<particles.size(); i++) {
      Particle targetParticle1 = particles.get(i);
      for (int j=i+1; j<particles.size(); j++) {
        Particle targetParticle2 = particles.get(j);
        PVector dir = PVector.sub(targetParticle1.loc, targetParticle2.loc);
        float thres = (targetParticle1.radius+targetParticle2.radius)*5;
        if ( dir.x > -thres && dir.x < thres && dir.y > -thres && dir.y < thres ) {
          pushStyle();
          stroke(155, 180, 0, 80);
          strokeWeight(0.5);
          // z values commented for pdf compatibility
          line (targetParticle1.loc.x, targetParticle1.loc.y, /*targetParticle1.loc.z,*/targetParticle2.loc.x, targetParticle2.loc.y/*, targetParticle2.loc.z*/);
          popStyle();
          float magnitude = dir.mag();
          float distSqrd = pow(magnitude, 3);
          if (distSqrd>0) {
            float pushingForce = 1/distSqrd;
            dir.normalize();
            dir.mult(pushingForce);
            PVector accOffset1 = PVector.div(dir, targetParticle1.mass);
            PVector accOffset2 = PVector.div(dir, targetParticle2.mass);
            targetParticle1.acc.add(accOffset1);
            targetParticle2.acc.sub(accOffset2);
          }
        }
      }
    }
  }

  void update(PImage pattern) {
    for (int i=0; i<particles.size(); i++) {
      Particle targetParticle = particles.get(i);
      targetParticle.update(pattern);
    }
  }

  void display() {
    for (int i=0; i<particles.size(); i++) {
      Particle targetParticle = particles.get(i);
      targetParticle.display();
    }
  }
}
