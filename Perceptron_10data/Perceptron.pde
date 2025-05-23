class Perceptron {
    float[] weights;

    Perceptron(float initWeights[]) {
        weights = new float[initWeights.length];
        for (int i = 0; i < initWeights.length; i++) weights[i] = initWeights[i];
    }

    // 出力を計算
    int feedforward(float[] inputs) {
        float sum = 0;
        for (int i = 0; i < weights.length; i++) sum += weights[i] * inputs[i];
        return sum > 0 ? 1 : 0;
    }

    // 更新式を沿って重りを更新
    void train(float[] inputs, int desired) {
        float[] tmpW = new float[3];
        for (int i = 0; i < weights.length; i++) {
            //print(" d= " + desired);
            //print(" x= " + feedforward(inputs));
            //print(" s" + i + "= " + inputs[i]);
            tmpW[i] = weights[i] + (desired - feedforward(inputs)) * inputs[i];
            //println(" w" + i + "= " + tmpW[i]);
        }
        for (int i = 0; i < weights.length; i++) weights[i] = tmpW[i];
        //println();
    }

    float[] getWeights() {
        return weights;
    }
    
    void printWeights() {
        for (int i = 0; i < weights.length; i++) print("s"+ i + "=" + weights[i] + " ");
        println();
    }
}
