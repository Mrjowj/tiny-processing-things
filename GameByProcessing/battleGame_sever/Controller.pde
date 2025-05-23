class Controller {
    boolean[] keys = new boolean[256];
    Player player;
    int JumpCount = 0;
    int ATK_CD = 1200;
    int DEF_CD = 700;
    
    int now;
    int lastJump = 0;
    int lastDEF = 0;
    int lastATK = 0;
    
    // 距离上次攻击/防御,time since last attack/defence
    int TSLA;
    int TSLD;
    
    Controller(Player player) {
        this.player = player;
    }

    void ctrl() {
        now = millis();
        TSLA = now - lastATK;
        TSLD = now - lastDEF;
        
        if (keys['d']) player.acceleration.x += 0.3;
        if (keys['a']) player.acceleration.x += -0.3;
        if (keys['w']) {
            if (JumpCount < 2 && now - lastJump > 1000) {
                player1.jump();
                JumpCount++;
                keys['w'] = false;
            }
            if (JumpCount >= 2) {
                JumpCount = 0;
                lastJump = now;
            }
        }
        
        if (keys[' ']) {
            if (TSLA > ATK_CD) {
                if (player.alpha<=255) player.alpha += 8;
            }
        }
        
        if (keys['q']) {
            if (TSLD > DEF_CD) {
                player.isDEF = true;
                lastDEF = now;
            }
        }
    }
    
}

void keyPressed() {
    if (key < 256) C.keys[key] = true;
    //print(key);
}

void keyReleased() {
    if (key < 256) C.keys[key] = false;
    if (key == 'd') player1.speed.x = 1 + player1.speed.x/10.0;

    if (key == 'a')player1.speed.x = -1 + player1.speed.x/10.0;
   
    if (key == ' ') {
        C.lastATK = C.now;
        player1.alpha = 0;
        player1.ATKpos = player1.pos.copy();    
        player1.isATK = true;  
        player1.ATKAng = player1.faceAng;
    }
}
