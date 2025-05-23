import websockets.*;
WebsocketClient wsc;
String message = "";
final String SRV_NAME = "192.168.68.56"; //localhost
final int SRV_PORT = 8000;

Player player2 = new Player(1000, 200, 0, 0);
Enemy enemy2 = new Enemy();
BackGround BG;
Controller C;

PImage Img_BG;

void setup() {
    wsc = new WebsocketClient(this, "ws://" + SRV_NAME + ":" + SRV_PORT);
    frameRate(60);
    noStroke();
    size(1200, 600);
    textSize(25);
    C = new Controller(player2);
    BG = new BackGround(0.3, player2, enemy2, C);
    Img_BG = loadImage("BG2.gif");
}

void draw() {
    background(255, 255, 255);
    image(Img_BG, 0, -200);
    if (!BG.gameOver) {
        C.ctrl();
        player2.go();
        enemy2.display();
        BG.All();
    } else {
        textSize(80);
        fill(0);
        if(player2.HP < 0) text("YOU LOSE!", 420, 340);
        else text("YOU WIN!", 420, 340);
    }
}

void webSocketEvent(String msg) {
    //println(msg);
    String[] data = msg.split(",");
    if (data[0].equals("BASIC")) {
        enemy2.pos.x = int(data[1]);
        enemy2.pos.y = int(data[2]);
        enemy2.faceAng = float(data[3]);
        enemy2.HP = int(data[4]);
    }

    enemy2.isATK = false;
    if (data[0].equals("ATK")) {
        enemy2.isATK = true;
        enemy2.ATKpos = new PVector(float(data[1]), float(data[2]));
        enemy2.ATKScope = new PVector(float(data[3]), float(data[4]));
        enemy2.ATKAng = float(data[5]);
    }

    enemy2.isDEF = false;
    if (data[0].equals("DEF")) {
        enemy2.isDEF = true;
        enemy2.DEFtime = int(data[1]);
    }

    if (data[0].equals("OVER")) BG.gameOver = true;
}
