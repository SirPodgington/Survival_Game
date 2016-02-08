class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, halfW;
   float h, halfH;
   float turret_Width, turret_Length, turret_HalfWidth, turret_HalfLength;
   float speed;
   float theta = 0.0f;
   color colour;
   int cd_ActivationTime;
   int fireRate, fireRate_Elapsed;
   int remainingHealth, maxHealth;
   AudioPlayer attack_Sound;
   
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