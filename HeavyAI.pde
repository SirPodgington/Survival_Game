

class HeavyAI extends AI
{
   HeavyAI()
   {
      super(random(0, view_Width), -100);
      attack_Sound = minim.loadFile("cannon_sound.mp3");
      
      w = 40;
      halfW = w * 0.5f;
      h = w;
      halfH = h * 0.5f;
      turret_Width = w * 0.15f;
      turret_Length = halfW;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfLength = turret_Length / 2;
      colour = color(255,0,50);
      
      maxHealth = 50;
      remainingHealth = maxHealth;
      speed = 0.5;
      target_Distance_From_Player = 200;
      range = 300;
      fireRate = 300;
      score_Value = 50;
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
      if (distance_To_Player <= range  &&  fireRate_Elapsed >= fireRate)
      {
         fireRate_Elapsed = 0;
         attackSound();
         
         Bullet cannon = new CannonBall(1, false);
         cannon.pos.x = pos.x;
         cannon.pos.y = pos.y;
         cannon.colour = colour;
         cannon.theta = theta;
         cannon.enemy = true;
         game_Objects.add(cannon);
      }

      if (fireRate_Elapsed < fireRate)
         fireRate_Elapsed++;
   }
   
   void render()
   {
      pushMatrix();
      translate(pos.x, pos.y);
      
      // Health bar
      ai_HealthBar(remainingHealth, maxHealth, w, halfW, halfH);

      // Unit
      rotate(theta);
      fill(0);
      stroke(colour);
      strokeWeight(2);
      ellipse(0, 0, w, w);   // The body
      fill(colour);
      rect(-turret_HalfWidth, 0, turret_Width, -turret_Length);   // The turret
      ellipse(0, 0, turret_Width, turret_Width);   // The turret base
      popMatrix();
   }
}