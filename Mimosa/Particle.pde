class Particle{
  PVector loc;
  PVector vel;
  PVector acc;
  
  float mass;
  float decay;
  float radius;
  float targetRadius;
  
  Particle(PVector initLoc, PVector initVel){
    loc = initLoc;
    vel = initVel;
    acc = new PVector(0,0);
    
    decay = random(0.9,0.95);
    targetRadius = 5;
    radius = 3;
    mass = sq(radius)*0.0001+0.01;
  }
  
  void update(PImage pattern){
    vel.add(acc);
    
    float maxVel = radius+0.0025;
    float velLength = sq(vel.mag())+0.1;
    if(velLength>sq(maxVel)){
      vel.normalize();
      vel.mult(maxVel);
    }
    
    loc.add(vel);
    vel.mult(decay);
    acc.set(0,0,0);
    
    if(loc.x>0 && loc.x<width-1 && loc.y>0 && loc.y<height-1){
      int index = floor(loc.x) + floor(loc.y)*pattern.width;
      targetRadius = brightness(pattern.pixels[index])/255.0*3+0.5;
    }else{
      targetRadius = 0.1;
    }
    
    radius = lerp(radius,targetRadius,0.1);
    mass = sq(radius)*0.0001+0.01;
  }
  
  void display(){
    
    strokeWeight(pow(radius,1.5));
    point(loc.x,loc.y);
  }
  
}
