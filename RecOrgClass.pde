class RecOrg {
  float XMAX = 700, YMAX = 700, RECMAX = 120, MINDIS = 2/700, OPMAX = 3; //de false statics
  String POSOP = "+-*/", POSIN = "XY";
  ArrayList<JSONObject> x1rec, x2rec, y1rec, y2rec;
  float x0, y0;
  float fitness;
  boolean end = false;
  int endcount = 0;
  color color1, color2;
  
  RecOrg(float xpos, float ypos) {
    
    x0 = xpos;
    y0 = ypos;
    x1rec = createFormula();
    x2rec = createFormula();
    y1rec = createFormula();
    y2rec = createFormula();
    color1 = color((261/360.0)*255, (78/100.0)*255, 255);
    color2 = color((347/360.0)*255, (94/100.0)*255, 255);
  }
  
  
  RecOrg (boolean empty) {
  if(!empty) {
    x0 = random(1.0);
    y0 = random(1.0);
    x1rec = createFormula();
    x2rec = createFormula();
    y1rec = createFormula();
    y2rec = createFormula();
    color1 = color((261/360.0)*255, (78/100.0)*255, 255);
    color2 = color((347/360.0)*255, (94/100.0)*255, 255);
  }
  }
  
  RecOrg (color c1, color c2) {
    x0 = random(1.0);
    y0 = random(1.0);
    x1rec = createFormula();
    x2rec = createFormula();
    y1rec = createFormula();
    y2rec = createFormula();
    color1 = c1;
    color2 = c2;
  }
    
  
    
    
  
  ArrayList<JSONObject> createFormula () {
    int amOp = int(random(OPMAX));
    ArrayList<JSONObject> formula = new ArrayList<JSONObject>();
    JSONObject element;
 
    switch (int(random(2))) {
        case 0:
        element = new JSONObject();
        element.setString("type", "input");
        element.setString("value", str(POSIN.charAt(int(random(POSIN.length())))));
        formula.add(element);
        break;
        
        case 1:
        element = new JSONObject();
        element.setString("type", "cte");
        element.setFloat("value", random(1));
        formula.add(element);
        break;
      }
  
 
    
    for(int i = 0; i<amOp; i++) {
      element = new JSONObject();
      element.setString("type", "operator");
      element.setString("value", str(POSOP.charAt(int(random(POSOP.length())))));
      formula.add(element);
      switch (int(random(2))) {
        case 0:
        element = new JSONObject();
        element.setString("type", "input");
        element.setString("value", str(POSIN.charAt(int(random(POSIN.length())))));
        formula.add(element);
        break;
        
        case 1:
        element = new JSONObject();
        element.setString("type", "cte");
        element.setFloat("value", random(1));
        formula.add(element);
        break;
        
      }
    }
      
    return formula;
    }
    
    
    
    
    float output (ArrayList<JSONObject> formula, float x, float y) {
      float cal = 0;
      
      if(formula.get(0).getString("type").equals("input")) {
        switch(formula.get(0).getString("value").charAt(0)) {
          case 'X':
          //print("X is " + x + "\n");
          cal = x;
          break;
          case 'Y':
          //print("y is " + y + "\n");
          cal = y;
          break;
        }
      }
      if(formula.get(0).getString("type").equals("cte")) 
        cal  = formula.get(0).getFloat("value");
        //print("cst is " + cal + "\n");
      
      if (formula.size() > 1) {
        float last = 0;
        for (int i = 1; i < formula.size(); i= i + 2) {
          
          if(formula.get(i+1).getString("type").equals("input")) {
            switch(formula.get(i+1).getString("value").charAt(0)) {
            case 'X':
            //print("X is " + x + "\n");
            last = x;
            break;
            case 'Y':
            //print("y is " + y + "\n");
            last = y;
            break;
            }
          }
          if(formula.get(i+1).getString("type").equals("cte")) {
            last  = formula.get(i+1).getFloat("value");
            //print("cst is " + last + "\n");
          }
          
          switch (formula.get(i).getString("value").charAt(0)) {
             case '+':
             cal = cal + last;
             break;
             case '-':
             //print("-: cal is " + cal +" last is " + last + "\n"); 
             cal = cal - last;
             //print("result is " + cal + "\n");
             break;
             case '*':
             cal = cal * last;
             break;
             case '/':
             //print("/: cal is " + cal +" last is " + last + "\n"); 
             cal = cal / last;
             //print("result is " + cal + "\n");
             break;
           }
           
        }
      }
      
      return cal;
    }
 
      
    
  
  
  
  
  ArrayList<JSONObject> crossOverRec (ArrayList<JSONObject> rec1, ArrayList<JSONObject> rec2) {
    int crosspoint;
    ArrayList<JSONObject> crossover = new ArrayList<JSONObject>();
    
    if(rec1.size() < rec2.size()) {
        if( rec1.size() == 1)  crosspoint = 0;
        else crosspoint = int(random(rec1.size() - 1));
      }
      else {
        if(rec2.size() == 1) crosspoint = 0;
        else crosspoint = int(random(rec2.size() - 1));
      }
    
    switch(int(random(2))) {
      case 0:
      for(int i=0; i<crosspoint+1; i++) 
      crossover.add(copyElement(rec1.get(i)));
      if(rec2.size() != 1) {
        for(int i=crosspoint + 1; i<rec2.size(); i++)
        crossover.add(copyElement(rec2.get(i)));
      }
      break; 
      case 1:
      for(int i=0; i<crosspoint+1; i++) 
      crossover.add(copyElement(rec2.get(i)));
      if(rec1.size() != 1) {
        for(int i=crosspoint + 1; i<rec1.size(); i++)
        crossover.add(copyElement(rec1.get(i)));
      }
      break;
    }
    
    return crossover;
  }
  
  
  
  
  
  String formulaToString(ArrayList<JSONObject> formula) {
    String stringformula = "";
    for(int i=0; i<formula.size(); i++) {
     if(formula.get(i).getString("type").equals("input")) 
     stringformula = stringformula + formula.get(i).getString("value");
     if(formula.get(i).getString("type").equals("cte"))
     stringformula = stringformula + nf(formula.get(i).getFloat("value"), 1, 5);
     if(formula.get(i).getString("type").equals("operator"))
     stringformula = stringformula + formula.get(i).getString("value");
    }
    return stringformula;
  }
  
  JSONObject copyElement (JSONObject element) {
    JSONObject copy = new JSONObject();
    if(element.getString("type").equals("input")) {
      copy.setString("type", "input");
      copy.setString("value", element.getString("value"));
    }
    if(element.getString("type").equals("cte")) {
      copy.setString("type", "cte");
      copy.setFloat("value", element.getFloat("value"));
    }
    if(element.getString("type").equals("operator")) {
      copy.setString("type", "operator");
      copy.setString("value", element.getString("value"));
    }
    
    return copy;
  }
  
  RecOrg crossOver (RecOrg otherRecOrg) {
    RecOrg newRecOrg = new RecOrg(true);
    
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
  
  
  
  void mutate () {
    float DNAlength;
    float choice = random(1); 
    DNAlength = 2 + x1rec.size() + x2rec.size() + y1rec.size() + y2rec.size();
    
    if(choice < (x1rec.size()/DNAlength)) mutateFormula(x1rec);
    else {
      if(choice >= (x1rec.size()/DNAlength) && choice < ((x1rec.size()+x2rec.size())/DNAlength)) 
      mutateFormula(x2rec);
      else {
        if(choice >= ((x1rec.size()+x2rec.size())/DNAlength) && choice < ((x1rec.size()+x2rec.size()+y1rec.size())/DNAlength))
        mutateFormula(y1rec);
        else {
          if(choice >= ((x1rec.size()+x2rec.size()+y1rec.size())/DNAlength) && choice < ((x1rec.size()+x2rec.size()+y1rec.size()+y2rec.size())/DNAlength))
          mutateFormula(y2rec);
          else {
            switch (int(random(2))) {
              case 0:
              x0 = randomWalk(x0);
              break;
              case 1:
              y0 = randomWalk(y0);
              break;
            }
          }
        }
      }
    }
  }
          
    
      
        

      
  
  
  void mutateFormula (ArrayList<JSONObject> rec) {
    int mutationpoint = int(random(rec.size()+ 1));
    if(mutationpoint == rec.size()) {
      JSONObject element;
      element = new JSONObject();
      element.setString("type", "operator");
      element.setString("value", str(POSOP.charAt(int(random(POSOP.length())))));
      rec.add(element);
      element = new JSONObject();
      switch(int(random(2))) {
        case 0:
        element.setString("type", "input");
        element.setString("value",  str(POSIN.charAt(int(random(POSIN.length())))));
        rec.add(element);
        break;
        case 1:
        element.setString("type", "cte");
        element.setFloat("value",  random(1));
        rec.add(element);
        break;
      }
    }
    else {
        
      if(rec.get(mutationpoint).getString("type").equals("operator")) {
        String oldoperator = rec.get(mutationpoint).getString("value");
        String newoperator = str(POSOP.charAt(int(random(POSOP.length()))));
        while (oldoperator.equals(newoperator)) newoperator = str(POSOP.charAt(int(random(POSOP.length()))));
        rec.get(mutationpoint).setString("value", newoperator);
      }
      else {
        if(rec.get(mutationpoint).getString("type").equals("input")){
          switch(int(random(2))) {
            case 0:
            String oldinput = rec.get(mutationpoint).getString("value");
            String newinput = str(POSIN.charAt(int(random(POSIN.length()))));
            while (oldinput.equals(newinput)) newinput = str(POSIN.charAt(int(random(POSIN.length()))));
            break;
            case 1:
            rec.get(mutationpoint).remove("value");
            rec.get(mutationpoint).setString("type", "cte"); 
            rec.get(mutationpoint).setFloat("value", random(1));
            break;
          }
        }
        else {
          if(rec.get(mutationpoint).getString("type").equals("cte")) {
             switch(int(random(2))) {
             case 0:
             float oldcte = rec.get(mutationpoint).getFloat("value");
             rec.get(mutationpoint).setFloat("value", randomWalk(oldcte));    
             break;
             case 1:
             rec.get(mutationpoint).remove("value");
             rec.get(mutationpoint).setString("type", "input"); 
             rec.get(mutationpoint).setString("value", str(POSIN.charAt(int(random(POSIN.length())))));
             break;
          }
          }
        }
      }
    }
  }
         
  
  void printRecOrg() {
    print("x0="+ x0 + "\n");
    print("y0="+ y0 + "\n");
    print("x1rec="+ formulaToString(x1rec) + "\n");
    print("x2rec="+ formulaToString(x2rec) + "\n");
    print("y1rec="+ formulaToString(y1rec) + "\n");
    print("y2rec="+ formulaToString(y2rec) + "\n");
  }
  
  
  void startRecursive() {
    print("not definied for recorg");
  }
  
  void recursive() {
    print("not definied for recorg");
  }
    
      
  }
  
  

  

      
      
      

