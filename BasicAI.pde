
public class BasicAI extends GameObject
{
   float bullet_Range;
   
   BasicAI()
   {
      super(50, 50);
      w = 20;
      halfW = w * 0.5f;
      speed = 0.6;
      colour = color(random(50,250), 0, 0);
      bullet_Range = 120;
   }
   
   void update()
   {
      // Set the AI to always face the player
      theta = atan2(game_Objects.get(0).pos.y - pos.y, game_Objects.get(0).pos.x - pos.x) + HALF_PI;
      
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.normalize();
      forward.mult(speed);

      // Make the AI follow the player, staying within range
      if (pos.dist(game_Objects.get(0).pos) > bullet_Range)
      {
         pos.add(forward);
      }
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