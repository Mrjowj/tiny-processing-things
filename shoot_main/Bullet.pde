class Bullet {
  PVector pos;
  int speed = 5;
  
  Bullet (float posx, float posy) {
    pos = new PVector(posx, posy); 
  }
  
  void update () {
    pos.y -= speed;
  }
  
  void display () {
    point(pos.x,pos.y);
  }
  
  void go () {
    update ();
    display ();
  }
}
