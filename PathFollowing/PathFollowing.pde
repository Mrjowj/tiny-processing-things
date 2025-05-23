Path path;
Vehicle car1;
Vehicle car2;

void setup() {
  size(800,400);
  path = new Path();
  path.newPath();
  car1 = new Vehicle(new PVector(0, height/2), 4, 0.4);
  car2 = new Vehicle(new PVector(0, height/2), 2, 0.08);
}

void draw() {
  background(255);
  path.display();
  car1.follow(path);
  car1.run();
  car1.borders(path);
  car2.follow(path);
  car2.run();
  car2.borders(path);
}

public void mousePressed() {
  path.newPath();
}
