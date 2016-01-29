
void user_Interface()
{
   // User Interface - To include things like Cooldown timers, player health, (score?)
   fill(255);
   stroke(255);
   strokeWeight(2);
   rect(ui_Start_X, ui_Start_Y, ui_Width, ui_Height); // UI BackgroundS
     
   // Cannon cooldown bar
   int cannonVal = game_Objects.get(0).cooldown2;   // Store cannon cd timer value from the player object (first entry)
   float cannonProgress = map(cannonVal, 0, 300, 0, cdBarHeight);
     
   stroke(0);
   strokeWeight(2);
   fill(255);
   rect(cannonBarX, cdBarTop, cdBarWidth, cdBarHeight);   // Bar template  
   fill(255,0,0);
   rect(cannonBarX, cdBarBottom, cdBarWidth, -cannonProgress);   // Bar progress
   image(cannonIcon, cannonBarX, cannonIconY);
}