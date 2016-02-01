class Bullet extends GameObject
{
  color active_Colour;
  int ammo_Type;
  
  Bullet(){}
  Bullet(int ammo_Type)
  {
     this.ammo_Type = ammo_Type;
     
     if (ammo_Type == 1)
     {
        w = 2;
        h = 4;
        bullet_Damage = 10;
        speed = 10;
     }
     else if (ammo_Type == 2)
     {
        w = 10;
        h = w;
        bullet_Damage = 50;
        speed = 5;
     }
     else if (ammo_Type == 3)
     {
        
     }
     
     half_W = w / 2;
     half_H = h / 2; 
  }
  
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

// LMG -------------
// Light LMG bullets
class LMG extends Bullet
{
   LightLMG()
   {
      w = 1;
      h = 2;
      bullet_Damage = 2;
      speed = 4;
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

// Heavy LMG Bullets
class HeavyLMG extends LMG
{
   HeavyLMG()
   {
      w = 2;
      h = 4;
      bullet_Damage = 10;
      speed = 10;
   }
}





    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    active_Colour = colour;
    
    // Draws bullet according to ammo type
    if (ammo_Type == 1 || ammo_Type == 3)
    {
       stroke(colour);
       strokeWeight(w);
       line(0, -h, 0, h);
    }
    else if (ammo_Type == 2)
    {     
       // Cannon flashes white every 100 ms
       passed_Milliseconds = millis() - time;
       if (passed_Milliseconds >= 100)
       {
          time = millis();
          active_Colour = color(255);
       }
       
       stroke(active_Colour);
       fill(active_Colour);
       ellipse(0, 0, w, w);
    }
    
    popMatrix();    