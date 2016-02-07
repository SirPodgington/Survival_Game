class Bullet extends GameObject
{
  color active_Colour;
  int ammo_Type;
  float damage;
  int time;
  boolean enemy;
  
  Bullet(){}
  
  // UPDATE BULLET
  void update()
  {    
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);
    pos.add(forward);
    
    // Remove bullet if goes out of bounds
    if (pos.x < view_Left_Boundry || pos.y < view_Top_Boundry || pos.x > view_Right_Boundry || pos.y > view_Bottom_Boundry)
    {
      game_Objects.remove(this);
    }
  }
}


// ***************************

// LMG -----------------
class LMGBullet extends Bullet
{
   LMGBullet(int ammo_Type)
   {
      // Light LMG 
      if (ammo_Type == 1)
      {
         w = 1;
         h = 2;
         damage = 2;
         speed = 4;
      }
      
      // Heavy LMG
      else if (ammo_Type == 2)
      {
         w = 2;
         h = 4;
         damage = 3;
         speed = 10;
      }
      halfW = w / 2;
      halfH = h / 2; 
   }
   
   void render()
   {
      pushMatrix();
      
      translate(pos.x, pos.y);
      rotate(theta);
      
      active_Colour = colour;
      stroke(colour);
      strokeWeight(w);
      line(0, -h, 0, h);
      
      popMatrix();
   }
}


// Cannon Ball ----------------
class CannonBall extends Bullet
{  
   boolean explosive;
  
   CannonBall(int ammo_Type, boolean explosive)
   {
      // Small cannon ball
      if (ammo_Type == 1)
      {
         w = 6;
         h = w;
         damage = 10;
         speed = 5;
      }
      
      // Big cannon ball
      else if (ammo_Type == 2)
      {
         w = 10;
         h = w;
         damage = 15;
         speed = 5;
      }
      halfW = w / 2;
      halfH = h / 2; 
      
      // Store upgrade status
      this.explosive = explosive;
   }
   
   void render()
   {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(theta);
      active_Colour = colour;
      
      if (explosive)
      {
         int passed_Milliseconds = millis() - time;
         if (passed_Milliseconds >= 100)          // Cannon flashes white every 100 ms
         {
            time = millis();
            active_Colour = color(255);
         }
      }
      
      stroke(active_Colour);
      fill(active_Colour);
      ellipse(0, 0, w, w);
       
      popMatrix();    
   }
}