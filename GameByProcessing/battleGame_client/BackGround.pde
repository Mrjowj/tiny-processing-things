class BackGround {
    float g;
    Player player;
    Enemy enemy;
    Controller C;
    color danger;
    
    //invincibilty frame
    int iFrames = 0;
    boolean gameOver = false;
    
    BackGround(float g, Player player, Enemy enemy, Controller C) {
        this.player = player;
        this.enemy = enemy;
        this.C = C;
        this.g = g;
        this.danger = enemy.ATKCol;
    }

    void applyGravity() {
        player.acceleration.y += g;
    }

    void drawBoard() {
        stroke(0);
        fill(200, 200, 200, 200);
        rect(-10, 500, width+10, 600);
        //1
        rect(400, 300, 400, 25);     
        //2
        rect(100, 150, 200, 25);
        //3
        rect(900, 150, 200, 25);
        
        //ATKcooling
        float c1 = map(C.TSLA, 0, C.ATK_CD, 0, 255);
        fill(255, 0, 0, c1);
        ellipse(50, 550, 60, 60);
        if(c1 >= 250) {
            fill(0);
            text("ATK",30, 560);
        }
        
        //DEFcooling
        float c2 = map(C.TSLD, 0, C.DEF_CD, 0, 255);
        fill(0, 0, 255, c2);
        ellipse(125, 550, 60, 60);
        if(c2 >= 250) {
            fill(0); 
            text("DEF",105, 560);
        }
        noStroke();
        
        //HP
        for (int i=0; i< player.HP; i++) {
            fill(player.selfC);
            ellipse(40+ i*30, 30, 20, 20);
        }
        
        for (int i=0; i< enemy.HP; i++) {
            fill(enemy.selfCol);
            ellipse(width - 40 - i*30, 30, 20, 20);
        }
    }
    
    void sendMSG() {
          wsc.sendMessage("BASIC" + "," + player.pos.x + "," + player.pos.y 
                                  + "," + player.faceAng + "," + player.HP);
        if(player.isATK) {
            wsc.sendMessage("ATK" + "," + player.ATKpos.x + "," + player.ATKpos.y  
                                  + "," + player.ATKScope.x + "," + player.ATKScope.y
                                  + "," + player.ATKAng);
        }
        if(player.isDEF) {
            wsc.sendMessage("DEF" + "," + player.DEFtime);
        }
    }
    
    //check player(not enemy) has been attacked or not
    void ATKcheck() {
        //PlayerPosColor
        color PPC = get((int)player.pos.x, (int)player.pos.y);
        
        //预警
        if(red(PPC) != 0 && green(PPC) == 0 && blue(PPC) == 0) {
            fill(255,0,0);
            text("危", player.pos.x, player.pos.y - 30);
        }
        
        //正式攻击
        else if(PPC == danger
           && iFrames == 0 && player.isDEF == false) {
            iFrames++;
            player.HP--;
            println(player.HP);
        }
        if(iFrames != 0) iFrames++;
        if(iFrames > 40) iFrames = 0;
    }
    
    void gameOver() {
        if(player.HP < 0) {
            gameOver = true;
            wsc.sendMessage("OVER");
        }
    }
    
    void All() {
        applyGravity();
        drawBoard();
        sendMSG();
        ATKcheck();
        gameOver();
    }
}
