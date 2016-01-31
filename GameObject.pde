class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, half_W;
   float h, half_H;
   float speed;
   float theta = 0.0f;
   color colour;
   PImage sprite;
   int cooldown1, cooldown2;
   int fire_Rate;    // How many bullets per second
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