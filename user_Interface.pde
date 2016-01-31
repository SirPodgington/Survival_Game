
void cooldownBar(float bar_Position)
{
   stroke(0);
   strokeWeight(2);
   fill(cd_Bar_Background);
   rect(bar_Position, cd_Bar_Top, cd_Bar_Width, cd_Bar_Height);
}

void cooldownTimer(float bar_Position, float time, PImage icon, float icon_Position, color colour)
{
   fill(colour);
   rect(bar_Position, cd_Bar_Bottom, cd_Bar_Width, -time);   // Bar remaining_Time
   image(icon, bar_Position, icon_Position);
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
   
   cooldownBar(cannon_Bar_X);  // Cannon CD Bar
   cooldownTimer(cannon_Bar_X, cannon_Remaining_Time, cannon_Icon, cannon_Icon_Y, cd_Bar_Colour);   // Cannon CD timer
   
   // Speedboost cooldown bar
   remaining_Time = game_Objects.get(0).cd2_Elapsed;
   duration = game_Objects.get(0).cd2_Length;
   float speed_Remaining_Time = map(remaining_Time, 0, duration, 0, cd_Bar_Height);
   
   cooldownBar(speed_Bar_X);  // Cannon CD Bar
   cooldownTimer(speed_Bar_X, speed_Remaining_Time, speed_Icon, speed_Icon_Y, cd_Bar_Colour);   // Cannon CD timer
}