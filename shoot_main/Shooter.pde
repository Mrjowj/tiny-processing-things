class Shooter {
  PVector pos;
  PVector speed;
  PVector acceleration = new PVector (0,0);
  
  Shooter (int xSpeed,int ySpeed,int posx,int posy) {
    speed = new PVector(xSpeed, ySpeed); 
    pos = new PVector(posx, posy); 
  }
  
  void shoot () {
    bullets.add (new Bullet(pos.x,pos.y));
    println(1);
  }
  
  void display () {
    triangle(pos.x,pos.y,pos.x-10,pos.y+30,pos.x+10,pos.y+30);
  }
  
  void update() {
    float friction = 0.98;
    shooter.speed.limit(6);
    shooter.speed.x *= friction;
    shooter.speed.y *= friction;
    speed.x += acceleration.x;
    speed.y += acceleration.y;    
    pos.x += speed.x;
    pos.y += speed.y;
  }
  
  void go () {
    update();
    display();
  }
}
