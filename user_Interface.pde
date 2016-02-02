
// UI Variables
color ui_Background;
float ui_Width, ui_Height;
float ui_Left, ui_Top, ui_Bottom, ui_Right;

// Health Bar Variables
color healthBar_Colour, healthBar_Background;
float healthBar_Height, healthBar_Width;
float healthBar_Bottom, healthBar_Left;

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

void user_Interface()
{
   Tank player = (Tank) game_Objects.get(0);
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Left, ui_Top, ui_Width, ui_Height); // UI BackgroundS
   
   // Health Bar
   horizontalProgressBar(player.health, player.max_Health, healthBar_Left, healthBar_Bottom, healthBar_Width, healthBar_Height, healthBar_Colour, healthBar_Background);
   
   // Speed Boost Bar
   horizontalProgressBar(player.cd2_Elapsed, player.cd2_Duration, speedBar_Left, speedBar_Bottom, speedBar_Width, speedBar_Height, speedBar_Colour, speedBar_Background);
   
   // Cannon cooldown bar
   if (!player.cannon_Upgrade)
   {
      verticalProgressBar(player.cd1_Elapsed, player.cd1_Duration, cdBar_Left_Cannon, cdBar_Bottom, cdBar_Width, cdBar_Height, cdBar_Colour, cdBar_Background);
   }
}