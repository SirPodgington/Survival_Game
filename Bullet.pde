class Bullet extends GameObject
{
  int ammo_Type;
  int time = millis();
  float bullet_Width, bullet_Length;
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    colour = color(255,0,0);
    
    if (ammo_Type == 1)      // Determines what bullet to shoot based on current ammo type
    {
       bullet_Width = 2;
       bullet_Length = 4;
       
       stroke(colour);
       strokeWeight(bullet_Width);
       line(0, -bullet_Length, 0, bullet_Length);
    }
    if (ammo_Type == 2)
    {
       bullet_Width = 7;
       passed_Milliseconds = millis() - time;
       if (passed_Milliseconds >= 100)
       {
          time = millis();
          colour = color(255);
       }
       
       fill(colour);
       ellipse(0, 0, bullet_Width, bullet_Width);
    }
    
    popMatrix();    
  }
  
  void update()
  {
    // Determining bullet size/speed based on ammo type
    if (ammo_Type == 1)
    {
       speed = 10.0f;
    }
    else if (ammo_Type == 2)
    {
       speed = 5.0f;
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