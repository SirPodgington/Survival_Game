
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
   rect(bar_X, cd_Bar_Bottom, cd_Bar_Width, -time);   // Bar remaining_Time
   image(icon, icon_X, icon_Y);
}

void user_Interface()
{
   int remaining_Time, duration;
   
   fill(ui_Background);
   stroke(255);
   strokeWeight(2);
   rect(ui_Start_X, ui_Start_Y, ui_Width, ui_Height); // UI BackgroundS
     
   // Cannon cooldown bar
   remaining_Time = game_Objects.get(0).cd1_Elapsed;   // Store cannon cd timer value from the player object (first entry)
   duration = game_Objects.get(0).cd1_Length;
   float cannon_Remaining_Time = map(remaining_Time, 0, duration, 0, cd_Bar_Height);
   
   cooldownBar(cd_Bar_X_Cannon);  // Cannon CD Bar
   cooldownTimer(cd_Bar_X_Cannon, cannon_Remaining_Time, cannon_Icon, cd_Icon_Y, cd_Bar_Colour);   // Cannon CD timer
   
   // Speedboost cooldown bar
   remaining_Time = game_Objects.get(0).cd2_Elapsed;
   duration = game_Objects.get(0).cd2_Length;
   float speed_Remaining_Time = map(remaining_Time, 0, duration, 0, cd_Bar_Height);
   
   cooldownBar(cd_Bar_X_Speed);  // Cannon CD Bar
   cooldownTimer(cd_Bar_X_Speed, speed_Remaining_Time, speed_Icon, cd_Icon_Y, cd_Bar_Colour);   // Cannon CD timer
}