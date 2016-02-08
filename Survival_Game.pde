// OOP Assignment 2: 1st attempt

/*
TO BE FIXED:

- Upgrades bar
- Something for when player dies (game over)


TO BE ADDED (IDEAS):

HIGH PRIORITY
- Every 30secs spawnrate increases by 10%
- Airstrike CD, Radius UPGR
- Passive Speed Upgrade CD (Player)
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
color theme_Colour;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store keyPressed status for all keys


void setup()
{
   minim = new Minim(this);
   fullScreen();
   
   // View properties (Game screen excluding UI)
   view_Width = width;
   view_Height = height - 100;
   view_HalfWidth = view_Width / 2;
   view_Half_Height = view_Height / 2;
   view_Center_X = width / 2;
   view_Center_Y = view_Height / 2;
   view_Left_Boundry = view_Center_X - view_HalfWidth;
   view_Right_Boundry = view_Center_X + view_HalfWidth;
   view_Top_Boundry = view_Center_Y - view_Half_Height;
   view_Bottom_Boundry = view_Center_Y + view_Half_Height;
   theme_Colour = color(255,207,37);
   
   Player player = new Player(width/2, view_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D', ' ', 'F', 'R');
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
         if (bullet.enemy && bullet.pos.dist(player.pos) < bullet.halfH + player.halfW)   // Check for collision
         {
            player.remainingHealth -= bullet.damage;      // apply damage
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
            player.score += ai.score_Value;   // Add score to player
            player.kills++;   // Increment player kills
            game_Objects.remove(unit);   // Remove unit from game
         }
         else
         {
            player.alive = false;
         }
      }
   }
}


// DRAW METHOD ------------------------------------------------------------
Player player = null;

void draw()
{
   background(0);
   player = (Player) game_Objects.get(0);
   
   // If Player is alive...
   if (player.alive)
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