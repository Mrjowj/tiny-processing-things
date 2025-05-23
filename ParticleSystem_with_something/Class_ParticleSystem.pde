//粒子系统需要包含什么？
//1.多个粒子
//2.需要的其他物体（这里是斥力源）
//3.让系统动起来
class ParticleSystem {
   Particle p;
   ArrayList<Particle> particles;//这里只是定义
   PVector originpoint;

   ParticleSystem(PVector position) {//作为粒子系统，要有一个原点（发射器）
     originpoint = position;
     particles = new ArrayList<Particle>();
   }

   void addParticle() {
     particles.add(new Particle(originpoint));
   }

   void applyForce(PVector f) {
     //为了使主程序简洁，在粒子系统中加入applyforce函数以统一给粒子赋予力
     for (int i = 0; i < particles.size(); i++) {
       p = particles.get(i);
       p.applyForce(f);
     }
   }
   
   void applyRepeller(Repeller r) {
    for (int i = 0; i < particles.size(); i++) {
      p = particles.get(i);
      PVector force = r.repel(p);        
      p.applyForce(force);
    }
    r.display();
  }
  
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
   
