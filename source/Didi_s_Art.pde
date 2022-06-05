import java.lang.*;
import java.awt.*;
import javax.swing.*;
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import ddf.minim.*;

import controlP5.*;
ControlP5 cp5;

int ismusic=0;
Minim minim;
AudioPlayer kick;

PImage photo;
String pathstr=".\\data\\1.png";
String path1;

ArrayList<Particle> particles;
Attractor attractor;

VerletPhysics2D physics;

int flag=0;
int q=0;

int StartX=150;
int StartY=0;
int rectWidth=200;
int rectheight=100;

ArrayList<PVector> v=new ArrayList<PVector>();
float mts = PI/24;//max theta speed.
int r = 100;//radius of the circle
int rdtr = 5;//range of the rdt
int rdu = 10;//radius of circle
//**********
boolean mv = true;
boolean mo = true;
int num=500;
color colo[] = new color[num];//color of each point.
float theta[] = new float[num];//original angle of each point.
float mtheta[] = new float[num];//translate angle to math value.
float dtheta[] = new float[num];//speed of theta.
float easing[] = new float[num];
int rdt[] = new int[num];//make a shuffle of radius.
////////////////////////////////////////////////////////////
//text
int index=0;
Module[] mods;
int iseffects = 0;
boolean isFocus = false;
PVector mouse = new PVector(320, 200);
float a1 = 0;
float b1 = 0;
float a2 = 0;
float b2 = 0;
///////////////////////////////
color textc=color(0,0,255);
color bc=color(0);
boolean[] b=new boolean[4];
Status status;
boolean p1, p2, p3, p4;
boolean change=false, collapse=false;


void setup() {
  size(600, 400);
  setControlPanel();
  background(0);
  //sound
  minim=new Minim(this);
  kick=minim.loadFile(".\\data\\Panta.Q .mp3");
  if (kick==null) println("Didn't get kick");
  //Image
  photo=loadImage(pathstr);
   createText1(40);
  ///////////////////////////////////////////////////////
}
void draw() {

 
  //sound
  if(flag!=6)
  background(0);
  for (int i=0; i<kick.bufferSize()-1; i++) {
    float x1=map(i, 0, kick.bufferSize(), 0, width);
    float x2=map(i+1, 0, kick.bufferSize(), 0, width);
    stroke(0, 0, 255,128);
    line(x1+100, 350-kick.mix.get(i)*50, x2+100, 350-kick.mix.get(i+1)*50);
  }
  //////////////////////////////////////////////////////////////////
  if (flag==0||flag==2) {
   // background(0);
    photo.resize(width/3*2, height/3*2);
    image(photo, StartX, height/6);
     createText1(40);
  }
  if (flag==1) {
    //background(0);
    createText1(40);
    for (int i=0; i<width/3*2; i+=30-q) {
      for (int j=0; j<height/3*2; j+=30-q) {
        color c=photo.get(i, j);
        fill(c);
        stroke(c);
        ellipseMode(CORNER);
        ellipse(i+StartX, j+height/6, 30-q, 30-q);
      }
    }
    if (q<19)
      q+=1;
  }

  if (flag==3) {
    createText1(40);
   // background(0);
    physics.update();
    attractor.display();
    for (Particle p : particles) {
      p.display();
    }

    if (mousePressed&&mouseX>120) {
      attractor.lock();
      attractor.set(mouseX, mouseY);
    } else {
      attractor.unlock();
    }
  }
  if (flag==4&&mouseX>120) {
    createText1(40);
     //background(0);
    pushMatrix();
    noStroke();
    if (mv) {
      if (mo) {
        for (int i = 0; i<v.size(); i++) {
          mtheta[i] += dtheta[i];
          v.get(i).lerp(mouseX+cos(mtheta[i])*(rdt[i]+r), mouseY+sin(mtheta[i])*(rdt[i]+r), 0, easing[i]);
          fill(colo[i]);
          ellipse(v.get(i).x, v.get(i).y, rdu, rdu);
        }
      }
      if (!mo) {
        for (int i = 0; i<v.size(); i++) {
          v.get(i).lerp(mouseX+cos(mtheta[i])*(rdt[i]+r), mouseY+sin(mtheta[i])*(rdt[i]+r), 0, easing[i]);
          fill(colo[i]);
          ellipse(v.get(i).x, v.get(i).y, rdu, rdu);
        }
      }
    }
    if (!mv) {
      if (mo) {
        for (int i = 0; i<v.size(); i++) {
          mtheta[i] += dtheta[i];
          v.get(i).lerp(mouseX+cos(mtheta[i])*rdt[i], mouseY+sin(mtheta[i])*rdt[i], 0, easing[i]);
          fill(colo[i]);
          ellipse(v.get(i).x, v.get(i).y, rdu, rdu);
        }
      }
      if (!mo) {
        for (int i = 0; i<v.size(); i++) {
          v.get(i).lerp(mouseX+cos(mtheta[i])*rdt[i], mouseY+sin(mtheta[i])*rdt[i], 0, easing[i]);
          fill(colo[i]);
          ellipse(v.get(i).x, v.get(i).y, rdu, rdu);
        }
      }
    }
    popMatrix();
    //fill(0);
    //textSize(10);
    //rect(0, 0, width, 15);
    //fill(255);
    //textAlign(LEFT, TOP);
    //text("r = "+r, 0, 0);
    //text("fps = "+round(frameRate), 40, 0);
    //if (mv) {
    //  fill(255, 0, 0);
    //  text("Running", 100, 0);
    //}
    //if (!mv) {
    //  text("Static", 100, 0);
    //}
    //if (mo) {
    //  fill(255, 0, 0);
    //  text("motion", 150, 0);
    //}
    //if (!mo) {
    //  fill(255);
    //  text("stop", 150, 0);
    //}
  }
  if (flag==5) {
  // background(0);
    if (cp5.get(Textfield.class, "input").isMouseOver()) {
      isFocus=true;
    } else {
      if (isFocus==true) {
        createText();
        startModule();
      }
      isFocus=false;
    }
    float radius=cp5.getController(" ").getValue();
    if (mousePressed == true && mouseX>120) { 
      mouse = new PVector(mouseX, mouseY);
    }
    fill(0);
    stroke(0,0,180);
    strokeWeight(2);
    ellipse(mouse.x, mouse.y, 24, 24);
    for (int i = 0; i<index; i++) {

      mods[i].seek(mouse, iseffects);

      int j = (int)map(i, 0, index-1, 0, kick.bufferSize()-1);
      float kickmix = 20*kick.mix.get(j/2);

      if (ismusic==1) kickmix = 0;

      mods[i].update(50, 5, radius);
      mods[i].display(0, map(mods[i].xOffset, a1, a2, (a2-a1)/random(2, 5)+a1, a2-(a2-a1)/random(2, 5)), kickmix, iseffects);
    }
  }
 
  if (flag==6) {
    //background(0);
    //createText1(70);
    collapse=true;
    if (collapse) {
    if (change) {
      update(0);
      change=false;
    } else {
      update(1);
      change=true;
    }
  }
   
  }
}




void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    if (theEvent.getController().getName()=="open") {
      flag=0;
      JFileChooser chooser = new JFileChooser();
      chooser.showOpenDialog(null);
      pathstr=chooser.getSelectedFile().getAbsolutePath();
      pathstr=pathstr.replaceAll("\\\\", "\\\\\\\\");
      photo=loadImage(pathstr);
      photo.resize(width/3*2, height/3*2);
      image(photo, StartX, height/6);
    }
    if (theEvent.getController().getName()=="Perler Bead") {
      flag=1;
    }
    if (theEvent.getController().getName()=="reset") {
      flag=2;
      q=0;
    }
    if (theEvent.getController().getName()=="Drag") {
      flag=3;
      photo=loadImage(pathstr);
      photo.resize(width/3*2, height/3*2);
      setPicture();
    }
    if (theEvent.getController().getName()=="Dance") {
      flag=4;
      photo=loadImage(pathstr);
      photo.resize(width/3*2, height/3*2);
      v.clear();
      setPicture();
    }
    if (theEvent.getController().getName()=="start") {
      ismusic=0;
      kick.play();
    }
    if (theEvent.getController().getName()=="pause") {
      ismusic=1;
      kick.pause();
    }
    if (theEvent.getController().getName()=="confirm") {
      flag=5;
    }
    if (theEvent.getController().getName()=="style1") {
      iseffects=0;
    }
    if (theEvent.getController().getName()=="style2") {
      iseffects=1;
    }
     if (theEvent.getController().getName()=="destory") {
      flag=6;
    }
  }
}

void mousePressed() {
 
  mv = !mv;
  
}
void keyPressed() {
  if (key == 's'||key == 'S') {
    mo =!mo;
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e == -1) r+=10;
  if (e == 1) r-=10;
}

void setControlPanel() {
  cp5=new ControlP5(this);
  cp5.addButton("open").setPosition(10, 50);
  cp5.addButton("reset").setPosition(10, 75);
  cp5.addButton("Perler Bead").setPosition(10, 100);
  cp5.addButton("Drag").setPosition(10, 125);
  cp5.addButton("Dance").setPosition(10, 150);
  cp5.addButton("start").setPosition(10, 175);
  cp5.addButton("pause").setPosition(10, 200);
  cp5.addTextfield("input").setSize(70, 20).setPosition(10, 250).setText("Love");
  cp5.addButton("confirm").setPosition(10, 300);
  cp5.addSlider(" ").setSize(70, 20).setPosition(10, 275).setRange(0, 18).setValue(5);
  cp5.addButton("style1").setPosition(10, 325);
  cp5.addButton("style2").setPosition(10, 350);
  cp5.addButton("destory").setPosition(10,375);
}

void setPicture() {
  physics=new VerletPhysics2D();
  physics.setDrag (0.05);
  int k=0;
  particles = new ArrayList<Particle>();
  for (int i=0; i<width/3*2; i+=20)
    for (int j=0; j<height/3*2; j+=20) {

      color c=photo.get(i, j);
      particles.add(new Particle(new Vec2D(i+StartX, j+height/6), c));
      //////////////////////////////
      v.add(new PVector(i+StartX, j+height/6));
      colo[k]=color(c);
      theta[k] = round(random(360));
      dtheta[k] = random(mts);
      mtheta[k] = theta[i]/180*PI;
      rdt[k] = round(random(-rdtr, rdtr));
      easing[k] = random(0.02, 0.1);
      k++;
    }
  attractor=new Attractor(new Vec2D(width/3+StartX, height/3+50));
}

void createText() {
  rectMode(CORNER);
  textFont(createFont(".\\data\\FZSTK.TTF", 36));
  textAlign(CENTER);
  textSize(100);
  fill(255, 255, 250);
  text(cp5.get(Textfield.class, "input").getText(), width/3-100, height/2-20);
}

void createText1(int a) {
  //rectMode(CORNER);
  PFont font=createFont(".\\data\\aventura-rough.woff.ttf", a);
  textAlign(CENTER);
  textFont(font);
  fill(textc);
  text("Flowing Paint", width/2+50, 45);
}


void startModule() {
  int count=0;
  index=0;
  for (int i=0; i<600; i+=3) {
    for (int j=0; j<400; j+=3) {
      color c=get(i, j);
      if (c==color(255, 255, 250)) {
        count++;
      }
    }
  }
  mods=new Module[count];
  for (int i=0; i<600; i+=3) {
    for (int j=0; j<400; j+=3) {
      color c=get(i, j);
      if (c==color(255, 255, 250)) {
        mods[index]=new Module(i, j, random(-3, 3), index, colo[int(random(1, 200))]);
        mods[index].update(50, 5, 5);
        mods[index].display(0, 0, 0, iseffects);
        index++;
      }
    }
  }
  a1 =  mods[0].xOffset;
  b1 =  mods[0].yOffset;
  a2 =  mods[index-1].xOffset;
  b2 =  mods[index-1].yOffset;
}


void update(int g) {
  // 4 pixel into 1 pixel
  for (int i=g; i<width-1; i+=2) {
    for (int j=g; j<height-1; j+=2) {
      // get the text color
      if (get(i, j)==textc) {
        p1=true;
      } else {
        p1=false;
      }
      if (get(i+1, j)==textc) {
        p2=true;
      } else {
        p2=false;
      }
      if (get(i, j+1)==textc) {
        p3=true;
      } else {
        p3=false;
      }    
      if (get(i+1, j+1)==textc) {
        p4=true;
      } else {
        p4=false;
      }

      status=new Status(p1, p2, p3, p4);  // create the Status
      b=status.output();  // update

      // color the cell
      if (b[0]==true) {
        set(i, j, textc);
      } else {
        set(i, j, bc);
      }
      if (b[1]==true) {
        set(i+1, j, textc);
      } else {
        set(i+1, j, bc);
      }
      if (b[2]==true) {
        set(i, j+1, textc);
      } else {
        set(i, j+1, bc);
      }
      if (b[3]==true) {
        set(i+1, j+1, textc);
      } else {
        set(i+1, j+1, bc);
      }
    }
  }
}
