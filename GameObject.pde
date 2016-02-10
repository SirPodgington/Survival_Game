class GameObject
{
   
   PVector position;
   PVector forward;
   float w, half_Width;
   float h, half_Height;
   float turret_Width, turret_Length, turret_HalfWidth, turret_HalfLength;
   float speed;
   float theta;
   int fireRate, fireRate_Elapsed;
   int remaining_Health, max_Health;
   color colour;
   AudioPlayer attack_Sound;
   
   GameObject()
   {
      this(width*0.5f, height*0.5f);
   }
   
   GameObject(float start_X, float start_Y)
   {
      position = new PVector(start_X, start_Y);
      forward = new PVector(0, -1);
   }
   
   void update(){}
   void render(){}   
}