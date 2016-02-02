class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, half_W;
   float h, half_H;
   float speed, default_Speed, upgraded_Speed;
   float theta = 0.0f;
   color colour;
   int cd_Activation_Time;
   int cd1_Elapsed, cd2_Elapsed, cd3_Elapsed;
   int cd1_Duration, cd2_Duration, cd3_Duration;
   int fire_Rate, fire_Rate_Elapsed;
   int time;
   int health, max_Health;
   int bullet_Damage;
   boolean enemy_Bullet;
   AudioPlayer gun_Sound;
   
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