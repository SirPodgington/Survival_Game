class Bullet extends GameObject
{
  int ammoType;
  int time = millis();
  float bulletWidth, bulletLength, cannonWidth;
   
  Bullet()
  {
     bulletWidth = 2;
     bulletLength = 4;
     cannonWidth = 5;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    colour = color(255,0,0);
    int passedMillis = millis() - time;
    if (passedMillis >= 100 && ammoType == 2)    // Cannon flashes every 100 milliseconds
    {
       time = millis();
       colour = color(255);
    }
    
    fill(colour);
    stroke(colour);
    strokeWeight(bulletWidth);
    if (ammoType == 1)      // Determines what bullet to shoot based on current ammo type
       line(0, -bulletLength, 0, bulletLength);
    if (ammoType == 2)
       ellipse(0, 0, cannonWidth, cannonWidth);
    
    popMatrix();    
  }
  
  void update()
  {
    // Determining bullet size/speed based on ammo type
    if (ammoType == 1)
    {
       speed = 10.0f;
    }
    else if (ammoType == 2)
    {
       speed = 5.0f;
    }
    
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);
    pos.add(forward);
    
    // Remove bullet if goes out of bounds
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      gameObjects.remove(this);
    }
  }
}