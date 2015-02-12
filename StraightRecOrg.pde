

class StraightRecOrg extends RecOrg {
  boolean end, enddraw;
  int count = 0, lastpoint = 0, maxbranchlevel = 0;
  int levelcount;
  float[][] recursivelist; 
  int[][] recursivepoints;
 
  
  StraightRecOrg(float xpos, float ypos) {
    super(xpos,ypos);
  }
  
  StraightRecOrg(boolean empty){
    super(empty);
  }
  
  StraightRecOrg(color color1, color color2){
    super(color1, color2);
  }
  
  
  void initRecursive() {
    end = false;
    enddraw = false;
    count = 0;
    endcount = 0;
    lastpoint = 0;
    levelcount = 1;
    recursivelist = new float[int(RECMAX)][6];
    recursivepoints = new int[int(XMAX)][int(YMAX)];
    recursivelist[0][0] = x0;
    recursivelist[0][1] = y0;
    recursivelist[0][2] = 0;
    recursivelist[0][3] = 0;
    recursivelist[0][3] = 0;
  }
  
  void calculateRecursive() {
    float x1, x2, y1, y2;
    float dis1, dis2;
    int xrange, yrange;
    float x, y;
    float branch, branchlevel;
    while(count < RECMAX && end == false ){
      x = recursivelist[count][0];
      y = recursivelist[count][1];
      branch = recursivelist[count][2];
      branchlevel = recursivelist[count][3];
      if(branchlevel > maxbranchlevel)maxbranchlevel = int(branchlevel);
      //print("read:  "+x+" "+y+" "+branch+" "+branchlevel+" "+recursivelist[count][4]+" "+recursivelist[count][5]+" "+count+"\n"); 
      if(x == 0 && y == 0) {
        end = true;
        endcount = count;
        
      }
      count++;
      if (x>0.0 && y>0.0 && x<1.0 && y<1.0) { 
        xrange = int(map(x, 0.0, 1.0, 0.0, XMAX));
        yrange = int(map(y, 0.0, 1.0, 0.0, YMAX));
        
        x1=output(x1rec, x, y);
        x2=output(x2rec, x, y);
        y1=output(y1rec, x, y);
        y2=output(y2rec, x, y);
        dis1 = sqrt(sq(x-x1)+sq(y-y1));
        dis2 = sqrt(sq(x-x2)+sq(y-y2));
        if(lastpoint < RECMAX - 2) {
          branchlevel++;
          if (dis1 > MINDIS) {
            lastpoint++;
            recursivelist[lastpoint][0] = x1;
            recursivelist[lastpoint][1] = y1;
            recursivelist[lastpoint][2] = 0;
            recursivelist[lastpoint][3] = branchlevel;
            recursivelist[lastpoint][4] = xrange;
            recursivelist[lastpoint][5] = yrange;
            
            //print("write:  "+x1+" "+y1+" "+branch+" "+branchlevel+" "+lastpoint+"\n"); 
          }
          if (dis2 > MINDIS) {
            lastpoint++;
            recursivelist[lastpoint][0] = x2;
            recursivelist[lastpoint][1] = y2;
            recursivelist[lastpoint][2] = 1;
            recursivelist[lastpoint][3] = branchlevel;
            recursivelist[lastpoint][4] = xrange;
            recursivelist[lastpoint][5] = yrange;
            //print("read:  "+x1+" "+y1+" "+branch+" "+branchlevel+" "+lastpoint+"\n"); 
          } 
        }
          
    }
    }
    if(count == RECMAX) {
      end = true;
      endcount = count;
    } 
  }
  
  
  
  StraightRecOrg crossOver(StraightRecOrg otherRecOrg){
    
    StraightRecOrg newRecOrg = new StraightRecOrg(color1, color2);
    
    //x en y
    
     switch(int(random(2))) {
       case 0:
       newRecOrg.x0 = x0;
       break;
       case 1:
       newRecOrg.x0 = otherRecOrg.x0;
       break;
     }
     
     switch(int(random(2))) {
       case 0:
       newRecOrg.y0 = y0;
       break;
       case 1:
       newRecOrg.y0 = otherRecOrg.y0;
       break;
     }
     
     newRecOrg.x1rec = crossOverRec(x1rec, otherRecOrg.x1rec);
     newRecOrg.x2rec = crossOverRec(x2rec, otherRecOrg.x2rec);
     newRecOrg.y1rec = crossOverRec(y1rec, otherRecOrg.y1rec);
     newRecOrg.y2rec = crossOverRec(y2rec, otherRecOrg.y2rec);
     
     return newRecOrg;
  }
  
  void printRecursivePoints() {
    for(int i=0; i<XMAX; i++){
      for(int j=0; j<YMAX; j++){
       print(recursivepoints[i][j]);
      }
     print("\n");
    }
  }
 
 int[][] drawNextBranchLevel(int[][] globalpoints) {
   enddraw = true;
   int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
   int level;
   //print("levelcount: "+levelcount+"\n");
   for(int i=0; i<endcount; i++) {
     //print("i: "+i+"\n");
     level = int(recursivelist[i][3]);
     //print("branchlevel: "+level+"\n");
     //print((levelcount == level)+"\n");
     if(levelcount == level){
       //print("hello");
       x1 = int(recursivelist[i][4]);
       y1 = int(recursivelist[i][5]);
       x2 = int(map(recursivelist[i][0], 0.0, 1.0, 0.0, XMAX));
       y2 = int(map(recursivelist[i][1], 0.0, 1.0, 0.0, XMAX));
      
       //print(x1+" "+y1+" "+x2+" "+y2+"\n");
      if(x2 >0 && x2<XMAX && y2>0 && y2<YMAX){
       globalpoints = SetLineInArray(x1, y1, x2, y2, globalpoints);
       enddraw = false;
       switch(int(recursivelist[i][2])) {
         case 0:
         stroke(hue(color1), saturation(color1), (1-(float(i)/(endcount*BLACK)))*255, COLORALPH);
         break;
         case 1:
       stroke(hue(color2), saturation(color2), (1-(float(i)/(endcount*BLACK)))*255, COLORALPH);
         break;
       }
         strokeJoin(ROUND);
         strokeCap(ROUND);
         strokeWeight(4.0);
         line(x1, y1, x2, y2);
      }
     }
     
   }
   levelcount= levelcount + 1;
   return globalpoints;
 }
 
 int[][] SetLineInArray(int x1, int y1, int x2, int y2, int[][] globalpoints) {
   float rico;
   int x, y, ydis, xdis;
   rico = float(y2 - y1)/(x2- x1);
   ydis = abs(y2-y1);
   xdis = abs(x2-x1);
   if(xdis > ydis){ 
     if(x2 > x1) {
       for(int i= x1; i<=x2; i++){
         y = int(rico*(i-x1) + y1);
         recursivepoints[i][y] = 1;
         globalpoints[i][y] = 1;
       }
     }
     else {
        for(int i= x2; i<=x1; i++){
         y = int(rico*(i-x1) + y1);
         recursivepoints[i][y] = 1;
         globalpoints[i][y] = 1;
       }
     }
   }
   else {
     if(y2 > y1) {
       for(int i= y1; i<=y2; i++){
         x = int(((i-y1)/rico)+x1);
         recursivepoints[x][i] = 1;
         globalpoints[x][i] = 1;
       }
     }
     else {
       for(int i= y2; i<=y1; i++){
         x = int(((i-y1)/rico)+x1);
         recursivepoints[x][i] = 1;
         globalpoints[x][i] = 1;
       }
     }
   }
   return globalpoints;
 }
       
         
     
     
        
  
       
   
   
       
    
  
  
  
}


