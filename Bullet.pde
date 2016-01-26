class Bullet extends GameObject
{
  int ammoType;
  int time = millis();
  float bulletSize;
   
  Bullet()
  {
    speed = 10.0f;
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
    strokeWeight(bulletSize);
    if (ammoType == 1)      // Determines what bullet to shoot based on current ammo type
       line(0, -5, 0, 5);
    if (ammoType == 2)
       ellipse(0,0,3,3);
    
    popMatrix();    
  }
  
  void update()
  {
    // Determining bulet size/speed based on ammo type
    if (ammoType == 1)
    {
       bulletSize = 1;
       speed = 10.0f;
    }
    else if (ammoType == 2)
    {
       bulletSize = 4;
       speed = 7.0f;
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