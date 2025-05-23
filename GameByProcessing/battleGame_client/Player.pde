class Player {
    //self
    int HP = 5;
    int d = 36;
    PVector pos = new PVector();
    PVector speed = new PVector();
    PVector acceleration = new PVector();
    float faceAng;
    color selfC = color(254, 255, 0);

    //ATK
    int alpha = 0;
    int ATKtime = 70;
    boolean isATK = false;
    PVector ATKScope = new PVector();
    PVector ATKpos = new PVector();
    float ATKAng;

    //DEF
    int DEFtime = 20;
    boolean isDEF = false;

    Player(float x, float y, float sx, float sy) {
        this.pos.x = x;
        this.pos.y = y;
        this.speed.x = sx;
        this.speed.y = sy;
    }

    void jump() {
        acceleration.y += -10;
        speed.y = 0;
        //print("jump ");
    }

    void attack() {
        if (ATKtime < 50) {
            pushMatrix();
            translate(ATKpos.x, ATKpos.y);
            rotate(ATKAng);
            fill(255, 255, 10);
            rect(25, -25, ATKScope.x, ATKScope.y);
            popMatrix();
            //print("Attack:" + isATK);
        }
    }

    void defence() {
        fill(0, 0, 255, 10*DEFtime - 45);
        ellipse(pos.x, pos.y, 60, 60);
    }

    void update() {
        //pos
        if (player2.speed.x > 7) player2.speed.x = 7;
        else if (player2.speed.x < -7) player2.speed.x = -7;
        speed.x += acceleration.x;
        speed.y += acceleration.y;
        pos.x += speed.x;
        pos.y += speed.y;
        acceleration = new PVector(0, 0);
        faceAng = atan2(speed.y, speed.x);

        //ATK
        if (isATK) ATKtime --;
        if (ATKtime <= 0) {
            ATKtime = 70;
            isATK = false;
            ATKScope = new PVector();
            ATKpos = new PVector();
        }

        //DEF
        if (isDEF) DEFtime --;
        if (DEFtime <= 0) {
            DEFtime = 30;
            isDEF = false;
        }
    }

    void display() {
        
        //self
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(faceAng + PI/2);
        fill(selfC);
        stroke(0);
        ellipse(0, 0, d, -d);
        rect(-d/4, 30, d/2, -d/2);
        noStroke();
        ellipse(0, 0, d-2, -d+2);
        popMatrix();

        //preATK
        if (alpha != 0) {
            ATKScope.x = 30+alpha;
            ATKScope.y = 20+alpha/6;           
            fill(255, 0, 0, alpha);
            pushMatrix();
            translate(pos.x, pos.y);
            rotate(faceAng);
            rect(25, -25, ATKScope.x, ATKScope.y);
            popMatrix();
        }
        
        //ATK
        if (isATK) attack();

        //DEF
        if (isDEF) defence();

    }

    void checkEdge() {
        if (pos.y+100+d/2 > height) {
            speed.x *= 1;
            speed.y = 0;
            pos.y = height-100-d/2;
        } else if (pos.y-d/2 < 0) {
            speed.x *= 1;
            speed.y *= -1;
            pos.y = d/2;
        }
        if (pos.x + d/2 > width) {
            speed.x *= -1;
            pos.x = width - d/2;
        } else if (pos.x - d/2 < 0) {
            speed.x *= -1;
            pos.x = d/2;
        }
        
        //1
        if(pos.y + d/2 < 325 && pos.y + d/2 > 300) {
            if(pos.x + d/2 > 400 && pos.x - d/2 < 800) {
              pos.y  = 300 - d/2;
              speed.y = 0;
            }
        }
        
        //2
        if(pos.y + d/2 < 175 && pos.y + d/2 > 150) {
            if(pos.x + d/2 > 100 && pos.x - d/2 < 300) {
              pos.y  = 150 - d/2;
              speed.y = 0;
            }
        }
        
        //3
        if(pos.y + d/2 < 175 && pos.y + d/2 > 150) {
            if(pos.x + d/2 > 900 && pos.x - d/2 < 1100) {
              pos.y  = 150 - d/2;
              speed.y = 0;
            }
        } 
    }

    void go () {
        update();
        checkEdge();
        display();
    }
}
