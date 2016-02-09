/*
TO BE FIXED:
- Upgrades bar (icons indicating whats unlocked at each marker)
- Something for when player dies (game over)
- Redesign UI

LOW PRIORITY
- Statistics (temp or permanent? perm requires write to notepad to save info)

*/

import ddf.minim.*;   // Minim library to handle audio files
Minim minim;

float view_Left_Boundry, view_Right_Boundry, view_Top_Boundry, view_Bottom_Boundry;
float view_Width, view_Height, view_Half_Width, view_Half_Height;
float view_Center_X, view_Center_Y;
color theme_Colour;

ArrayList<GameObject> game_Objects = new ArrayList<GameObject>();   // Arraylist to store all game objects
boolean[] keys = new boolean[512];   // Array to store keyPressed status for all keys

void setup()
{
   fullScreen();
   minim = new Minim(this);
   
   // View properties (Game screen excluding UI)
   view_Width = width;
   view_Height = height - 100;
   view_Half_Width = view_Width / 2;
   view_Half_Height = view_Height / 2;
   view_Center_X = width / 2;
   view_Center_Y = view_Height / 2;
   view_Left_Boundry = view_Center_X - view_Half_Width;
   view_Right_Boundry = view_Center_X + view_Half_Width;
   view_Top_Boundry = view_Center_Y - view_Half_Height;
   view_Bottom_Boundry = view_Center_Y + view_Half_Height;
   theme_Colour = color(255,207,37);
   
   loadPlayer();
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

// The scoreboard. Displays the player's kills and score
void scoreboard()
{
   color scoreboard_Colour = theme_Colour;
   float x = width - 20;
   float y = 20;
   String kills = "Kills: " + player.kills;
   String score = "Score: " + player.score;
   fill(scoreboard_Colour);
   textAlign(RIGHT,TOP);
   textSize(14);
   text(kills + "  |  " + score, x, y);
}

// Check Bullet Collisions ------------------------------------------------------------------------------------
void bulletCollision()
{
   for (int i = game_Objects.size() - 1; i >= 0; i--)
   {
      GameObject object1 = game_Objects.get(i);
      
      if (object1 instanceof Bullet)
      {
         Bullet bullet = (Bullet) object1;
         
         if (bullet.enemy)   // Enemy Bullets ------
         {
            // Remove bullet when it touches the shield (if shield is active)
            if (player.shield_Active && bullet.position.dist(player.position) < bullet.halfH + (player.shield_Width / 2))
               game_Objects.remove(bullet);
            
            // Otherwise remove bullet if touches player & apply damage
            else if (bullet.position.dist(player.position) < bullet.halfH + player.halfW)
            {
               player.remainingHealth -= bullet.damage;      // Apply Damage
               game_Objects.remove(bullet);   // Remove Bullet
            }
         }
         else   // Player Bullets -----
         {
            for (int j = game_Objects.size() - 1; j >= 0; j--)
            {
               GameObject object2 = game_Objects.get(j);
               
               // Friendly Bullet / AI
               if (object2 instanceof AI && !bullet.enemy)
               {
                  AI ai = (AI) object2;
                  
                  // Bullet / AI Collision
                  if (bullet.position.dist(ai.position) < bullet.halfH + ai.halfW)
                  {
                     if (bullet instanceof CannonBall)
                     {
                        // If upgraded cannonball set the AI on fire
                        CannonBall cannonBall = (CannonBall) bullet;
                        if (cannonBall.onFire)   // Apply burn effect to ai unit
                              ai.burning = true;
                     }
                     ai.remainingHealth -= bullet.damage;   // Apply bullet damage
                     game_Objects.remove(bullet);   // Remove Bullet
                  }
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
      GameObject object = game_Objects.get(i);
      
      if ((object instanceof AI || object instanceof Player) && object.remainingHealth <= 0)
      {
         if (object instanceof AI)
         {
            AI ai = (AI) object;
            player.score += ai.score_Value;   // Add score to player
            player.kills++;   // Increment player kills
            game_Objects.remove(ai);   // Remove unit from game
         }
         else
         {
            player.alive = false;
         }
      }
   }
}

// Controls AI Spawning -------------------------------------------------------------
float basic_SpawnTime = 300;
float heavy_SpawnTime = 900;
void spawnAI()
{
   // Control spawn rate of the AI, increasing as time passes
   if (frameCount < 1800)
   {
      basic_SpawnTime = 300;
      heavy_SpawnTime = 900;
   }
   else if (frameCount < 3600)
   {
      basic_SpawnTime = 240;
      heavy_SpawnTime = 750;
   }
   else
   {
      basic_SpawnTime = 180;
      heavy_SpawnTime = 600;
   }
   
   // Spawn basic AI
   if (frameCount % basic_SpawnTime == 0)
   {
      BasicAI unit = new BasicAI();
      game_Objects.add(unit);
   }
   
   // Spawn heavy AI
   if (frameCount % heavy_SpawnTime == 0)
   {
      HeavyAI unit = new HeavyAI();
      game_Objects.add(unit);
   }
}

// Game Over ---------------------------------------------------------
void gameOver()
{
   
}

// DRAW METHOD ------------------------------------------------------------
Player player = null;

void draw()
{
   background(0);
   player = (Player) game_Objects.get(0);
   
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
      spawnAI();   // Spawn enemy AI units on a timer
      userInterface();   // Draw the user interface
      scoreboard();   // Display player score & kills
   }
   else
      gameOver();
}