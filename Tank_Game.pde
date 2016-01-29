// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

- Boundry variables don't take screen width/height into account  ->  Move them to setup later


TO BE ADDED (IDEAS):

- Heat cooldown on machine gun
*/

import ddf.minim.*;
Minim minim;

// Background, View (the game screen, exempt from the UI), World, User Interface variables
float view_Left_Boundry, view_Right_Boundry, view_Top_Boundry, view_Bottom_Boundry;
float view_Width, view_Height;
float ui_Start_X, ui_Start_Y, ui_Width, ui_Height;
float cdBarHeight, cdBarWidth, cdBarTop, cdBarBottom;
float cannonBarX, cannonIconY;
PImage cannonIcon;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store true/false values for all possile keys to detect keypresses


void setup()
{
   minim = new Minim(this);
   size(1000, 700);
   
   // Background, View (the game screen, exempt from the UI), World, User Interface variables
   view_Left_Boundry = 0;
   view_Right_Boundry = width;
   view_Top_Boundry = 0;
   view_Bottom_Boundry = height - 100;
   view_Width = view_Right_Boundry - view_Left_Boundry;
   view_Height = view_Bottom_Boundry - view_Top_Boundry;
   ui_Start_X = view_Left_Boundry;
   ui_Start_Y = view_Bottom_Boundry;
   ui_Height = height - view_Bottom_Boundry;
   ui_Width = view_Right_Boundry - view_Left_Boundry;
   cdBarHeight = 50;
   cdBarWidth = 20;
   cdBarTop = view_Bottom_Boundry + 10;
   cdBarBottom = cdBarTop + cdBarHeight;
   cannonBarX = 20;
   cannonIconY = cdBarBottom + 10;
   cannonIcon = loadImage("CannonIcon.png");   // UI Icon for cannon cooldown
   
   Tank player = new Tank(width/2, view_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D');
   game_Objects.add(player);
   BasicAI enemy1 = new BasicAI();
   game_Objects.add(enemy1);
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