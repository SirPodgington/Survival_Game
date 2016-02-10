
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
   float healthbar_Width = ui_Width / 3;
   float healthbar_Bottom = height - 15;
   float healthbar_Left = ui_Left + healthbar_Width;
   float healthbar_Right = healthbar_Left + healthbar_Width;
   horizontalProgressBar(player.remaining_Health, player.max_Health, healthbar_Left, healthbar_Bottom, healthbar_Width, healthbar_Height, healthbar_Colour, healthbar_Background);
   
   // Speedboost Bar
   color speedbar_Colour = color(255,165,0);
   color speedbar_Background = color(127);
   float speedbar_Width = healthbar_Width;
   float speedbar_Height = healthbar_Height / 3;
   float speedbar_Left = healthbar_Left;
   float speedbar_Bottom = healthbar_Bottom - healthbar_Height;
   horizontalProgressBar(player.speedboost_CD_Elapsed, player.speedboost_CD_Length, speedbar_Left, speedbar_Bottom, speedbar_Width, speedbar_Height, speedbar_Colour, speedbar_Background);
   
   // Upgrades progress bar
   color scorebar_Background = color(50,0,0);
   color scorebar_Colour = color(200,0,0);
   float scorebar_Width = 450;
   float scorebar_Height = ui_Height * 0.33f;
   float scorebar_Left = healthbar_Right + 55;
   float scorebar_Bottom = ui_Bottom - 15;
   float scorebar_Top = scorebar_Bottom - scorebar_Height;
   upgrades_ProgressBar(scorebar_Left, scorebar_Bottom, scorebar_Width, scorebar_Height, scorebar_Colour, scorebar_Background);
   
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
   PImage cdBar_Icon_Cannon = loadImage("cannon_icon.png");
   float cdBar_Left_Cannon = cdBar_Offset_X;
   if (player.cannon_Unlocked)
   {
      verticalProgressBar(player.cannon_CD_Elapsed, player.cannon_CD_Length, cdBar_Left_Cannon, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background, cdBar_Icon_Cannon, cdBar_Icon_Y);
   }
   
   // Defense Shield cooldown bar
   PImage cdBar_Icon_Shield = loadImage("shield_icon.png");
   float cdBar_Left_Shield = cdBar_Left_Cannon + cdBar_Gap;
   if (player.shield_Unlocked)
   {
      verticalProgressBar(player.shield_CD_Elapsed, player.shield_CD_Length, cdBar_Left_Shield, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background, cdBar_Icon_Shield, cdBar_Icon_Y);
   }
}