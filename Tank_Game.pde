// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

- Score system (basic temp version in use)
- Change player turret to basic model (until cannon CD is unlocked)
- Move speedboost to above health bar, have it as passive boost instead of unlockable cd?
- Tidy up code (some things can be moved into function and drawn from a template (ie rectangles)


TO BE ADDED (IDEAS):

- Turret Upgrade CD + Explosive Round UPGR | Duration UPGR (speedboost) | Defense Shield CD + Duration UPGR | RateOfFire UPGR (lmg speed) | Passive Speed Upgrade CD (tank)
- Player loses health when touches AI (3 sec internal cd)
- More AI (Flying, Medium, Boss)
- Add AI spawning system (waves or continuous?)
- Heat cooldown on player LMG
- Airstrike cooldown (one for enemy & player?)
- Statistics (temp or permanent? perm requires write to notepad to save info)
- Slower turning AI (rotates until aligned with player)
*/

import ddf.minim.*;
Minim minim;

float view_Left_Boundry, view_Right_Boundry, view_Top_Boundry, view_Bottom_Boundry;
float view_Width, view_Height;
int time_Played;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store true/false values for all possile keys to detect keypresses

int kill_Counter, score;

void setup()
{
   minim = new Minim(this);
   fullScreen();
   //size(1000, 700);
   
   // Game view properties (Game screen excluding UI)
   view_Left_Boundry = 0;
   view_Right_Boundry = width;
   view_Top_Boundry = 0;
   view_Bottom_Boundry = height - 100;
   view_Width = view_Right_Boundry - view_Left_Boundry;
   view_Height = view_Bottom_Boundry - view_Top_Boundry;
   
   ui_Left = view_Left_Boundry;
   ui_Top = view_Bottom_Boundry;
   ui_Height = height - view_Bottom_Boundry;
   ui_Width = view_Right_Boundry - view_Left_Boundry;
   ui_Background = color(255,207,37);
   cdBar_Height = 50;
   cdBar_Width = 20;
   cdBar_Bottom = height - 10;
   cdBar_Background = color(200,0,0);
   cdBar_Outline = 2;
   cdBar_Colour = color(127,255,0);
   cdBar_Gap = 30;
   cdBar_Left_Cannon = 20;
   cdBar_Left_Speed = cdBar_Left_Cannon + 30;
   cdBar_Icon_Y = height - ((height - cdBar_Bottom) / 2);
   healthBar_Height = ui_Height / 2;
   healthBar_Width = ui_Width / 3;
   healthBar_Bottom = height - 10;
   healthBar_Left = ui_Left + healthBar_Width;
   healthBar_Outline = 1;
   healthBar_Colour = color(127,255,0);
   healthBar_Background = color(200,0,0);
   speedBar_Colour = color(255,165,0);
   speedBar_Background = color(127);
   speedBar_Outline = 1;
   
   cdBar_Icon_Cannon = loadImage("cannon_cdBar_Icon_Y.png");   // UI Icon for cannon cooldown
   
   Tank player = new Tank(width/2, view_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D');
   game_Objects.add(player);
   BasicAI basicAI = new BasicAI();
   game_Objects.add(basicAI);
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
         {
            if (object1 instanceof AI)
               score += 10;
               kill_Counter++;
               
            game_Objects.remove(object1);
         }
         
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
   time_Played = millis();
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
  
  // Draw kill counter & score
  fill(ui_Background);
  textAlign(RIGHT,TOP);
  textSize(14);
  text("Kills: " + kill_Counter + "  |  Score: " + score, width-20,20);
}