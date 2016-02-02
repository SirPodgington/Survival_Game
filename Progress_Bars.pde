
// Vertical Progress Bar
void verticalProgressBar(float progress, float total, float start_X, float start_Y, float bar_Width, float bar_Height, color progress_Colour, color background_Colour)
{
   // Background
   strokeWeight(1);
   stroke(127);
   fill(background_Colour);
   rect(start_X, start_Y, bar_Width, -bar_Height);
   
   // Progress
   float mapped_Value = map(progress, 0, total, 0, bar_Height);
   fill(progress_Colour);
   rect(start_X, start_Y, bar_Width, -mapped_Value);
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
   fill(progress_Colour);
   rect(start_X, start_Y, mapped_Value, -bar_Height);
}