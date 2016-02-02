
void cooldownBar(float cd_Position)
{
   float x = cd_Position - (cd_Bar_Width / 2);
   stroke(0);
   strokeWeight(2);
   fill(cd_Bar_Background);
   rect(x, cd_Bar_Top, cd_Bar_Width, cd_Bar_Height);
}

void cooldownTimer(float cd_Position, float time, PImage icon)
{
   float bar_X = cd_Position - (cd_Bar_Width / 2);
   float icon_X = cd_Position - (icon.width / 2);
   fill(cd_Bar_Colour);
   rect(bar_X, cd_Bar_Bottom, cd_Bar_Width, -time);   // Bar remaining
   image(icon, icon_X, cd_Icon_Y);
}

void healthBar(float hp)
{
   // Background
   strokeWeight(1);
   stroke(255);
   fill(healthBar_Background);
   rect(player_HealthBar_Left, player_HealthBar_Bottom, player_HealthBar_Width, -player_HealthBar_Height);
   
   // Current Health
   float health = hp;
   fill(healthBar_Colour);
   rect(player_HealthBar_Left, player_HealthBar_Bottom, health, -player_HealthBar_Height);
}



void user_Interface()
{
   int remaining, total;
   float mapped_Value;
   Tank player = (Tank) game_Objects.get(0);
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Left_Boundry, ui_Top_Boundry, ui_Width, ui_Height); // UI BackgroundS
   
   // Player Health Bar
   remaining = player.health;
   total = player.max_Health;
   mapped_Value = map(remaining, 0, total, 0, player_HealthBar_Width);
   healthBar(mapped_Value);
   
   // Cannon cooldown bar
   if (player.cannon_Upgrade)
   {
      remaining = player.cd1_Elapsed;
      total = player.cd1_Length;
      mapped_Value = map(remaining, 0, total, 0, cd_Bar_Height);
      cooldownBar(cd_Bar_X_Cannon);  // CD Bar
      cooldownTimer(cd_Bar_X_Cannon, mapped_Value, cannon_Icon);
   }
   
   // Speedboost cooldown bar
   if (player.speedBoost_Upgrade)
   {
      remaining = player.cd2_Elapsed;
      total = player.cd2_Length;
      mapped_Value = map(remaining, 0, total, 0, cd_Bar_Height);
      cooldownBar(cd_Bar_X_Speed);
      cooldownTimer(cd_Bar_X_Speed, mapped_Value, speed_Icon);
   }
   
}