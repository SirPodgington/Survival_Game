// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

- Redesign the bullet class so that properties are assigned in constructor (pass ammo type value in)
- Change player turret to basic model (until cannon CD is unlocked)
- Move speedboost to above health bar, have it as passive boost instead of unlockable cd?
- Tidy up code (some things can be moved into function and drawn from a template (ie rectangles)


TO BE ADDED (IDEAS):

- Player loses health when touches AI (3 sec internal cd)
- More AI (Flying, Medium, Boss)
- Add AI spawning system (waves or continuous?)
- RoF passive perk on player LMG
- Score system
- Heat cooldown on player LMG
- Airstrike cooldown (one for enemy & player?)
- Defense Shield cooldown
- Change CDs to unlockable (unlock after score stages?)
- Statistics (temp or permanent? perm requires write to notepad to save info)
- Slower turning AI (rotates until aligned with player)
*/

import ddf.minim.*;
Minim minim;

// Background, View (the game screen, exempt from the UI), World, User Interface variables
float view_Left_Boundry, view_Right_Boundry, view_Top_Boundry, view_Bottom_Boundry;
float view_Width, view_Height;
float ui_Left_Boundry, ui_Top_Boundry, ui_Width, ui_Height;
color ui_Background;
float cd_Bar_Height, cd_Bar_Width, cd_Bar_Top, cd_Bar_Bottom;
float cd_Bar_Gap, cd_Bar_X_Cannon, cd_Bar_X_Speed, cd_Icon_Y;
color cd_Bar_Background, cd_Bar_Colour;
float player_HealthBar_Height, player_HealthBar_Width, player_HealthBar_Bottom, player_HealthBar_Left;
PImage cannon_Icon, speed_Icon;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store true/false values for all possile keys to detect keypresses


void setup()
{
   minim = new Minim(this);
   fullScreen();
   //size(1000, 700);
   
   // Background, View (the game screen, exempt from the UI), World, User Interface variables
   view_Left_Boundry = 0;
   view_Right_Boundry = width;
   view_Top_Boundry = 0;
   view_Bottom_Boundry = height - 100;
   view_Width = view_Right_Boundry - view_Left_Boundry;
   view_Height = view_Bottom_Boundry - view_Top_Boundry;
   ui_Left_Boundry = view_Left_Boundry;
   ui_Top_Boundry = view_Bottom_Boundry;
   ui_Height = height - view_Bottom_Boundry;
   ui_Width = view_Right_Boundry - view_Left_Boundry;
   ui_Background = color(255,207,37);
   cd_Bar_Height = 50;
   cd_Bar_Width = 20;
   cd_Bar_Top = view_Bottom_Boundry + 10;
   cd_Bar_Bottom = cd_Bar_Top + cd_Bar_Height;
   cd_Bar_Background = color(200,0,0);
   cd_Bar_Colour = color(127,255,0);
   cd_Bar_Gap = 30;
   cd_Bar_X_Cannon = 20;
   cd_Bar_X_Speed = cd_Bar_X_Cannon + 30;
   cd_Icon_Y = height - ((height - cd_Bar_Bottom) / 2);
   player_HealthBar_Height = ui_Height / 2;
   player_HealthBar_Width = ui_Width / 3;
   player_HealthBar_Bottom = height - 10;
   player_HealthBar_Left = ui_Left_Boundry + player_HealthBar_Width;
   
   cannon_Icon = loadImage("cannon_cd_icon.png");   // UI Icon for cannon cooldown
   speed_Icon = loadImage("speed_cd_icon.png");
   
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


// Check Collisions
void checkCollisions()
{
   for(int i = game_Objects.size() - 1; i >= 0; i --)
   {
      GameObject object1 = game_Objects.get(i);
      
      // Check for Bullet collisions ****************************
      if (object1 instanceof Bullet)
      {
         for(int j = game_Objects.size() - 1; j >= 0 ; j --)
         {
            GameObject object2 = game_Objects.get(j);
            
            // Enemy Bullet & Tank
            if (object2 instanceof Tank && object1.enemy_Bullet)
            {
               if (object1.pos.dist(object2.pos) < (object1.h * 0.5f) + object2.half_W)   // Check for collision
               {
                  object2.health -= object1.bullet_Damage;      // apply damage
                  game_Objects.remove(object1);   // remove bullet
               }
            }
            
            // Friendly Bullet & AI
            if (object2 instanceof AI && !object1.enemy_Bullet)
            {
               if (object1.pos.dist(object2.pos) < object1.half_H + object2.half_W)   // Check for collision
               {
                  object2.health -= object1.bullet_Damage;
                  game_Objects.remove(object1);
               }
            }
         }
      }
      // *********************************************************
      
      if (object1 instanceof Tank || object1 instanceof AI)
      {
         // Remove if dies
         if (object1.health <= 0)
            game_Objects.remove(object1);
         
         // Check for collisions
         for(int j = game_Objects.size() - 1; j >= 0 ; j --)
         {
            GameObject object2 = game_Objects.get(j);
            
            // If Tank collides with AI ...
            if (object1 instanceof Tank)
            {
               if (object2 instanceof AI)
               {
                  if (object1.pos.dist(object2.pos) < object1.half_W + object2.half_W)
                  {
                     // Damage player (play sound) 2 second internal cooldown
                  }
               }
            }
         }
      }
      // *********************************************************
   }
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
  
  checkCollisions();
}