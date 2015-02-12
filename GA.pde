

class GA {
  int COUNTGOAL = 60;
  float mutationprob;
  FloatList fitnessscores;
  IntList tourpool, temptourpool;
  int poolsize;

 // ArrayList genepool;

  
  GA (int size, float prob) {
    poolsize = size;
    fitnessscores = new FloatList();
    mutationprob = prob;
    tourpool = new IntList();
    for(int i =0; i<poolsize; i++)tourpool.append(i);
  }   
  
  
  void nextGeneration() {
    print("not definied for general GA class");
  }
  
 
 void printFitnessScores() {
   for(int i=0; i<poolsize; i++){
     print(fitnessscores.get(i)+" ");
   }
   print("\n");
 }
 
 void printMeanFitness() {
   float total = 0.0;
   for(int i=0; i<poolsize; i++){
     total = total + fitnessscores.get(i);
   }
   print(total/poolsize+" ");
 }
   
   
   
  
  int choosePoolFill() {
    int chosen, index;
    index = int(random(temptourpool.size()));
    chosen = temptourpool.get(index);
    temptourpool.remove(index);
    if(temptourpool.size() == 0) {
      for(int i=0; i<poolsize; i++) temptourpool.append(i);
    }
    return chosen;
  }
     
     
     
     
     
    
    

  
  
    
    
      
}


