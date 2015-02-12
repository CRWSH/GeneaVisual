//Draw constants

int ALPH = 0, COLORALPH = 64, FITTYPECOUNT = 0; 
float BLACK = 1.0;

float randomWalk (float input) {
  float MIN=0.0, MAX=1.0, RANGE= 0.01;
  float output=0;
 
 switch(int(random(2))) {
   case 0:
   output = input + random(RANGE);
   if(output > MAX) output = (2*MAX) - output;
   break;
   case 1:
   output = input - random(RANGE);
   if(output < MIN) output = (2*MIN) - output;
   break;
 }
   
   
return output;
}

void keyPressed(){
  if(key == '@')
  {
   ALPH = 15;
   print("reset screen");  
  }
  if(key == '&')
  {
   ALPH = 0;
   COLORALPH = 2;
   BLACK = 254;
   print("preset 1");  
  }
  
  if(key == 'a')
  {
    if(ALPH != 15){
     ALPH++;
     print("alpha = "+ALPH+"\n"); 
    }
  }
  if(key == 'q'){
    
    if(ALPH != 0){
     ALPH--;
     print("alpha = "+ALPH+"\n"); 
    }
  }
  if(key == 'z'){
    
    if(COLORALPH < 255){
     COLORALPH = int(COLORALPH * 1.8);
     print("coloralpha = "+COLORALPH+"\n"); 
    }
    if(COLORALPH == 0 )
    {COLORALPH = 1;}
  }
  if(key == 's'){
    
    if(COLORALPH > 0){
     COLORALPH = int(COLORALPH / 1.8);
     print("coloralpha = "+COLORALPH+"\n"); 
    }
  }
  if(key == 'e'){
    
    if(BLACK < 255.0){
     BLACK = BLACK * 1.1;
     print("black = "+BLACK+"\n"); 
    }
  }
  if(key == 'd'){
    
    if(BLACK > 1.0){
     BLACK = BLACK / 1.1;
     print("black = "+BLACK+"\n"); 
    }
  }
  if(key == '^'){
    
    if(ga1.mutationprob < 1.0){
    ga1.mutationprob = ga1.mutationprob + 0.1;
     print("mutationprob population 1 = "+ga1.mutationprob+"\n"); 
    }
  }
   if(key == 'ù'){
    
    if(ga1.mutationprob > 0.0){
    ga1.mutationprob = ga1.mutationprob - 0.1;
     print("mutationprob population 1 = "+ga1.mutationprob+"\n"); 
    }
  }
  if(key == '$'){
    
    if(ga2.mutationprob < 1.0){
    ga2.mutationprob = ga2.mutationprob + 0.1;
     print("mutationprob population 2 = "+ga2.mutationprob+"\n"); 
    }
  }
   if(key == '`'){
    
    if(ga2.mutationprob > 0.0){
    ga2.mutationprob = ga2.mutationprob - 0.1;
     print("mutationprob population 2 = "+ga2.mutationprob+"\n"); 
    }
  }
  if(key == ' '){
    FITTYPECOUNT++;
    if(FITTYPECOUNT == 5)FITTYPECOUNT=0;
    switch(FITTYPECOUNT){
      case 0:
      print("areacompete: ga1=fixedarea ga2=fixedarea");
      break;
      case 1:
      print("areacompete: ga1=fixedarea ga2=compete");
      break;
      case 2:
      print("areacompete: ga1=compete ga2=fixedarea");
      break;
      case 3:
      print("areacompete: ga1=compete ga2=compete");
      break;
      case 4:
      print("Countgoal");
      break;
    }  
  }
}
