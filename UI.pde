
// Vertical Progress Bar
void verticalProgressBar(float progress, float total, float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour, PImage icon, float icon_Y)
{
   // Background
   strokeWeight(1);
   stroke(127);
   fill(background_Colour);
   rect(start_X, start_Y, bar_Width, -bar_Height);   // Background
   
   // Progress
   float mapped_Value = map(progress, 0, total, 0, bar_Height);
   if (mapped_Value > bar_Height)   // Keep progress bar within boundry
      mapped_Value = bar_Height;
   
   float iconX = start_X + (bar_Width / 2) - (icon.width / 2);
   fill(progress_Colour);
   rect(start_X, start_Y, bar_Width, -mapped_Value);   // Progress
   image(icon, iconX, icon_Y - (icon.height / 2));   // Icon
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
   if (mapped_Value > bar_Width)
      mapped_Value = bar_Width;
      
   fill(progress_Colour);
   rect(start_X, start_Y, mapped_Value, -bar_Height);
}


// Upgrades Progress Bar
void upgrades_ProgressBar(float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour)
{
   horizontalProgressBar(player.score, player.airstrike_Upgrade_Score, start_X, start_Y, bar_Width, bar_Height, progress_Colour, background_Colour);
   int unlockables_Count = 8;
   float gap = bar_Width / unlockables_Count;
   for (int i = 1; i <= unlockables_Count; i++)
   {
      float x = start_X + (i*gap);
      float bottom_Y = start_Y;
      float top_Y = bottom_Y - bar_Height;
      stroke(127);
      line(x, bottom_Y, x, top_Y);
   }
}


// User Interface
void user_Interface()
{
   // UI Properties & Background
   float ui_Height = height - view_Height;
   float ui_Width = view_Width;
   float ui_Left = view_Left_Boundry;
   float ui_Right = ui_Left + ui_Width;
   float ui_Top = view_Bottom_Boundry;
   float ui_Bottom = ui_Top + ui_Height;
   color ui_Background = theme_Colour;
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Left, ui_Top, ui_Width, ui_Height);   // Background
   
   // Health Bar
   float healthBar_Height = ui_Height / 2;
   float healthBar_Width = ui_Width / 3;
   float healthBar_Bottom = height - 15;
   float healthBar_Left = ui_Left + healthBar_Width;
   float healthBar_Right = healthBar_Left + healthBar_Width;
   color healthBar_Colour = color(127,255,0);
   color healthBar_Background = color(200,0,0);
   horizontalProgressBar(player.remainingHealth, player.maxHealth, healthBar_Left, healthBar_Bottom, healthBar_Width, healthBar_Height, healthBar_Colour, healthBar_Background);
   
   // Speed Boost Bar
   float speedBar_Width = healthBar_Width;
   float speedBar_Height = healthBar_Height / 3;
   float speedBar_Left = healthBar_Left;
   float speedBar_Bottom = healthBar_Bottom - healthBar_Height;
   color speedBar_Colour = color(255,165,0);
   color speedBar_Background = color(127);
   horizontalProgressBar(player.speedBoost_CD_Elapsed, player.speedBoost_CD_Length, speedBar_Left, speedBar_Bottom, speedBar_Width, speedBar_Height, speedBar_Colour, speedBar_Background);
   
   // Upgrades progress bar
   color scoreBar_Background = color(50,0,0);
   color scoreBar_Colour = color(200,0,0);
   float scoreBar_Width = 450;
   float scoreBar_Height = ui_Height * 0.33f;
   float scoreBar_Left = healthBar_Right + 55;
   float scoreBar_Bottom = ui_Bottom - 15;
   float scoreBar_Top = scoreBar_Bottom - scoreBar_Height;
   upgrades_ProgressBar(scoreBar_Left, scoreBar_Bottom, scoreBar_Width, scoreBar_Height, scoreBar_Colour, scoreBar_Background);
   
   // UPGRADE CD BAR Variables
   float cdBar_Gap = 30;
   float cdBar_Offset_X = 20;
   float cdBar_Offset_Y = 10;
   float cdBar_Height = ui_Height / 2;
   float cdBar_Width = cdBar_Height / 2;
   float cdBar_Bottom = cdBar_Height + ui_Top + cdBar_Offset_Y;
   float cdBar_Icon_Y = cdBar_Bottom + (height - cdBar_Bottom) / 2; 
   color cdBar_Background = color(200,0,0);
   color cdBar_Colour = color(127,255,0);
   
   // Cannon cooldown bar
   PImage cdBar_Icon_Cannon = loadImage("cannon_cd_icon.png");
   float cdBar_Left_Cannon = cdBar_Offset_X;
   if (player.cannon_Unlocked)
   {
      verticalProgressBar(player.cannon_CD_Elapsed, player.cannon_CD_Length, cdBar_Left_Cannon, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background, cdBar_Icon_Cannon, cdBar_Icon_Y);
   }
}