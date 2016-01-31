class Bullet extends GameObject
{
  int ammo_Type;
  int time = millis();
  color active_Colour;
  
  void render()
  {
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
       
       fill(active_Colour);
       ellipse(0, 0, 7, 7);
    }
    
    popMatrix();    
  }
  
  
  
  void update()
  {
    // Determining bullet size/speed based on ammo type
    if (ammo_Type == 1)
    {
       speed = 10;
       w = 2;
       h = 4;
    }
    else if (ammo_Type == 2)
       speed = 5;
    else if (ammo_Type == 3)
    {
       speed = 4;
       w = 1;
       h = 2;
    }
    
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);
    pos.add(forward);
    
    // Remove bullet if goes out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > view_Bottom_Boundry)
    {
      game_Objects.remove(this);
    }
  }
}