class CurveRecOrg extends RecOrg {
  boolean end;
  int count = 0, lastpoint = 0;
  float[][] points;
  
  CurveRecOrg(float xpos, float ypos) {
    super(xpos,ypos);
  }
  
  CurveRecOrg(boolean empty){
    super(empty);
  }
  
  
  void startRecursive() {
    end = false;
    count = 0;
    endcount = 0;
    lastpoint = 0;
    points = new float[int(RECMAX)][8];
    points[0][0] = x0;
    points[0][1] = y0;
    points[0][2] = 0;
    points[0][3] = 0;
    points[0][4] = 0;
    points[0][5] = 0;
    points[0][6] = 0;
    points[0][7] = 0;
  }
  
  void recursive() {
    float x1, x2, y1, y2;
    float dis1, dis2;
    int xrange, yrange;
    float x, y, x_1, y_1, x_2, y_2, x_3, y_3;
    if(count < RECMAX){
      x = points[count][0];
      y = points[count][1];
      x_1 = points[count][2];
      y_1 = points[count][3];
      x_2 = points[count][4];
      y_2 = points[count][5];
      x_3 = points[count][6];
      y_3 = points[count][7];
      //print("read:  "+x+" "+y+" "+x_1+" "+y_1+" "+x_2+" "+y_2+" "+x_3+" "+y_3+" "+count+"\n"); 
      if(x == 0 && y == 0 && count > 20) {
        end = true;
        endcount = count;
      }
      count++;
      if (x>0.0 && y>0.0 && x<1.0 && y<1.0) { 
        xrange = int(map(x, 0.0, 1.0, 0.0, XMAX));
        yrange = int(map(y, 0.0, 1.0, 0.0, YMAX));
        if(x_1 != 0 && y_1 != 0 && x_2 != 0 && y_2 != 0 && x_3 != 0 && y_3 != 0) {
          noFill();
          stroke(((1.0-count/RECMAX)*255), 127);
          strokeWeight(4);
          curve(x_3, y_3, x_2, y_2, x_1, y_1, xrange, yrange);
        }
        x_3 = x_2;
        y_3 = y_2;
        x_2 = x_1;
        y_2 = y_1;
        x_1 = xrange;
        y_1 = yrange; 
        x1=output(x1rec, x, y);
        x2=output(x2rec, x, y);
        y1=output(y1rec, x, y);
        y2=output(y2rec, x, y);
        dis1 = sqrt(sq(x-x1)+sq(y-y1));
        dis2 = sqrt(sq(x-x2)+sq(y-y2));
        if(lastpoint < RECMAX - 2) {
          if (dis1 > MINDIS) {
            lastpoint++;
            points[lastpoint][0] = x1;
            points[lastpoint][1] = y1;
            points[lastpoint][2] = x_1;
            points[lastpoint][3] = y_1;
            points[lastpoint][4] = x_2;
            points[lastpoint][5] = y_2;
            points[lastpoint][6] = x_3;
            points[lastpoint][7] = y_3;
            //print("write:  "+x1+" "+y1+" "+x_1+" "+y_1+" "+x_2+" "+y_2+" "+x_3+" "+y_3+" "+lastpoint+"\n");
          }
          if (dis2 > MINDIS) {
            lastpoint++;
            points[lastpoint][0] = x2;
            points[lastpoint][1] = y2;
            points[lastpoint][2] = x_1;
            points[lastpoint][3] = y_1;
            points[lastpoint][4] = x_2;
            points[lastpoint][5] = y_2;
            points[lastpoint][6] = x_3;
            points[lastpoint][7] = y_3;
            //print("write:  "+x2+" "+y2+" "+x_1+" "+y_1+" "+x_2+" "+y_2+" "+x_3+" "+y_3+" "+lastpoint+"\n");
          } 
        }
    }
    }
    else {
      end = true;
      endcount = count;
    } 
  }
  
  CurveRecOrg crossOver(CurveRecOrg otherRecOrg){
    
    CurveRecOrg newRecOrg = new CurveRecOrg(true);
    
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
  
  
  
}
