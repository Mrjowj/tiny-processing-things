class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  float mass = random(2);
  
  Particle(PVector pos){
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-2,2),random(-2,2));
    position = pos.get();
    lifespan = 255.0;
  }
  
   void run() {
    update();
    display();
  }
  
  void applyForce(PVector force) {//力的实际表现为加速度
    PVector a = force.get();
    a.div(mass);
    acceleration.add(a);
    println(force);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);//重置加速度
    lifespan -= 1.3;
  }
  
  void display() {
    stroke(0,lifespan);//阿尔法值为lifespan
    strokeWeight(2);
    fill(127,lifespan);//阿尔法值为lifespan
    ellipse(position.x,position.y,6*mass,6*mass);
  }
  
  boolean isDead() {//让这个函数有返回值
    if (lifespan < 0.0) {
      return true;
    }
    else {
      return false;
    }
  }
}
  
    
