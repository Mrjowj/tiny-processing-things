class Target {
  PVector pos;
  
  Target (float posx,float posy) {
    pos = new PVector(posx, posy); 
  }
  
  void display () {
    ellipse(pos.x, pos.y, 20, 20);
  }
}
