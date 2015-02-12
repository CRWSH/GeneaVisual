/*

StraightGA ga1, ga2;
color color1, color2, color3, color4;
int drawselect = 0;
int [][] area1, area2;


void setup(){
  
  colorMode(HSB);
  color1 = color((82.0/360)*255, (88.0/100.0)*255.0, 255);
  color2 = color((22.0/360)*255, 255, 255);
  size(200, 200);
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
    print(ga1.genepool.get(i).maxbranchlevel+" ");
    ga2.genepool.get(i).initRecursive();
    ga2.genepool.get(i).calculateRecursive();
  }
  print("\n");
  ga1.sortByBranchLevel();
  
  background(0);
}

*/
