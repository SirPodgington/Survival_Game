
void user_Interface()
{
   fill(255);
   stroke(255);
   strokeWeight(2);
   rect(ui_Start_X, ui_Start_Y, ui_Width, ui_Height); // UI BackgroundS
     
   // Cannon cooldown bar
   int remaining_Time = game_Objects.get(0).cooldown2;   // Store cannon cd timer value from the player object (first entry)
   float cannon_Remaining_Time = map(remaining_Time, 0, 300, 0, cd_Bar_Height);
     
   stroke(0);
   strokeWeight(2);
   fill(255);
   rect(cannon_Bar_X, cd_Bar_Top, cd_Bar_Width, cd_Bar_Height);   // Bar template  
   fill(255,0,0);
   rect(cannon_Bar_X, cd_Bar_Bottom, cd_Bar_Width, -cannon_Remaining_Time);   // Bar remaining_Time
   image(cannon_Icon, cannon_Bar_X, cannon_Icon_Y);
}