class Enemy {
    int HP = 5;
    int d = 36;
    color selfCol = color(128, 0, 128);
    color ATKCol = color(128, 10, 128);

    //通过网络传送的信息
    PVector pos = new PVector(0, 0);
    float faceAng;

    boolean isATK = false;
    PVector ATKScope;
    PVector ATKpos;
    float ATKAng;

    boolean isDEF = false;
    int DEFtime = 20;
    
    Enemy() {}

    void attack() {
        pushMatrix();
        translate(ATKpos.x, ATKpos.y);
        rotate(ATKAng);
        fill(128, 10, 128);
        rect(25, -25, ATKScope.x, ATKScope.y);
        popMatrix();
    }
    
    void defence() {
        fill(0, 0, 255, 10*DEFtime - 45);
        ellipse(pos.x, pos.y, 60, 60);
    }

    void display() {
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(faceAng + PI/2);
        fill(selfCol);
        ellipse(0, 0, d, -d);
        rect(-d/4, 30, d/2, -d/2);
        popMatrix();

        //ATK
        if (isATK) attack();
        if (isDEF) defence();
    }
}
