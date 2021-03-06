
class BasicAI extends AI
{
   BasicAI()
   {
      super(random(0, view_Width), -100);
      attack_Sound = minim.loadFile("basic_ai_attack.mp3");
      
      w = 20;
      half_Width = w * 0.5f;
      h = w;
      half_Height = h * 0.5f;
      colour = color(255,0,50);
      max_Health = 20;
      remaining_Health = max_Health;
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
      getBurnStatus();
      
      // Set the AI to always face the player
      theta = atan2(game_Objects.get(0).position.y - position.y, game_Objects.get(0).position.x - position.x) + HALF_PI;
      
      // Calculate co-ordinates for moving forward, applying the speed multiplier also
      forward.x = sin(theta);
      forward.y = -cos(theta);
      forward.normalize();
      forward.mult(speed);

      // Make the AI follow the player, staying within range
      distance_To_Player = position.dist(game_Objects.get(0).position);
      if (distance_To_Player > target_Distance_From_Player)
      {
         position.add(forward);
      }
      
      // Shoot the player when within range
      if (distance_To_Player <= range && fireRate_Elapsed >= fireRate)
      {
         fireRate_Elapsed = 0;
         attackSound();
         
         Bullet lmg = new LMGBullet(1);
         lmg.position.x = position.x;
         lmg.position.y = position.y;
         lmg.colour = colour;
         lmg.theta = theta;
         lmg.enemy = true;
         game_Objects.add(lmg);
      }

      if (fireRate_Elapsed < fireRate)
         fireRate_Elapsed++;
   }
   
   void render()
   {
      pushMatrix();
      translate(position.x, position.y);
      
      healthbar();   // Health bar
      
      rotate(theta);
      fill(0);
      stroke(colour);
      strokeWeight(2);
      ellipse(0, 0, w, w);   // Body
      line(0, -10, 0, 0);   // Turret
      
      popMatrix();
   }
}