// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

- Boundry variables don't take screen width/height into account  ->  Move them to setup later


TO BE ADDED (IDEAS):

- Heat cooldown on machine gun
- Speedboost cooldown
- 2 more ai units & maybe a boss?
- Airstrike cooldown (one for enemy & player?)
- 
*/

import ddf.minim.*;
Minim minim;

// Background, View (the game screen, exempt from the UI), World, User Interface variables
float view_Left_Boundry, view_Right_Boundry, view_Top_Boundry, view_Bottom_Boundry;
float view_Width, view_Height;
float ui_Start_X, ui_Start_Y, ui_Width, ui_Height;
float cd_Bar_Height, cd_Bar_Width, cd_Bar_Top, cd_Bar_Bottom;
float cannon_Bar_X, cannon_Icon_Y, speed_Bar_X, speed_Icon_Y;
color cd_Bar_Background, cannon_Bar_Colour, speed_Bar_Colour;
PImage cannon_Icon, speed_Icon;

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
   cd_Bar_Height = 50;
   cd_Bar_Width = 20;
   cd_Bar_Top = view_Bottom_Boundry + 10;
   cd_Bar_Bottom = cd_Bar_Top + cd_Bar_Height;
   cd_Bar_Background = color(255);
   cannon_Bar_X = 20;
   cannon_Bar_Colour = color(250,0,0);
   cannon_Icon_Y = cd_Bar_Bottom + 10;
   cannon_Icon = loadImage("cannon_cd_icon.png");   // UI Icon for cannon cooldown
   speed_Bar_X = cannon_Bar_X + 30;
   speed_Bar_Colour = color(255,255,0);
   speed_Icon_Y = cannon_Icon_Y;
   speed_Icon = loadImage("cannon_cd_icon.png");
   
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
   
   // Hide mouse cursor when over the active view
   // Display cursor when over UI
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
  
  // Draw the user interface
  user_Interface();
}