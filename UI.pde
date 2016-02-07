
// UI Variables
color ui_Background;
float ui_Width, ui_Height;
float ui_Left, ui_Top, ui_Bottom, ui_Right;

// Health Bar Variables
color healthBar_Colour, healthBar_Background;
float healthBar_Height, healthBar_Width;
float healthBar_Bottom, healthBar_Left, healthBar_Right;

// Speed Bar Variables
color speedBar_Colour, speedBar_Background;
float speedBar_Width, speedBar_Height;
float speedBar_Bottom, speedBar_Left;

// Cooldown Bar Variables
color cdBar_Background, cdBar_Colour;
float cdBar_Height, cdBar_Width;
float cdBar_Bottom, cdBar_Left_Cannon, cdBar_Left_Speed;
float cdBar_Gap, cdBar_Offset_X, cdBar_Offset_Y;
float cdBar_Icon_Y;
PImage cdBar_Icon_Cannon;



// Upgrades Bar
void upgradesBar(float centreX, float centreY, float w, float h)
{
   float barX = centreX - (w/2);
   float barY = centreY - (h/2);
   stroke(0);
   fill(255);
   rect(barX, barY, w, h);
}


// Vertical Progress Bar
void verticalProgressBar(float progress, float total, float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour)
{
   // Background
   strokeWeight(1);
   stroke(127);
   fill(background_Colour);
   rect(start_X, start_Y, bar_Width, -bar_Height);
   
   // Progress
   float mapped_Value = map(progress, 0, total, 0, bar_Height);
   fill(progress_Colour);
   rect(start_X, start_Y, bar_Width, -mapped_Value);
}


// Horizontal Progress Bar
void horizontalProgressBar(float progress, float total, float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour)
{
   // Background
   strokeWeight(1);
   stroke(127);
   fill(background_Colour);
   rect(start_X, start_Y, bar_Width, -bar_Height);
   
   // Progress
   float mapped_Value = map(progress, 0, total, 0, bar_Width);
   fill(progress_Colour);
   rect(start_X, start_Y, mapped_Value, -bar_Height);
}


// User Interface
void user_Interface()
{
   Player player = (Player) game_Objects.get(0);
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Left, ui_Top, ui_Width, ui_Height); // UI BackgroundS
   
   // Health Bar
   horizontalProgressBar(player.remainingHealth, player.maxHealth, healthBar_Left, healthBar_Bottom, healthBar_Width, healthBar_Height, healthBar_Colour, healthBar_Background);
   
   // Speed Boost Bar
   horizontalProgressBar(player.speedBoost_CD_Elapsed, player.speedBoost_CD_Length, speedBar_Left, speedBar_Bottom, speedBar_Width, speedBar_Height, speedBar_Colour, speedBar_Background);
   
   // Cannon cooldown bar
   if (player.cannon_Upgrade)
   {
      verticalProgressBar(player.cannon_CD_Elapsed, player.cannon_CD_Elapsed, cdBar_Left_Cannon, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background);
   }
   
   // Upgrades bar
   color scoreBar_Background = color(127);
   color scoreBar_Colour = color(200,0,0);
   float scoreBar_Left = healthBar_Right + 50;
   float scoreBar_Bottom = ui_Bottom - 15;
   float scoreBar_Width = 450;
   float scoreBar_Height = ui_Height * 0.33f;
   stroke(0);
   fill(scoreBar_Background);
   rect(scoreBar_Left, scoreBar_Bottom, scoreBar_Width, -scoreBar_Height);
}