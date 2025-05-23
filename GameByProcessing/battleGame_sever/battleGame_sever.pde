import websockets.*;
WebsocketServer wsc;
final int SRV_PORT = 8000;
String message = "";

Player player1 = new Player(200, 200, 0, 0);
Enemy enemy1 = new Enemy();
BackGround BG;
Controller C;

PImage Img_BG;

void setup() {
    wsc = new WebsocketServer(this, SRV_PORT, "");
    frameRate(60);
    noStroke();
    size(1200, 600);
    textSize(25);
    C = new Controller(player1);
    BG = new BackGround(0.3, player1, enemy1, C);
    Img_BG = loadImage("BG2.gif");
}

//每一帧都是从0开始话,所以颜色判定需要在最后进行
void draw() {
    background(255, 255, 255);
    image(Img_BG, 0, -200);
    if (!BG.gameOver) {
        C.ctrl();
        player1.go();
        enemy1.display();
        BG.All();
    } else {
        textSize(80);
        fill(0);
        if(player1.HP < 0) text("YOU LOSE!", 420, 340);
        else text("YOU WIN!", 420, 340);
    }
}

void webSocketServerEvent(String msg) {
    //println(msg);
    String[] data = msg.split(",");
    if (data[0].equals("BASIC")) {
        enemy1.pos.x = int(data[1]);
        enemy1.pos.y = int(data[2]);
        enemy1.faceAng = float(data[3]);
        enemy1.HP = int(data[4]);
    }

    enemy1.isATK = false;
    if (data[0].equals("ATK")) {
        enemy1.isATK = true;
        enemy1.ATKpos = new PVector(float(data[1]), float(data[2]));
        enemy1.ATKScope = new PVector(float(data[3]), float(data[4]));
        enemy1.ATKAng = float(data[5]);
    }

    enemy1.isDEF = false;
    if (data[0].equals("DEF")) {
        enemy1.isDEF = true;
        enemy1.DEFtime = int(data[1]);
    }

    if (data[0].equals("OVER")) BG.gameOver = true;
}
