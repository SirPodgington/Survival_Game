// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

-
*/

import ddf.minim.*;
Minim minim;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store true/false values for all possile keys to detect keypresses

// Background, View (the game screen, exempt from the UI), World, User Interface variables
float ui_Height = 100;
float view_Left_Boundry = 0;
float view_Right_Boundry = width;
float view_Top_Boundry = 0;
float view_Bottom_Boundry = height - ui_Height;
float view_Width = view_Right_Boundry - view_Left_Boundry;
float view_Height = view_Bottom_Boundry - view_Top_Boundry;
float ui_Start_X = view_Left_Boundry;
float ui_Start_Y = view_Bottom_Boundry;
float ui_Width = view_Right_Boundry - view_Left_Boundry;
float cdBarHeight = 50;
float cdBarWidth = 20;
float cdBarTop = view_Bottom_Boundry + 10;
float cdBarBottom = cdBarTop + cdBarHeight;
PImage cannonIcon = loadImage("CannonIcon.png");
float cannonBarX = 20;
float cannonIconY = cdBarBottom + 10;

void setup()
{
   minim = new Minim(this);
   size(1000, 700);
   
   Tank player = new Tank(width/2, view_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D');
   game_Objects.add(player);
}


// Key is true when pressed
void keyPressed()
{
  keys[keyCode] = true;
}

// Key is false when released
void keyReleased()
{
  keys[keyCode] = false;
  
}


void draw()
{
   background(0);
   
   // Mouse becomes crosshair when over the playing screen, arrow when over User Interface
   if (mouseY < view_Bottom_Boundry)
      noCursor();
   else
      cursor(ARROW);
  
  // Render & update all game objects
  for(int i = game_Objects.size() - 1;  i >= 0;  i --)
  {
     GameObject object = game_Objects.get(i);
     object.update();
     object.render();
  }
  
  // User Interface - To include things like Cooldown timers, player health, (score?)
  fill(255);
  stroke(255);
  strokeWeight(2);
  rect(ui_Start_X, ui_Start_Y, ui_Width, ui_Height); // UI BackgroundS
  
  // Cannon cooldown bar
  int cannonVal = game_Objects.get(0).cooldown2;   // Store cannon cd timer value from the player object (first entry)
  float cannonProgress = map(cannonVal, 0, 300, 0, cdBarHeight);
  
  stroke(0);
  strokeWeight(2);
  fill(255);
  rect(cannonBarX, cdBarTop, cdBarWidth, cdBarHeight);   // Bar template  
  fill(255,0,0);
  rect(cannonBarX, cdBarBottom, cdBarWidth, -cannonProgress);   // Bar progress
  image(cannonIcon, cannonBarX, cannonIconY);
}