// 定义全局变量
int gridSize = 20;   // 网格大小
int cols, rows;      // 列数和行数
Snake snake;         // 贪吃蛇对象
Food food;           // 食物对象
int score = 0;       // 分数
float speed = 0.1;

void setup() {
  size(400, 400);
  frameRate(60);

  // 计算列数和行数
  cols = width / gridSize;
  rows = height / gridSize;

  // 初始化贪吃蛇和食物对象
  snake = new Snake();
  food = new Food();
}

void draw() {
  background(51);

  // 贪吃蛇移动、碰撞检测、吃食物
  snake.move();
  snake.checkCollision();
  snake.checkEat(food);

  // 显示贪吃蛇和食物
  snake.display();
  food.display();

  // 显示分数
  fill(255);
  textSize(16);
  text("Score: " + score, 20, 20);
  
  speed = 0.1*map(frameCount,0,9000,1,10);
}

void keyPressed() {
  // 根据按键设置贪吃蛇的移动方向
  if (keyCode == UP && snake.direction.y != speed) {
    snake.setDirection(0, -speed);
  } else if (keyCode == DOWN && snake.direction.y != -speed) {
    snake.setDirection(0, speed);
  } else if (keyCode == LEFT && snake.direction.x != speed) {
    snake.setDirection(-speed, 0);
  } else if (keyCode == RIGHT && snake.direction.x != -speed) {
    snake.setDirection(speed, 0);
  }
}
