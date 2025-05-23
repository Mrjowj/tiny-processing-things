Perceptron perceptron;
float[][] training;
int[] desired;
int count = 0;
boolean allCorrect = false;

void setup() {
    size(600, 600);  
    textSize(20);
    //frameRate(3);

    // パーセプトロンを作成 (入力3つ、バイアスを含む)
    float[] w = new float[] {0.2, 0.2, -0.1};
    perceptron = new Perceptron(w);

    // トレーニングデータ
    // x1, x2, バイアス   
    training = new float[][] {
        {2, 2, 1},
        {1, 3, 1},
        {3, 4, 1},
        {4, 5, 1},
        {5, 7, 1},
        {6, 6, 1},
        {7, 8, 1},
        {4, 1, 1},
        {5, 2, 1},
        {7, 1, 1},
    };
    desired = new int[] {1, 1, 1, 1, 1, 1, 1, 0, 0, 0};
}

void draw() {
    drawGraph();
    
    // すべてのトレーニングデータが正しく分類されているか確認
    allCorrect = true;
    for (int i = 0; i < training.length; i++) {
        int output = perceptron.feedforward(training[i]);
        if (output != desired[i]) {
            allCorrect = false;
            break;
        }
    }
    
    // 正しく分類されていないとトレーニングデータを使ってパーセプトロンを学習
if (!allCorrect) {
        print(count + ":");
        perceptron.printWeights();
        if(count % training.length == 0) println();
        perceptron.train(training[count % training.length], desired[count % training.length]);
        count = count + 1;
    } else { //正しく分類されると終了S
        print(count + ":");
        perceptron.printWeights();
        fill(0);
        scale(1, -1);
        text("Finish!", 100, -300);
        text("Count: " + count, 100, -280);
        noLoop();
    }
}

void drawGraph() {
    background(255);
    translate(50, height - 50);  // 第一象限从左下角开始

    // 缩放比例修改，使网格更密集
    int gridStep = 50;
    scale(1, -1);

    // 绘制网格
    stroke(200);
    for (int i = 0; i <= 10; i++) {
        line(i * gridStep, 0, i * gridStep, 10 * gridStep); // 垂直线
        line(0, i * gridStep, 10 * gridStep, i * gridStep); // 水平线
    }

    // 坐标轴
    stroke(0);
    strokeWeight(2);
    line(0, 0, 10 * gridStep, 0);       // x轴
    line(0, 0, 0, 10 * gridStep);      // y轴

    // 绘制训练数据
    float[] point = training[count % training.length];
    fill(255, 255, 255);
    ellipse(point[0] * gridStep, point[1] * gridStep, 25, 25);
    for (int i = 0; i < training.length; i++) {
        point = training[i];
        int output = perceptron.feedforward(point);

        if (output == 1) fill(0, 255, 0); // 正确的点
        else fill(255, 0, 0); // 错误的点

        noStroke();
        ellipse(point[0] * gridStep, point[1] * gridStep, 20, 20);
    }

    // 绘制分割线
    stroke(0, 0, 255);
    strokeWeight(2);
    float[] weights = perceptron.getWeights();
    if (weights[1] != 0) {
        float x1 = 0;
        float y1 = -(weights[2] / weights[1]) * gridStep;
        float x2 = 10 * gridStep;
        float y2 = -(weights[0] / weights[1]) * x2 - (weights[2] / weights[1]) * gridStep;
        line(x1, y1, x2, y2);
    }
}
