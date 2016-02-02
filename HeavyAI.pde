

class HeavyAI extends AI
{
   HeavyAI()
   {
      super(100, 500);
      w = 40;
      half_W = w * 0.5f;
      colour = color(255,0,50);
      attack_Sound = minim.loadFile("cannon_sound.mp3");
      
      max_Health = 50;
      health = max_Health;
      speed = 0.5;
      target_Distance_From_Player = 200;
      range = 300;
      fire_Rate = 300;
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
      if (distance_To_Player <= range  &&  fire_Rate_Elapsed >= fire_Rate)
      {
         fire_Rate_Elapsed = 0;
         attackSound();
         
         Bullet cannon = new CannonBall(1, false);
         cannon.pos.x = pos.x;
         cannon.pos.y = pos.y;
         cannon.colour = colour;
         cannon.theta = theta;
         cannon.enemy_Bullet = true;
         game_Objects.add(cannon);
      }

      if (fire_Rate_Elapsed < fire_Rate)
         fire_Rate_Elapsed++;
   }
   
   void render()
   {
      pushMatrix();
      translate(pos.x, pos.y);
      
      // Health bar
      fill(healthBar_Background);
      noStroke();
      rect(-half_W, -25, w, 5); // background
      float hp_Mapped = map(health, 0, max_Health, 0, w);
      fill(healthBar_Colour);
      rect(-half_W, -25, hp_Mapped, 5);

      
      fill(0);
      stroke(colour);
      strokeWeight(2);
      
      rotate(theta);
      ellipse(0, 0, w, w);
      line(0, -10, 0, 0);
      popMatrix();
   }
}