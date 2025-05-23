class Repeller {
  PVector pos;
  float G = 200;
  
  Repeller(float x, float y)  {
    pos = new PVector(x,y);
  }
  
  void display() {
    stroke(0);
    fill(255,0,0);
    ellipse(pos.x,pos.y,10,10);
  }
  
  PVector repel(Particle p) {//反弹者拥有反弹粒子的性质，所以输入为粒子，输出为反弹力
    PVector dir = PVector.sub(pos,p.position);     
    float d = dir.mag();                      
    dir.normalize();                          
    d = constrain(d,5,100);                    
    float force = -1 * G / (d * d);            
    dir.mult(force);                           
    return dir;
  }  
}
