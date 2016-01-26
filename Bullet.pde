class Bullet extends GameObject
{
  int ammoType;
  float bulletSize;
   
  Bullet()
  {
    speed = 10.0f;
  }
  
  void render()
  {
    stroke(colour);
    strokeWeight(bulletSize);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    // Determining the ammo type
    if (ammoType == 1)
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