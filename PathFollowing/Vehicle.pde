class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;

  Vehicle( PVector l, float ms, float mf) { //每辆车子的性能不同
    position = l.get();
    r = 4.0;
    maxforce = mf;
    maxspeed = ms;
    acceleration = new PVector(0, 0);
    velocity = new PVector(10, 0); //给予一个初始速度
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed); //限制速度（防止因转向力导致过快/慢）
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() { //画一个朝着速度方向的三角形
    float theta = velocity.heading2D() + radians(90);
    fill(255,0,0);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(PConstants.TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  void applyForce(PVector force) { //无质量时
    acceleration.add(force);
  }

  void follow (Path p) {
    PVector velocity_ = velocity.get();
    velocity_.normalize();
    velocity_.mult(50);
    PVector predictpos = PVector.add(position, velocity_);
    //找到小车的未来位置（predictpos）
    
    PVector target = null;
    float worldRecord = 1000000;

    for (int i=0; i<p.points.size()-1; i++) {
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      PVector normalPoint = getNoramlPoint(predictpos, a, b);
      //对每条线段获取法线交点
      if (normalPoint.x < a.x || normalPoint.x > b.x) {
        normalPoint = b.get();
      }
      //如果法线点不在线段内部,将法线视为线段的末端

      float distance = PVector.dist(predictpos, normalPoint);
      if (distance < worldRecord) {
        worldRecord = distance;
        //查找最近的法线点

        PVector direction = PVector.sub(b, a);
        direction.normalize();
        direction.mult(35);
        target = normalPoint.get();
        target.add(direction);
        //将离法线点一段距离的点视为希望到达的目标点
      }
      //最后只有离路最近的点会被当成目标点
    }

    if (worldRecord > p.radius-5) {
      seek(target);
    }
    //只有当距离大于路径的半径时才进行转向
  }

  PVector getNoramlPoint(PVector p, PVector a, PVector b) {
    //a：线段起始点 b：线段终点 p：predictpos
    PVector ap = PVector.sub(p, a);
    PVector ab = PVector.sub(b, a);
    ab.normalize();
    ab.mult(ap.dot(ab));
    PVector normalPoint = PVector.add(a, ab);//计算过程参考noc一书
    return normalPoint;
  }

  void seek(PVector target) { //进行转向
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void borders(Path p) {
    if (position.x > p.getEnd().x + r) {
      position.x = p.getStart().x - r;
      position.y = p.getStart().y + (position.y-p.getEnd().y);
    }
  }
}
