
void cooldownBar(float cd_Position)
{
   float x = cd_Position - (cd_Bar_Width / 2);
   stroke(0);
   strokeWeight(2);
   fill(cd_Bar_Background);
   rect(x, cd_Bar_Top, cd_Bar_Width, cd_Bar_Height);
}

void cooldownTimer(float cd_Position, float time, PImage icon, float icon_Position, color colour)
{
   float bar_X = cd_Position - (cd_Bar_Width / 2);
   float icon_X = cd_Position - (icon.width / 2);
   float icon_Y = icon_Position - (icon.height / 2);
   fill(colour);
   rect(bar_X, cd_Bar_Bottom, cd_Bar_Width, -time);   // Bar remaining
   image(icon, icon_X, icon_Y);
}

//void playerHealthb



void user_Interface()
{
   int remaining, total;
   float remaining_Mapped;
   GameObject player = game_Objects.get(0);
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Left_Boundry, ui_Top_Boundry, ui_Width, ui_Height); // UI BackgroundS
     
   // Cannon cooldown bar
   remaining = player.cd1_Elapsed;   // Store cannon cd timer value from the player object (first entry)
   total = player.cd1_Length;
   remaining_Mapped = map(remaining, 0, total, 0, cd_Bar_Height);
   cooldownBar(cd_Bar_X_Cannon);  // CD Bar
   cooldownTimer(cd_Bar_X_Cannon, remaining_Mapped, cannon_Icon, cd_Icon_Y, cd_Bar_Colour);   // CD timer
   
   // Speedboost cooldown bar
   remaining = player.cd2_Elapsed;
   total = player.cd2_Length;
   remaining_Mapped = map(remaining, 0, total, 0, cd_Bar_Height);
   cooldownBar(cd_Bar_X_Speed);  // CD Bar
   cooldownTimer(cd_Bar_X_Speed, remaining_Mapped, speed_Icon, cd_Icon_Y, cd_Bar_Colour);   // CD timer
   
   // Health Bar
   strokeWeight(1);
   stroke(255);
   fill(200,0,0);
   rect(player_HealthBar_Left, player_HealthBar_Bottom, player_HealthBar_Width, -player_HealthBar_Height);
   
   remaining = player.health;
   total = player.max_Health;
   remaining_Mapped = map(remaining, 0, total, 0, player_HealthBar_Width);
   fill(50,200,0);
   rect(player_HealthBar_Left, player_HealthBar_Bottom, remaining_Mapped, -player_HealthBar_Height);
}