import websockets.*;

WebsocketClient wsc;
String message = "";
final String SRV_NAME = "localhost"; //localhost
final int SRV_PORT = 8000;

int x = 0;
int y = 0;

void setup() {
  size(400, 400);
  background(0);
  wsc = new WebsocketClient(this, "ws://" + SRV_NAME + ":" + SRV_PORT);
}

void draw() {
  wsc.sendMessage(mouseX + "," + mouseY);
  //println(mouseX + "," + mouseY);
  ellipse(x, y, 10, 10);
  delay(100);
}

void webSocketEvent(String msg){ //データ受信のイベントの関数がサーバと違うので注意
 //println(msg);
  String[] data = msg.split(",");
  x = int(data[0]);
  y = int(data[1]);
}
