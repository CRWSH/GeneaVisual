

class StraightGA extends GA {
  ArrayList<StraightRecOrg> genepool;
  String FitnessType;
  int[][] globalpoints;
  
  StraightGA(int size, float prob, String type){
    super(size, prob);
    genepool = new ArrayList<StraightRecOrg>();
    for(int i=0; i<size; i++)genepool.add(new StraightRecOrg(false));
    FitnessType = type;
    globalpoints = new int[int(genepool.get(0).XMAX)][int(genepool.get(0).YMAX)];
  }
  
  StraightGA(int size, float prob, String type, color c1, color c2){
    super(size, prob);
    genepool = new ArrayList<StraightRecOrg>();
    for(int i=0; i<size; i++)genepool.add(new StraightRecOrg(c1, c2));
    FitnessType = type;
    globalpoints = new int[int(genepool.get(0).XMAX)][int(genepool.get(0).YMAX)];
  }
  
  
  void calculateFitnessScores(int[][] otherglobalpoints){
    
    
    if(FitnessType.equals("Countgoal")){
      int fitness = 0;
      fitnessscores.clear();
      for(int i = 0; i<poolsize; i++) {
        if(genepool.get(i).endcount <= COUNTGOAL) fitness = genepool.get(i).endcount;
        else fitness = (2*COUNTGOAL) - genepool.get(i).endcount;
        fitnessscores.append(fitness);
      }
    }
    if(FitnessType.equals("areacompete")){
      fitnessscores.clear();
       for(int k = 0; k<poolsize; k++){
         int total = 0, inarea = 0;
         for(int i = 0; i<genepool.get(0).XMAX; i++){
           for(int j = 0; j<genepool.get(0).YMAX; j++){
            if(genepool.get(k).recursivepoints[i][j] == 1 ) {
              total++;
              if(otherglobalpoints[i][j] == 0) inarea++;
            }
           }
         }
         if(total != 0) {
           fitnessscores.append(float(inarea)/total);
         }
         else {
           fitnessscores.append(0.0);
         }
         print("org "+k+": inarea: "+inarea+" total: "+total+"\n");
       }
    }
       
     
      
    }
    
    
  
  
  void nextGeneration (){
     ArrayList<StraightRecOrg> tempgenepool = new ArrayList<StraightRecOrg>();
     temptourpool = new  IntList();
     float fitness1, fitness2;
     int index1, index2;
     StraightRecOrg parent1, parent2;
     
     globalpoints = new int[int(genepool.get(0).XMAX)][int(genepool.get(0).YMAX)];
     
     for(int i=0; i<genepool.size(); i++) temptourpool.append(i);
     
     while(tempgenepool.size() < genepool.size()) {
     
       index1 = choosePoolFill();
       index2 = choosePoolFill();
     
       fitness1 = fitnessscores.get(index1);
       fitness2 = fitnessscores.get(index2);
     
       if(fitness1 > fitness2) parent1 = genepool.get(index1);
       else parent1 = genepool.get(index2);
     
       index1 = choosePoolFill();
       index2 = choosePoolFill();
     
       fitness1 = fitnessscores.get(index1);
       fitness2 = fitnessscores.get(index2);
     
       if(fitness1 > fitness2) parent2 = genepool.get(index1);
       else parent2 = genepool.get(index2);
       
       tempgenepool.add(mateParents(parent1, parent2));
     }
     
     genepool.clear();
     genepool = tempgenepool;
  }
  
  
  
   StraightRecOrg mateParents (StraightRecOrg p1, StraightRecOrg p2) {
     StraightRecOrg offspring;
     offspring = p1.crossOver(p2);
     if(random(1) < mutationprob) offspring.mutate();
     return offspring; 
   }
   
   void blurGlobalPoints (){
     for (int i = 1; i<(genepool.get(0).XMAX-1); i++) {
       for (int j = 1; j<(genepool.get(0).YMAX-1); j++) {
         if(globalpoints[i][j] == 1){
           globalpoints[i-1][j-1] = 1;
           globalpoints[i][j-1] = 1;
           globalpoints[i+1][j-1] = 1;
           globalpoints[i-1][j] = 1;
           globalpoints[i+1][j] = 1;
           globalpoints[i-1][j+1] = 1;
           globalpoints[i][j+1] = 1;
           globalpoints[i+1][j+1] = 1;
         }
       }
     }
   }
   
   void sortByBranchLevel() {
     ArrayList<StraightRecOrg> sortedpool = new ArrayList<StraightRecOrg>();
     temptourpool = new IntList(tourpool.array());
     int level = 0;
     for(int j = 0; j<genepool.get(0).RECMAX; j++){
       for(int i=0; i<temptourpool.size(); i++){
         if(genepool.get(temptourpool.get(i)).maxbranchlevel == level){
           sortedpool.add(genepool.get(temptourpool.get(i)));
           temptourpool.remove(i);
           i--;
         }
         level++;
       }
     }
    genepool = sortedpool;
   }
  
}


