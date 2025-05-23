GOL gol;

void setup() {
  size(1280,720);
  frameRate(24);
  gol=new GOL();
}

void draw() {
  background(255);

  gol.generate();
  gol.display();       

}

void mouseClicked() {
  int x = mouseX/8;
  int y = mouseY/8;
  gol.background[x][y] = 1;
}
