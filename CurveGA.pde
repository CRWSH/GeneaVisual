class CurveGA extends GA {
  ArrayList<CurveRecOrg> genepool;
  
  CurveGA(int size, float prob){
    super(size, prob);
    genepool = new ArrayList<CurveRecOrg>();
    for(int i=0; i<size; i++)genepool.add(new CurveRecOrg(false));
  }
  
   float calculateFitness (CurveRecOrg org) {
    int fitness;
    if(org.endcount <= COUNTGOAL) fitness = org.endcount;
    else fitness = (2*COUNTGOAL) - org.endcount;
    return fitness;
  }
  
  void calculateFitnessScores(){
    fitnessscores.clear();
    for(int i = 0; i<genepool.size(); i++) fitnessscores.append(calculateFitness(genepool.get(i)));
  }
  
  void nextGeneration (){
     ArrayList<CurveRecOrg> tempgenepool = new ArrayList<CurveRecOrg>();
     temptourpool = new  IntList();
     float fitness1, fitness2;
     int index1, index2;
     CurveRecOrg parent1, parent2;
     
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
  
  
  
   CurveRecOrg mateParents (CurveRecOrg p1, CurveRecOrg p2) {
     CurveRecOrg offspring;
     offspring = p1.crossOver(p2);
     if(random(1) < mutationprob) offspring.mutate();
     return offspring; 
   }
   
   
  
}
