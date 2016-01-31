class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, half_W;
   float h, half_H;
   float default_Speed, speed;
   float theta = 0.0f;
   color colour;
   PImage sprite;
   int cd1_Elapsed, cd2_Elapsed, cd3_Elapsed;
   int cd1_Length, cd2_Length, cd3_Length;
   int fire_Rate, fire_Rate_Elapsed;
   int time = millis();
   int passed_Milliseconds;
   AudioPlayer gun_Sound;

   AudioPlayer sound;
   
   GameObject()
   {
      this(width*0.5f, height*0.5f);
   }
   
   GameObject(float startX, float startY)
   {
      pos = new PVector(startX, startY);
      forward = new PVector(0, -1);
   }
   
   
   void update()
   {
   }
   
   void render()
   {
   }
   
   
}