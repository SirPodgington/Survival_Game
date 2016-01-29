
public class BasicAI extends GameObject
{
   BasicAI()
   {
      super(50, 50);
      w = 20;
      halfW = w/2;
      speed = 0.6;
      colour = color(random(50,250), 0, 0);
   }
   
   void update()
   {
      theta = atan2(game_Objects.get(0).pos.y - pos.y, game_Objects.get(0).pos.x - pos.x) + HALF_PI;
   }
   
   void render()
   {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(theta);
      
      fill(0);
      stroke(colour);
      strokeWeight(1);
      
      ellipse(0, 0, w, w);
      line(0, -10, 0, 0);
      popMatrix();
   }
}