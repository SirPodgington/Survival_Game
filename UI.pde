
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
void horizontalProgressBar(float progress, float total, float x, float y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour)
{
   // Background
   strokeWeight(1);
   stroke(127);
   fill(background_Colour);
   rect(x, y, bar_Width, -bar_Height);
   
   // Progress
   float mapped_Value = map(progress, 0, total, 0, bar_Width);
   if (mapped_Value > bar_Width)
      mapped_Value = bar_Width;
      
   fill(progress_Colour);
   rect(x, y, mapped_Value, -bar_Height);
}


// Upgrades Progress Bar
void upgrades_ProgressBar(float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour)
{
   horizontalProgressBar(player.score, player.shield_Upgrade_Score, start_X, start_Y, bar_Width, bar_Height, progress_Colour, background_Colour);
   int unlockables_Count = 6;
   float gap = bar_Width / unlockables_Count;
   
   for (int i = 1; i <= unlockables_Count; i++)
   {
      float x = start_X + (i*gap);
      float bottom_Y = start_Y;
      float top_Y = bottom_Y - bar_Height;
      stroke(127);
      line(x, bottom_Y, x, top_Y);
      
      PImage icon = loadImage(i + ".png");
      float x_Pos = x - (gap/2);
      float icon_X = x_Pos - (icon.width/2);
      float y_Pos = top_Y - 20;
      float icon_Y = y_Pos - (icon.height/2);
      image(icon, icon_X, icon_Y);
   }
}


// User Interface
void userInterface()
{
   // UI Properties & Background
   float ui_Height = height - view_Height;
   float ui_Width = view_Width;
   float ui_Left = view_Left_Boundry;
   float ui_Right = ui_Left + ui_Width;
   float ui_Centre = ui_Left + (ui_Width/2);
   float ui_Top = view_Bottom_Boundry;
   float ui_Bottom = ui_Top + ui_Height;
   color ui_Background = theme_Colour;
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Left, ui_Top, ui_Width, ui_Height);   // Background
   
   // Health Bar
   color healthbar_Colour = color(127,255,0);
   color healthbar_Background = color(200,0,0);
   float healthbar_Height = ui_Height / 3;
   float healthbar_Width = ui_Width / 3.5f;
   float healthbar_Bottom = ui_Bottom - 25;
   float healthbar_Left = ui_Centre - (healthbar_Width/2);
   float healthbar_Right = healthbar_Left + healthbar_Width;
   horizontalProgressBar(player.remaining_Health, player.max_Health, healthbar_Left, healthbar_Bottom, healthbar_Width, healthbar_Height, healthbar_Colour, healthbar_Background);
   
   // Score & Kills indicator
   color scoreboard_Colour = color(0);
   float scoreboard_X = healthbar_Right + 130;
   float scoreboard_Y = height - 70;
   float gap = 200;
   String kills = "Kills: " + player.kills;
   String score = "Score: " + player.score;
   fill(scoreboard_Colour);
   textAlign(LEFT,TOP);
   textSize(30);
   text(kills, scoreboard_X, scoreboard_Y);
   scoreboard_X += gap;
   text(score, scoreboard_X, scoreboard_Y);
   
   // Speedboost Bar
   color speedbar_Colour = color(255,165,0);
   color speedbar_Background = color(127);
   float speedbar_Width = healthbar_Width;
   float speedbar_Height = healthbar_Height / 3;
   float speedbar_Bottom = healthbar_Bottom - healthbar_Height;
   float speedbar_Left = healthbar_Left;
   horizontalProgressBar(player.speedboost_CD_Elapsed, player.speedboost_CD_Length, speedbar_Left, speedbar_Bottom, speedbar_Width, speedbar_Height, speedbar_Colour, speedbar_Background);
   
   // Upgrades progress bar
   color progressbar_Background = color(50,0,0);
   color progressbar_Colour = color(200,0,0);
   float progressbar_Width = 400;
   float progressbar_Height = ui_Height * 0.33f;
   float progressbar_Left = 25;
   float progressbar_Right = progressbar_Left + progressbar_Width;
   float progressbar_Bottom = healthbar_Bottom + 10;
   upgrades_ProgressBar(progressbar_Left, progressbar_Bottom, progressbar_Width, progressbar_Height, progressbar_Colour, progressbar_Background);
   
   // UPGRADE CD BAR Variables
   color cdBar_Background = color(150);
   color cdBar_Colour = color(255,69,0);
   float cdBar_StartX = progressbar_Right + 50;
   float cdBar_Gap = 40;
   float cdBar_Height = ui_Height / 2;
   float cdBar_Width = cdBar_Height / 2;
   float cdBar_Bottom = ui_Bottom - 40;
   float cdBar_Icon_Y = cdBar_Bottom + 20; 
   
   // Cannon cooldown bar
   PImage cannon_Icon = loadImage("cannon_icon.png");
   float cdBar_Left_Cannon = cdBar_StartX;
   if (player.cannon_Unlocked)
   {
      verticalProgressBar(player.cannon_CD_Elapsed, player.cannon_CD_Length, cdBar_Left_Cannon, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background, cannon_Icon, cdBar_Icon_Y);
   }
   
   // Defense Shield cooldown bar
   PImage shield_Icon = loadImage("shield_icon.png");
   float cdBar_Left_Shield = cdBar_Left_Cannon + cdBar_Gap;
   if (player.shield_Unlocked)
   {
      verticalProgressBar(player.shield_CD_Elapsed, player.shield_CD_Length, cdBar_Left_Shield, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background, shield_Icon, cdBar_Icon_Y);
   }
}