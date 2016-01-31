
class BasicAI extends AI
{
   
   
   BasicAI()
   {
      super(50, 50);
      w = 20;
      half_W = w * 0.5f;
      speed = 0.5;
      colour = color(random(50,250), 0, 0);
      target_Distance_From_Player = 120;
      range = 150;
      fire_Rate = 180;
   }
   
   void update()
   {
      // Set the AI to always face the player
      theta = atan2(game_Objects.get(0).pos.y - pos.y, game_Objects.get(0).pos.x - pos.x) + HALF_PI;
      
      // Calculate co-ordinates for moving forward, applying the speed multiplier also
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.normalize();
      forward.mult(speed);

      // Make the AI follow the player, staying within range
      distance_To_Player = pos.dist(game_Objects.get(0).pos);
      if (distance_To_Player > target_Distance_From_Player)
      {
         pos.add(forward);
      }
      
      // Shoot the player when within range
      if (distance_To_Player <= range && cooldown1 >= fire_Rate)
      {
         cooldown1 = 0;
         
      }

      if (cooldown1 < fire_Rate)
         cooldown1++;
   }
   
   void render()
   {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(theta);
      
      fill(0);
      stroke(colour);
      strokeWeight(3);
      
      ellipse(0, 0, w, w);
      line(0, -10, 0, 0);
      popMatrix();
   }
}