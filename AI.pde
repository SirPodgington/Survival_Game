// Controls AI Spawning -------------------------------------------------------------
void spawnAI()
{
   float basic_SpawnTime;
   float heavy_SpawnTime;

   // Control spawn rate of the AI, increasing as time passes
   if (frameCount < 1800)
   {
      basic_SpawnTime = 300;
      heavy_SpawnTime = 900;
   }
   else if (frameCount < 3600)
   {
      basic_SpawnTime = 240;
      heavy_SpawnTime = 780;
   }
   else
   {
      basic_SpawnTime = 240;
      heavy_SpawnTime = 700;
   }
   
   // Spawn basic AI
   if (frameCount % basic_SpawnTime == 0)
   {
      BasicAI unit = new BasicAI();
      game_Objects.add(unit);
   }
   
   // Spawn heavy AI
   if (frameCount % heavy_SpawnTime == 0)
   {
      HeavyAI unit = new HeavyAI();
      game_Objects.add(unit);
   }
}

// The Class -----------------------------------------------
class AI extends GameObject
{
   float target_Distance_From_Player;
   float distance_To_Player;
   float range;
   int score_Value;
   boolean burning;
   
   AI(float start_X, float start_Y)
   {
      super(start_X, start_Y);
   }
   
   void render(){}
   void update(){}
   void attackSound(){}
   
   // AI Healthbar
   void healthbar()
   {
      color healthbar_Background = color(127);
      float offset = half_Height + 15;
      fill(healthbar_Background);
      noStroke();
      rect(-half_Width, -offset, w, 5);   // Total Health
   
      color healthbar_Colour = color(0,255,0);
      float hp_Mapped = map(remaining_Health, 0, max_Health, 0, w);
      fill(healthbar_Colour);
      rect(-half_Width, -offset, hp_Mapped, 5);   // Remaining Health
   }
   
   void getBurnStatus()
   {
      if (this.burning == true)
      {
         int start_Time = frameCount;
         CannonBall cannonBall = new CannonBall(0, false);
         int damage = cannonBall.burn_Damage;
         int duration = cannonBall.burn_Duration;
         int tick = cannonBall.burn_Tick;
         
         if (frameCount < start_Time + duration && frameCount % tick == 0)
         {
            this.remaining_Health -= damage;
         }
      }
   }
}