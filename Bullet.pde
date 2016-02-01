class Bullet extends GameObject
{
  color active_Colour;
  int ammo_Type;
  
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
       
       stroke(active_Colour);
       fill(active_Colour);
       ellipse(0, 0, w, w);
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
    {
       w = 10;
       h = w;
       speed = 5;
    }
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