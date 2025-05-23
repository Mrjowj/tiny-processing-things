import websockets.*;

WebsocketServer wsc;
final int SRV_PORT = 8000;

int x = 0;
int y = 0;

void setup() {
  wsc = new WebsocketServer(this, SRV_PORT, "");
  size(400, 400);
  background(0);
}

void draw() {
  ellipse(x, y, 10, 10);
  wsc.sendMessage(mouseX + "," + mouseY);
  delay(100);
}

void webSocketServerEvent(String msg) {
  //println(msg);
  String[] data = msg.split(",");
  x = int(data[0]);
  y = int(data[1]);
  println(x, y); //受け取ったデータを表示して確認すると良い
}
