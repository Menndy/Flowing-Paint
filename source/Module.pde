class Module {
  float xOffset;   //the location of particals
  float yOffset;
  float maxunit;   // max radius
  float chaUnit;
  int indexx;  //phase position
  float tt = 0;
  color color1;
  PVector velocity;
  PVector acceleration;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  PVector position1 ;
  float distance;
  PVector retarget = new PVector(600/2, 400/2);
  boolean GGG = true;
  // Contructor
  Module(int xOffsetTemp, int yOffsetTemp, float tempUnit, int tempIndex, color tempColor) {
    xOffset = xOffsetTemp;
    yOffset = yOffsetTemp; 
    maxunit = tempUnit;
    indexx = tempIndex;
    color1 = tempColor;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, -2);
    position1 = new PVector(xOffset, yOffset);
    maxspeed = 4;
    maxforce = 2;
  }

  // Custom method for updating the variables
  void update(float _zhouqi, float xiangwei, float banjing) {
    chaUnit = (banjing+maxunit)* sin(PI/_zhouqi * tt + indexx*(xiangwei/(2*PI)));
    tt++;

    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position1.add(velocity);
    acceleration.mult(0);  //reset
  }

  // Custom method for drawing the object
  void display(int isshape, float GG, float wave, int iseffect) {
    fill(color1);
    noStroke();
    pushMatrix();

    if (iseffect==1) {
      //effect1 
      translate(position1.x, position1.y);
    } else {
      ///222 
      if (distance<10) {
        translate(position1.x-rectWidth/2+xOffset, position1.y-400/2+yOffset);
      } else {
        translate(position1.x-rectWidth/2+GG, position1.y-600/2+yOffset);
      }
    }
    translate(0, -wave);

    if (isshape==0) {
      ellipse(0, 0, chaUnit, chaUnit);//ellipse(xOffset, yOffset, chaUnit, chaUnit);
    } else {
      rect(0, 0, chaUnit, chaUnit);
    }


    popMatrix();
  }



  void seek(PVector target, int iseffect) {
   

    distance = PVector.sub(target, position1).mag();
  

    if (iseffect==1) {
      if (distance >10 && GGG == true) {
        applyForce(PVector.sub(PVector.sub(target, position1), velocity));
      } else {
        applyForce(PVector.sub(PVector.sub(
          new PVector(xOffset+target.x-200/2, yOffset+target.y-400/2), position1), velocity));
        GGG = false;
      }
      if (retarget != target) {
        GGG = true;
      }
      retarget = target;
    } else {
      applyForce(PVector.sub(PVector.sub(target, position1), velocity));  
    }
  }


  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);// update a
  }
}
