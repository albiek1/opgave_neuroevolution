ArrayList<bird> population, saved;
ArrayList<pipe> pipes;
float TOTAL;
int Gens;
float counter;

void setup(){
 size(640, 480);
 
 TOTAL = 500;
 pipes = new ArrayList<pipe>();
 population = new ArrayList<bird>();
 saved = new ArrayList<bird>();
 
 for(int i = 0; i < TOTAL; i++){
  population.add(new bird());
 }
  counter = 0;
}

void draw(){
 background(51);
 if (counter % 75 == 0){
  pipes.add(new pipe());
 }
 
 for(int i = pipes.size()-1; i >= 0; i--){
  pipe p = pipes.get(i);
  p.update();
  if ( p.offscreen()){
   pipes.remove(i); 
  }
  for(int j = population.size()-1; j >= 0; j--){
    bird b = populatoin.get(j);
    if (p.hit(b) || b.dead){
     saved.add(b);
     population.remove(j);
    }
  }
 }
 if (population.size() == 0){
  counter = 0;
  nextGeneration();
  pipes.clear();
  pipes.add(new pipe());
 }
 
 for(bird b : population){
  b.show();
  b.update();
  b.think(pipes);
 }
 
 for(int i = pipes.size()-1; i >= 0; i--){
  pipe p = pipes.get(i);
  p.show();
 }
 counter++;
}

void nextGeneration(){
 Gens++;
 println("Generations "+ Gens);
 calculateFitness();
 for (int i = 0; i < TOTAL; i++){
  population.add(pickOne()); 
 }
 saved.clear();
}

bird pickOne(){
  int index = 0;
  float r = random(1);
  while (r > 0){
   r -= saved.get(index).fitness;
   index++;
  }
  index--;
  birb b = saved.get(index);
  bird child = new bird(b.brain);
  child.mutate();
  return child;
}

void calulateFitness(){
  float sum = 0;
  for (bird b : saved){
   sum += b.score; 
  }
  
  for(bird b : saved){
   b.fitness = b.score/sum; 
  }
}

static class Matrix{
 int rows, cols;
 float [][] values;
 
 Matrix(int rows, int cols){
   this.rows = rows;
   this.cols = cols;
   values = new float[this.rows][this.cols];
 }
 
 Matrix(){
  rows = 1;
  cols = 1;
  values = new float[rows][cols];
 }
 Matrix copy(){
  Matrix result = new Matrix(rows, cols);
  for(int i = 0; i < rows; i++){
   for(int j = 0; j < cols; j++){
    result.values[i][j] = values[i][j]; 
   }
  }
  return result;
 }
 static String[][] stringify(Matrix a){
  String[][] result = new String[a.rows][a.cols];
  for(int i = 0; i < a.rows; i++){
   for(int j = 0; j < a.cols; j++){
    result[i][j] = i+" " + j+" " + a.values[i][j]+" "; 
   }
  }
  return result;
 }
 
 void multiply(float n){
  for (int i = 0; i < rows; i++){
   for(int j = 0; j < cols; j++){
    values[i][j] *= n; 
   }
  }
 }
 
 void add(float n){
  for(int i = 0; i < rows; i++){
   for(int j = 0; j < cols; j++){
     values[i][j] += n;
   }
  }
 }
 
 static Matrix random(int rows, int cols){
  Matrix result = new Matrix(rows, cols);
  result.randomize();
  return result;
 }
 
 void randomize(){
  for(int i = 0; i < rows; i++){
   for(int j = 0; j < cols; i++){
     values[i][j] = (float) Math.random() * 2 - 1;
   }
  }
 }
 
 static Matrix subtract(Matrix a, Matrix b){
   Matrix result = new Matrix(a.rows, a.cols);
   for(int i = 0; i < a.rows; i++){
    for(int j = 0; j < a.cols; j++){
     result.values[i][j] = a.values[i][j] - b.values[i][j]; 
    }
   }
   return result;
 }
 
 float[] toArray(){
  float[] arr = new float[rows+cols]; 
  for(int i = 0; i < rows; i++){
   for(int j = 0; j < cols; j++){
     
   }
  }
 }
}
