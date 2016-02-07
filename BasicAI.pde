
class BasicAI extends AI
{
   BasicAI()
   {
      super(150, 150);
      w = 20;
      halfW = w * 0.5f;
      colour = color(255,0,50);
      attack_Sound = minim.loadFile("basic_ai_attack.mp3");
      
      maxHealth = 15;
      currentHealth = maxHealth;
      speed = 0.5;
      target_Distance_From_Player = 120;
      range = 200;
      fireRate = 180;
      score_Value = 10;
   }
   
   void attackSound()
   {
      if (attack_Sound.position() != 0)
         attack_Sound.rewind();

      attack_Sound.play();
   }
   
   void update()
   {      
      // Set the AI to always face the player
      theta = atan2(game_Objects.get(0).pos.y - pos.y, game_Objects.get(0).pos.x - pos.x) + HALF_PI;
      
      // Calculate co-ordinates for moving forward, applying the speed multiplier also
      forward.x = sin(theta);
      forward.y = -cos(theta);
      forward.normalize();
      forward.mult(speed);

      // Make the AI follow the player, staying within range
      distance_To_Player = pos.dist(game_Objects.get(0).pos);
      if (distance_To_Player > target_Distance_From_Player)
      {
         pos.add(forward);
      }
      
      // Shoot the player when within range
      if (distance_To_Player <= range && fireRate_Elapsed >= fireRate)
      {
         fireRate_Elapsed = 0;
         attackSound();
         
         Bullet lmg = new LMGBullet(1);
         lmg.pos.x = pos.x;
         lmg.pos.y = pos.y;
         lmg.colour = colour;
         lmg.theta = theta;
         lmg.enemy_Bullet = true;
         game_Objects.add(lmg);
      }

      if (fireRate_Elapsed < fireRate)
         fireRate_Elapsed++;
   }
   
   void render()
   {
      pushMatrix();
      translate(pos.x, pos.y);
      
      // Health bar
      fill(healthBar_Background);
      noStroke();
      rect(-halfW, -25, w, 5); // background
      float hp_Mapped = map(currentHealth, 0, maxHealth, 0, w);
      fill(healthBar_Colour);
      rect(-halfW, -25, hp_Mapped, 5);

      
      fill(0);
      stroke(colour);
      strokeWeight(2);
      
      rotate(theta);
      ellipse(0, 0, w, w);
      line(0, -10, 0, 0);
      popMatrix();
   }
}