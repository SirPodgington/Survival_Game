
// UI Variables
color ui_Background;
float ui_Width, ui_Height;
float ui_Left, ui_Top;

// Health Bar Variables
color healthBar_Colour, healthBar_Background;
float healthBar_Height, healthBar_Width;
float healthBar_Bottom, healthBar_Left;
int healthBar_Outline;

// Speed Bar Variables
color speedBar_Colour, speedBar_Background;
float speedBar_Width, speedBar_Height;
float speedBar_Bottom, speedBar_Left;
int speedBar_Outline;

// Cooldown Bar Variables
color cdBar_Background, cdBar_Colour;
float cdBar_Height, cdBar_Width;
float cdBar_Bottom, cdBar_Left_Cannon, cdBar_Left_Speed;
float cdBar_Gap;
int cdBar_Outline;
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
   horizontalProgressBar(player.health, player.max_Health, healthBar_Left, healthBar_Bottom, healthBar_Width, healthBar_Height, healthBar_Colour, healthBar_Background, healthBar_Outline);
   
   // Speed Boost Bar
   horizontalProgressBar(player.cd2_Elapsed, player.cd2_Duration, cdBar_Left_Speed, cdBar_Bottom, cdBar_Width, cdBar_Height, speedBar_Colour, speedBar_Background, cdBar_Outline);
   
   // Cannon cooldown bar
   if (player.cannon_Upgrade)
   {
      //remaining = player.cd1_Elapsed;
      //total = player.cd1_Duration;
      //mapped_Value = map(remaining, 0, total, 0, cdBar_Height);
      cdBar(cdBar_Left_Cannon);  // CD Bar
      //cooldownTimer(cdBar_Left_Cannon, mapped_Value, cdBar_Icon_Cannon);
   }
}

void cdBar(float cd_Position)
{
   float x = cd_Position - (cdBar_Width / 2);
   stroke(0);
   strokeWeight(2);
   fill(cdBar_Background);
   rect(x, cdBar_Bottom, cdBar_Width, -cdBar_Height);
}

void cooldownTimer(float cd_Position, float time, PImage icon)
{
   float bar_X = cd_Position - (cdBar_Width / 2);
   float icon_X = cd_Position - (icon.width / 2);
   fill(cdBar_Colour);
   rect(bar_X, cdBar_Bottom, cdBar_Width, -time);   // Bar remaining
   image(icon, icon_X, cdBar_Icon_Y);
}

void healthBar(float hp)
{
   // Background
   strokeWeight(1);
   stroke(255);
   fill(healthBar_Background);
   rect(healthBar_Left, healthBar_Bottom, healthBar_Width, -healthBar_Height);
   
   // Current Health
   float health = hp;
   fill(healthBar_Colour);
   rect(healthBar_Left, healthBar_Bottom, health, -healthBar_Height);
}

void horizontalProgressBar(float progress, float total, float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour, int outline)
{
   // Background
   strokeWeight(outline);
   stroke(255);
   fill(background_Colour);
   rect(start_X, start_Y, bar_Width, -bar_Height);
   
   // Progress
   float mapped_Value = map(progress, 0, total, 0, bar_Width);
   fill(progress_Colour);
   rect(start_X, start_Y, mapped_Value, -bar_Height);
}