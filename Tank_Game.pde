// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

-
*/

import ddf.minim.*;
Minim minim;

// Screen boundry variables
float lBoundry, rBoundry, tBoundry, bBoundry;

void setup()
{
   minim = new Minim(this);
   size(1000, 700);
   
   lBoundry = 0;
   rBoundry = width;
   tBoundry = 0;
   bBoundry = 600;
   
   Tank player = new Tank(width/2, bBoundry*0.9f, 'W', 'S', 'A', 'D');
   gameObjects.add(player);
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
  
}


void draw()
{
   background(0);
   
   if (mouseY < bBoundry)
      noCursor();
   else
      cursor(ARROW);
   
  for(int i = gameObjects.size() - 1;  i >= 0;  i --)
  {
     GameObject object = gameObjects.get(i);
     object.update();
     object.render();
  }
  
  // User Interface - To include things like Cooldown timers, player health, (score?)
  float uiStartX = lBoundry;
  float uiStartY = bBoundry;
  float uiHeight = height - bBoundry;
  float uiWidth = rBoundry - lBoundry;
  
  fill(255);
  stroke(255);
  strokeWeight(2);
  rect(uiStartX, uiStartY, uiWidth, uiHeight);
  
  float cdBarHeight = 50;
  float cdBarWidth = 20;
  float cdBarTop = bBoundry + 10;
  float cdBarBottom = cdBarTop + cdBarHeight;
  
  // Cannon cooldown bar
  PImage cannonIcon = loadImage("CannonIcon.png");
  int cannonVal = gameObjects.get(0).cooldown2;   // Store cannon cd timer value from the player object (first entry)
  float cannonProgress = map(cannonVal, 0, 300, 0, cdBarHeight);
  float cannonBarX = 20;
  float cannonIconY = cdBarBottom + 10;
  
  stroke(0);
  strokeWeight(2);
  fill(255);
  rect(cannonBarX, cdBarTop, cdBarWidth, cdBarHeight);   // Bar template  
  fill(255,0,0);
  rect(cannonBarX, cdBarBottom, cdBarWidth, -cannonProgress);   // Bar progress
  image(cannonIcon, cannonBarX, cannonIconY);
}