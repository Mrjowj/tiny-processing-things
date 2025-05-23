class GOL {
  int [][] background;
  int columns, rows;
  int w = 8;


  GOL() {
    columns = width/w;
    rows = height/w;
    background = new int[columns][rows];
    init();
  }

  void init() {
    for (int i=1; i<columns; i++) {
      for (int j=1; j<rows; j++) {
        background[i][j] = int(random(2));
      }
    }
  }
  
  //void mouseClicked() {
  //  int x = mouseX/w;
  //  int y = mouseY/w;
  //  background[x][y] = 1;
  //}

  void generate() {
    if (keyPressed) {
      int[][] next = new int[columns][rows];

      for (int x = 1; x < columns-1; x++) {
        for (int y = 1; y < rows-1; y++) {

          int neighbors = 0;
          for (int i = -1; i<=1; i++) {
            for (int j=-1; j<=1; j++) {
              neighbors += background[x+i][y+j];
            }
          }
          neighbors -= background[x][y]; //减去自己
          if ((background[x][y] == 1) && (neighbors < 2)) {
            next[x][y] = 0;
          } else if ((background[x][y] == 1) && (neighbors >  3)) {
            next[x][y] = 0;
          } else if ((background[x][y] == 0) && (neighbors == 3)) {
            next[x][y] = 1;
          } else {
            next[x][y] = background[x][y];
          }
        }
      }
      background = next;
    }
  }

  void display() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        if ((background[i][j] == 1)) fill(0);
        else fill(255);
        stroke(0);
        rect(i*w, j*w, w, w);
      }
    }
  }
}
