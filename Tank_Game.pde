// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

-
*/

import ddf.minim.*;
Minim minim;

// Background, Viewport, User Interface variables
float viewPort_Left_Boundry, viewPort_Right_Boundry, viewPort_Top_Boundry, viewPort_Bottom_Boundry;
float viewPort_Width = ;
float viewPort_Height = ;
float world_Width = ;
float world_Height = ;;

float uiStartX = viewPort_Left_Boundry;
float uiStartY = viewPort_Bottom_Boundry;
float uiHeight = height - viewPort_Bottom_Boundry;
float uiWidth = viewPort_Right_Boundry - viewPort_Left_Boundry;

void setup()
{
   minim = new Minim(this);
   size(1000, 700);
   
   viewPort_Left_Boundry = 0;
   viewPort_Right_Boundry = width;
   viewPort_Top_Boundry = 0;
   viewPort_Bottom_Boundry = 600;
   
   Tank player = new Tank(width/2, viewPort_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D');
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
   
   if (mouseY < viewPort_Bottom_Boundry)
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
  
  fill(255);
  stroke(255);
  strokeWeight(2);
  rect(uiStartX, uiStartY, uiWidth, uiHeight);
  
  float cdBarHeight = 50;
  float cdBarWidth = 20;
  float cdBarTop = viewPort_Bottom_Boundry + 10;
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