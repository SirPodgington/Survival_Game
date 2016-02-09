
class AI extends GameObject
{
   float target_Distance_From_Player;
   float distance_To_Player;
   float range;
   int score_Value;
   boolean burning;
   
   AI(float startX, float startY)
   {
      super(startX, startY);
   }
   
   void render(){}
   void update(){}
   void attackSound(){}
   
   // AI Healthbar
   void ai_HealthBar()
   {
      color healthBar_Background = color(127);
      float offset = halfH + 15;
      fill(healthBar_Background);
      noStroke();
      rect(-halfW, -offset, w, 5);   // Total Health
   
      color healthBar_Colour = color(0,255,0);
      float hp_Mapped = map(remainingHealth, 0, maxHealth, 0, w);
      fill(healthBar_Colour);
      rect(-halfW, -offset, hp_Mapped, 5);   // Remaining Health
   }
   
   void check_Burning_Status()
   {
      if (this.burning == true)
      {
         println("Burn active");
         int start_Time = frameCount;
         CannonBall cannonBall = new CannonBall(0, false);
         int damage = cannonBall.burn_Damage;
         int duration = cannonBall.burn_Duration;
         int tick = cannonBall.burn_Tick;
         
         if (frameCount < start_Time + duration && frameCount % tick == 0)
         {
            this.remainingHealth -= damage;
         }
      }
   }
}