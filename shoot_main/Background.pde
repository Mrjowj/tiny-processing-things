ArrayList <Bullet> bullets = new ArrayList <Bullet> ();
ArrayList <Target> targets = new ArrayList <Target> ();

void creatTarget () {
  for (int i=0; i<=int(random(5,10)); i++) {
    targets.add(new Target(random(50,750),random(20,200)));
  }
}

int ifHit (final Bullet b) {
  int i;
  for (i = targets.size() - 1; i >= 0; i--) {
    float x =targets.get(i).pos.x;
    float y =targets.get(i).pos.y;
    if ( dist(x, y, b.pos.x, b.pos.y)<10 ) {
      return i;
    } 
  }
  return -1;
}
  
void updateAll () {
  for (int i = bullets.size() - 1; i >= 0; i--) {
    int hitIndex = ifHit(bullets.get(i));
    if ( hitIndex != -1 ) {
      bullets.remove(i);
      targets.remove( hitIndex );
    }
  }
}

void displayAll () {
   for (int i = 0; i < targets.size(); i++) {
    targets.get(i).display();
  }
   for (int i = 0; i < bullets.size(); i++) {
    bullets.get(i).go();
  }
}

void keyPressed() {
  if (key == 'w') { 
    //shooter.speed.y = -3;
    shooter.acceleration.y = -0.03;
  } else if (key == 'a') {
    //shooter.speed.x = -3;
    shooter.acceleration.x = -0.03;
  } else if (key == 's') {
    //shooter.speed.y = 3;
    shooter.acceleration.y = 0.03;
  } else if (key == 'd') {
    //shooter.speed.x = 3;
    shooter.acceleration.x = 0.03;
  } else if (key == ' ') {
    shooter.shoot();
  } else {
    shooter.speed.set(0, 0);
  }
}

void keyReleased() {
  if (key == 'w' || key == 's') {
    //shooter.speed.y = 0;
    shooter.acceleration.y = 0;
  } 
  if (key == 'a' || key == 'd') {
    //shooter.speed.x = 0;
    shooter.acceleration.x = 0;
  }
}

boolean ifwin () {
  if (targets.size() == 0) {
    return true;
  } else return false;
}
