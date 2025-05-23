Shooter shooter;

void setup() {
  shooter = new Shooter(0,0,200,200);
  size(800,500);
  strokeWeight(5);
  textSize(50);
  frameRate(244);
  creatTarget ();
}


void draw() {
  if ( !ifwin() ) {
    background(255,255,255);
    shooter.go();
    updateAll();
    displayAll();
  } else {
    fill(0,0,0);
    text("you win", 300, 250);
  }
}
