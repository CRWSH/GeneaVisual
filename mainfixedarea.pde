


StraightGA ga1, ga2;
color color1, color2, color3, color4;
int drawselect = 0;
int [][] area1, area2;


void setup(){
  
  colorMode(HSB);
  color1 = color((82.0/360)*255, (88.0/100.0)*255.0, 255);
  color2 = color((22.0/360)*255, 255, 255);
  size(400, 400);
  frameRate(24);
  ga1 = new StraightGA(40, 0.5, "areacompete", color1, color2);
  ga2 = new StraightGA(40, 0.5, "areacompete");
  area1 = new int[int(ga1.genepool.get(0).XMAX)][int(ga1.genepool.get(0).YMAX)];
  area2 = new int[int(ga1.genepool.get(0).XMAX)][int(ga1.genepool.get(0).YMAX)];
  for (int i = 0; i<(ga1.genepool.get(0).XMAX); i++) {
       for (int j = 0; j<(ga1.genepool.get(0).YMAX); j++) {
         if(i<110) area1[i][j] = 1;
         if(i>150) area2[i][j] = 1;
       }
  }
         
  for(int i =0; i < ga1.poolsize; i++) {
    ga1.genepool.get(i).initRecursive();
    ga1.genepool.get(i).calculateRecursive();
    ga2.genepool.get(i).initRecursive();
    ga2.genepool.get(i).calculateRecursive();
  }
  background(0);
}

void draw(){
  
  fill(0, ALPH);
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
  switch(FITTYPECOUNT)
  {
    case 0:
    print("green fitness\n");
    ga1.calculateFitnessScores(area1);
    print("\n\n");
    print("purple fitness\n");
    ga2.calculateFitnessScores(area2);
    print("\n\n");
    break;
    
    case 1:
    ga1.blurGlobalPoints();
    ga1.blurGlobalPoints();
    ga2.blurGlobalPoints();
    ga2.blurGlobalPoints();
    print("green fitness\n");
    ga1.calculateFitnessScores(area1);
    print("\n\n");
    print("purple fitness\n");
    ga2.calculateFitnessScores(ga1.globalpoints);
    print("\n\n");
    break;
    
    case 2:
    ga1.blurGlobalPoints();
    ga1.blurGlobalPoints();
    ga2.blurGlobalPoints();
    ga2.blurGlobalPoints();
    print("green fitness\n");
    ga1.calculateFitnessScores(ga2.globalpoints);
    print("\n\n");
    print("purple fitness\n");
    ga2.calculateFitnessScores(area2);
    print("\n\n");
    break;
    
    case 3:
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
    break;
    
    case 4:
    int [][] empty = new int[1][1];
    print("green fitness\n");
    ga1.calculateFitnessScores(empty);
    print("\n\n");
    print("purple fitness\n");
    ga2.calculateFitnessScores(empty);
    print("\n\n");
    break;
  }
 
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






    
    
  
  








