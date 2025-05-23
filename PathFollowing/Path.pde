class Path {

  ArrayList<PVector> points;
  float radius;

  Path() {
    radius = 20;
    points = new ArrayList<PVector>();//每一个Path实体都会有一个对应都Arraylist
  }

  void addPoint(float x, float y) {
    PVector point = new PVector(x, y);
    points.add(point);
  }

  PVector getStart() {
    return points.get(0);
  }

  PVector getEnd() {
    return points.get(points.size()-1);
  }

  void display() {
    stroke(175);
    strokeWeight((radius+5)*2);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    endShape();
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    endShape();
  }

  void newPath() { //从左向右向arraylist中添加点，以便操作
    path = new Path();
    path.addPoint(-20, height/2);
    path.addPoint(random(0, width/2), random(0, height));
    path.addPoint(random(width/2, width), random(0, height));
    path.addPoint(width+20, height/2);
  }
}
