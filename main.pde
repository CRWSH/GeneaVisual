/*
StraightGA ga1, ga2;
color color1, color2, color3, color4;
int drawselect = 0;


void setup(){
  colorMode(HSB);
  color1 = color((82.0/360)*255, (88.0/100.0)*255.0, 255);
  color2 = color((22.0/360)*255, 255, 255);
  size(700, 700);
  frameRate(24);
  ga1 = new StraightGA(20, 0.01, "areacompete", color1, color2);
  ga2 = new StraightGA(20, 0.99, "areacompete");
  for(int i =0; i < ga1.poolsize; i++) {
    ga1.genepool.get(i).initRecursive();
    ga1.genepool.get(i).calculateRecursive();
    ga2.genepool.get(i).initRecursive();
    ga2.genepool.get(i).calculateRecursive();
  }
  background(0);
}

void draw(){
  fill(0, 6);
  rect(0, 0, width, height);
  
  switch(drawselect){
  
  case 0:
  drawselect = 1;
  for(int i =0; i<ga1.poolsize; i++){
    ga1.globalpoints = ga1.genepool.get(i).drawNextBranchLevel(ga1.globalpoints);
    ga2.globalpoints = ga2.genepool.get(i).drawNextBranchLevel(ga2.globalpoints);
    if(ga1.genepool.get(i).enddraw == false || ga2.genepool.get(i).enddraw == false ) drawselect = 0; 
  }  
  break;
  
  case 1:
  ga1.blurGlobalPoints();
  ga1.blurGlobalPoints();
  ga2.blurGlobalPoints();
  ga2.blurGlobalPoints();
  print("green fitness\n");
  ga1.calculateFitnessScores(ga2.globalpoints);
  print("\n\n");
  print("purple fitness\n");
  ga2.calculateFitnessScores(ga1.globalpoints);
  print("\n\n");
  drawselect = 2;
  break;
 
  case 2:
  print("green & orange: ");
  ga1.printMeanFitness();
  print("\n");
  print("purple & pink: ");
  ga2.printMeanFitness(); 
  print("\n");
  print("\n");  
  ga1.nextGeneration();
  ga2.nextGeneration();
  drawselect = 3;
  break;
  
  case 3:
  for(int i =0; i < ga1.poolsize; i++) {
        ga1.genepool.get(i).initRecursive();
        ga1.genepool.get(i).calculateRecursive();
        ga2.genepool.get(i).initRecursive();
        ga2.genepool.get(i).calculateRecursive();
   }
   drawselect = 0;
   break;
  }  
  
}


*/

    
    
  
  








