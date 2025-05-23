class Snake {
  ArrayList<PVector> body;  // 蛇身体的坐标列表
  PVector direction;        // 蛇的移动方向
  int count=0;
  PVector head=new PVector(0,0);

  Snake() {
    // 初始化蛇，起始位置在屏幕中央，初始方向向右
    body = new ArrayList<PVector>();
    body.add(new PVector(cols / 2, rows / 2));
    direction = new PVector(0, 0);
  }

  void setDirection(float x, float y) {
    // 设置蛇的移动方向
    direction.set(x, y);
  }

  void move() {
    // 移动蛇
    head = body.get(0).copy();
    head.add(direction);
    body.add(0, head);
    println(head);
    println(count);
    // 如果没有吃到食物，则删除蛇尾
    if (!ateFood()&&count==0) {
      body.remove(body.size() - 1);
    }else {
      count++;
    }
    if(count>=speed*200) {
      count=0;
    }
  }

  void checkCollision() {
    // 检查碰撞，是否撞墙或撞到自己的身体
    //PVector head = body.get(0);
    if (head.x < 0 || head.x >= cols || head.y < 0 || head.y >= rows ) {
      gameOver();
    }
  }

  void checkEat(Food food) {
    // 检查是否吃到食物，吃到则增加分数
    //PVector head = body.get(0);
    if (head.dist(food.position) < 1) {
      food.spawn();
      score++;
    }
  }

  boolean ateFood() {
    // 检查是否吃到食物
    //PVector head = body.get(0);
    return head.dist(food.position) < 1;
  }

  boolean collisionWithBody() {
    // 检查是否与自己的身体相撞
    //PVector head = body.get(0);
    for (int i = 1; i < body.size(); i++) {
      PVector part = body.get(i);
      if (head.dist(part) == 0) {
        println(123);
        return true;
      }
    }
    return false;
  }

  void display() {
    // 显示蛇的身体
    fill(255);
    noStroke();
    for (PVector part : body) {
      rect(part.x * gridSize, part.y * gridSize, gridSize, gridSize);
    }
  }
}
