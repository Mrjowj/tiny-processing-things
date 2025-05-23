ParticleSystem ps;
Repeller repeller;
PVector gravity = new PVector(0,0.163);

void setup() {
  size(1280,640);
  //frameRate(5);
  ps = new ParticleSystem(new PVector(width/2,50));
  repeller = new Repeller(width/2,height/2);
}

void draw() {
  background(255);
  ps.addParticle();//放入粒子
  
  ps.applyForce(gravity);//加入重力
  
  ps.applyRepeller(repeller);//加入斥力源r
  ps.run(); //粒子系统，启动！！
}
