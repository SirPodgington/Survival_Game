class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, halfW;
   float h, halfH;
   float turret_Width, turret_Length, turret_HalfWidth, turret_HalfLength;
   float speed, default_Speed, upgraded_Speed;
   float theta = 0.0f;
   color colour;
   int cd_ActivationTime;
   int cd1_Elapsed, cd2_Elapsed, cd3_Elapsed;
   int cd1_Duration, cd2_Duration, cd3_Duration;
   int fireRate, fireRate_Elapsed;
   int time;
   int currentHealth, maxHealth;
   boolean enemy_Bullet;
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