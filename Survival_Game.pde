// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

- Upgrades bar
- Something for when player dies (game over)


TO BE ADDED (IDEAS):

HIGH PRIORITY
- Airstrike CD, Radius UPGR
- Passive Speed Upgrade CD (Player)
- RateOfFire UPGR (lmg speed)
- Explosive Round UPGR (Turret)
- Duration UPGR (speedboost)
- Defense Shield CD + Duration UPGR

LOW PRIORITY
- Protector AI CD
- Overheating System for LMG (player)
- Enemy AI (Flying)
- Statistics (temp or permanent? perm requires write to notepad to save info)

*/

import ddf.minim.*;
Minim minim;

float view_Left_Boundry, view_Right_Boundry, view_Top_Boundry, view_Bottom_Boundry;
float view_Width, view_Height, view_HalfWidth, view_Half_Height;
float view_Center_X, view_Center_Y;
int time_Played;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store keyPressed status for all keys


void setup()
{
   minim = new Minim(this);
   fullScreen();
   
   // View properties (Game screen excluding UI)
   ui_Height = 100;
   view_Width = width;
   view_Height = height - ui_Height;
   view_HalfWidth = view_Width / 2;
   view_Half_Height = view_Height / 2;
   view_Center_X = width / 2;
   view_Center_Y = view_Height / 2;
   view_Left_Boundry = view_Center_X - view_HalfWidth;
   view_Right_Boundry = view_Center_X + view_HalfWidth;
   view_Top_Boundry = view_Center_Y - view_Half_Height;
   view_Bottom_Boundry = view_Center_Y + view_Half_Height;
   
   ui_Width = view_Width;
   ui_Left = view_Left_Boundry;
   ui_Right = ui_Left + ui_Width;
   ui_Top = view_Bottom_Boundry;
   ui_Bottom = ui_Top + ui_Height;
   ui_Background = color(255,207,37);
   
   healthBar_Height = ui_Height / 2;
   healthBar_Width = ui_Width / 3;
   healthBar_Bottom = height - 15;
   healthBar_Left = ui_Left + healthBar_Width;
   healthBar_Right = healthBar_Left + healthBar_Width;
   healthBar_Colour = color(127,255,0);
   healthBar_Background = color(200,0,0);
   
   speedBar_Width = healthBar_Width;
   speedBar_Height = healthBar_Height / 3;
   speedBar_Left = healthBar_Left;
   speedBar_Bottom = healthBar_Bottom - healthBar_Height;
   speedBar_Colour = color(255,165,0);
   speedBar_Background = color(127);
   
   cdBar_Gap = 30;
   cdBar_Offset_X = 20;
   cdBar_Offset_Y = 10;
   cdBar_Height = ui_Height / 2;
   cdBar_Width = cdBar_Height / 2;
   cdBar_Bottom = cdBar_Height + (ui_Top + cdBar_Offset_Y);
   cdBar_Left_Cannon = cdBar_Offset_X;
   cdBar_Left_Speed = cdBar_Left_Cannon + cdBar_Gap;
   cdBar_Background = color(200,0,0);
   cdBar_Colour = color(127,255,0);
   cdBar_Icon_Y = ui_Bottom - (cdBar_Offset_Y / 2);
   cdBar_Icon_Cannon = loadImage("cannon_cd_icon.png");
   
   Player player = new Player(width/2, view_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D');
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


// Check Bullet Collisions ------------------------------------------------------------------------------------
void bulletCollision()
{
   for(int i = game_Objects.size() - 1; i >= 0; i --)
   {
      GameObject object1 = game_Objects.get(i);
      
      // Check for Bullet collisions ****************************
      if (object1 instanceof Bullet)
      {
         Bullet bullet = (Bullet) object1;
         
         // Enemy Bullet / Player
         if (bullet.enemy && bullet.pos.dist(player_Stats.pos) < bullet.halfH + player_Stats.halfW)   // Check for collision
         {
            player_Stats.remainingHealth -= bullet.damage;      // apply damage
            game_Objects.remove(bullet);   // remove bullet
         }
         
         for(int j = game_Objects.size() - 1; j >= 0 ; j --)
         {
            GameObject object2 = game_Objects.get(j);
            
            // Friendly Bullet / AI
            if (object2 instanceof AI && !bullet.enemy)
            {
               AI ai = (AI) object2;
               if (bullet.pos.dist(ai.pos) < bullet.halfH + ai.halfW)
               {
                  ai.remainingHealth -= bullet.damage;
                  game_Objects.remove(bullet);
               }
            }
         }
      }
   }
}


// Remove Dead & Add Score / Increment Kill Counter -------------------------------------------------------
void removeDead()
{
   for(int i = game_Objects.size() - 1; i >= 0; i --)
   {
      GameObject unit = game_Objects.get(i);
      
      if (unit.remainingHealth <= 0 && (unit instanceof AI || unit instanceof Player))
      {
         if (unit instanceof AI)
         {
            AI ai = (AI) unit;
            player_Stats.score += ai.score_Value;
            player_Stats.kills++;
         }
         else
         {
            // Game over code
         }
         game_Objects.remove(unit);   // Remove unit from game
      }
   }
}


// DRAW METHOD ------------------------------------------------------------
Player player_Stats = null;
void draw()
{
   background(0);
   time_Played = millis();
   player_Stats = (Player) game_Objects.get(0);
   
   // If Player is alive...
   if (player_Stats.alive)
   {
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
     
      removeDead();   // Remove dead units, add score if necessary
      bulletCollision();   // Check for bullet collision with player & ai
      spawnEnemies();   // Spawn enemy AI units on a timer
      user_Interface();   // Draw the user interface
      draw_Scoreboard();   // Display player score & kills
   }
}