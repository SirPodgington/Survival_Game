
class AI extends GameObject
{
   float target_Distance_From_Player;
   float distance_To_Player;
   float range;
   int score_Value;
   
   AI(float startX, float startY)
   {
      super(startX, startY);
   }
   
   void render(){}
   void update(){}
   void attackSound(){}
}


// Draws health bar above the AI -----------------------------------------------------
void ai_HealthBar(float hp, float maxHP, float w, float halfW, float halfH)
{
   float offset = halfH + 15;
   fill(healthBar_Background);
   noStroke();
   rect(-halfW, -offset, w, 5);   // Background
   float hp_Mapped = map(hp, 0, maxHP, 0, w);
   fill(healthBar_Colour);
   rect(-halfW, -offset, hp_Mapped, 5);
}

// Controls AI Spawning -------------------------------------------------------------
int basic_SpawnTime = 4;
int heavy_SpawnTime = 15;

void spawnEnemies()
{
   // Basic AI
   if (frameCount % (60*basic_SpawnTime) == 0)
   {
      BasicAI unit = new BasicAI();
      game_Objects.add(unit);
   }
   
   // Heavy AI
   if (frameCount % (60*heavy_SpawnTime) == 0)
   {
      HeavyAI unit = new HeavyAI();
      game_Objects.add(unit);
   }
}