class Food {
  PVector position;  // 食物的位置

  Food() {
    // 初始化食物
    spawn();
  }

  void spawn() {
    // 随机生成食物的位置，确保不在蛇的身体上
    do {
      int x = int(random(cols));
      int y = int(random(rows));
      position = new PVector(x, y);
    } while (snake.body.contains(position));
  }

  void display() {
    // 显示食物
    fill(255, 0, 0);
    noStroke();
    ellipse(position.x * gridSize + gridSize / 2, position.y * gridSize + gridSize / 2, gridSize, gridSize);
  }
}

void gameOver() {
  // 游戏结束，显示分数并停止循环
  println("Game Over! Score: " + score);
  noLoop();
}
