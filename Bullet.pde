class Bullet extends GameObject
{
  
  Bullet()
  {
    speed = 10.0f;
  }
  
  void render()
  {
    stroke(200,0,0);
    strokeWeight(4);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    line(0, -5, 0, 5);
    popMatrix();    
  }
  
  void update()
  {
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