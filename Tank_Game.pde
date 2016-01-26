// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

Bullets are off a bit on Y-AXIS
*/

import ddf.minim.*;
Minim minim;

// Screen boundry variables
float lBoundry, rBoundry, tBoundry, bBoundry;
float uiHeight = height - bBoundry;

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
  
  // User Interface
  fill(255);
  stroke(255);
  strokeWeight(2);
  rect(lBoundry, bBoundry, (rBoundry - lBoundry), height-bBoundry);
  
  // Cannon cooldown display
  fill(255);
  stroke(0);
  strokeWeight(1);
  rect(20, bBoundry+15, 20, 50);
}