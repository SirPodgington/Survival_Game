/*
TO BE FIXED:
- Upgrades bar (icons indicating whats unlocked at each marker)
- Redesign UI

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