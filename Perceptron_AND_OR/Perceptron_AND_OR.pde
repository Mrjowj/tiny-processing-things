Perceptron perceptron;
float[][] training;
int[] desired;
int count = 0;
boolean allCorrect = false;

void setup() {
    size(640, 480);
    textSize(20);
    //frameRate(1);

    // パーセプトロンを作成 (入力3つ、バイアスを含む)
    float[] w = new float[] {0.1, 0.1, -0.3};
    perceptron = new Perceptron(w);

    // トレーニングデータ
    // x1, x2, バイアス
    training = new float[][] {
        {1, 1, 1},
        {1, 0, 1},
        {0, 1, 1},
        {0, 0, 1}
    };


    // ORの期待出力
    //desired = new int[] {1, 1, 1, 0};

    // ANDの期待出力
    desired = new int[] {1, 0, 0, 0};
}

void draw() {
    //本体
    //{
    //    drawGraph();

    //    // すべてのトレーニングデータが正しく分類されているか確認
    //    allCorrect = true;
    //    for (int i = 0; i < training.length; i++) {
    //        int output = perceptron.feedforward(training[i]);
    //        if (output != desired[i]) {
    //            allCorrect = false;
    //            break;
    //        }
    //    }

    //    // 正しく分類されていないとトレーニングデータを使ってパーセプトロンを学習
    //    if (!allCorrect) {
    //        print(count + ":");
    //        perceptron.printWeights();
    //        if(count % training.length == 0) println();
    //        perceptron.train(training[count % training.length], desired[count % training.length]);
    //        count++;
    //    } else { //正しく分類されると終了S
    //        print(count + ":");
    //        perceptron.printWeights();
    //        fill(0);
    //        scale(1, -1);
    //        text("Finish!", -100, -200);
    //        text("Count: " + count, -100, -180);
    //        noLoop();
    //    }
    //}

    //用来观察学习率的影响
    {
        float[] LR = new float[]{0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 50, 100};
        float[] w = new float[] {0.1, 0.1, -0.3};
        for (float l : LR) {
            perceptron = new Perceptron(w);
            perceptron.LR = l;
            count = 0;
            allCorrect = false;
            while (!allCorrect) {
                allCorrect = true;
                for (int i = 0; i < training.length; i++) {
                    int output = perceptron.feedforward(training[i]);
                    if (output != desired[i]) {
                        allCorrect = false;
                        perceptron.train(training[i], desired[i]); // 更新权重
                        count++;
                    }
                }
            }
            // 输出当前学习率和所需迭代次数
            println("LR: " + l + ", count: " + count);
        }
    }
}

void drawGraph() {
    background(255);
    translate(width / 2, height / 2);
    scale(1, -1);

    // グリッドの可視化
    stroke(200);
    for (int i = -width / 2; i < width / 2; i += 40) line(i, -height / 2, i, height / 2);
    for (int j = -height / 2; j < height / 2; j += 40) line(-width / 2, j, width / 2, j);

    // 軸を描画
    stroke(0);
    strokeWeight(2);
    line(-width / 2, -100, width / 2, -100); // x軸
    line(-100, -height / 2, -100, height / 2); // y軸

    // トレーニングデータを可視化
    float[] point = training[count % training.length];
    ellipse(point[0] * 200 - 100, point[1] * 200 - 100, 25, 25);
    for (int i = 0; i < training.length; i++) {
        point = training[i];
        int output = perceptron.feedforward(point);

        if (output == 1) fill(0, 255, 0); // 正しく分類されたら緑
        else fill(255, 0, 0); // 誤分類されたら赤

        noStroke();
        ellipse(point[0] * 200 - 100, point[1] * 200 - 100, 20, 20);
    }

    // パーセプトロンの分割線を描画
    stroke(0, 0, 255);
    strokeWeight(2);
    float[] weights = perceptron.getWeights();
    if (weights[1] != 0) {
        // y = -(w0/w1) * x - (w2/w1)
        float x1 = -width / 2;
        float y1 = -(weights[0] / weights[1]) * x1 - (weights[2] / weights[1]) * 200;
        float x2 = width / 2;
        float y2 = -(weights[0] / weights[1]) * x2 - (weights[2] / weights[1]) * 200;
        line(x1, y1-100, x2, y2-100);
    }
}
