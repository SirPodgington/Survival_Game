// OOP Assignment 2 draft ... testing tank game idean out

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
   
  for(int i = gameObjects.size() - 1;  i >= 0;  i --)
  {
     GameObject object = gameObjects.get(i);
     object.update();
     object.render();
  }
  
  stroke(255);
  strokeWeight(2);
  line(0, bBoundry, width, bBoundry);
}