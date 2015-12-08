class Tank extends GameObject
{
   
   char move, reverse, left, right, fire;
   
   Tank()
   {
      super(width*0.5f, height*0.8f, width*0.1f);
      colour = color(255);
      outline = color(255);
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right, char fire, color colour)
   {
      super(startX, startY, width*0.1f);
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
      this.fire = fire;
      this.colour = colour;
   }
   
   
   void update()
   {
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);
      
      if (keys[move])
      {
        pos.add(forward);
      }
      if (keys[reverse])
      {
         pos.sub(forward);
      }
      if (keys[left])
      {
        theta -= 0.1f;
      }
      if (keys[right])
      {
        theta += 0.1f;
      }
   }
   
   void render()
   {
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(theta);
       
       stroke(outline);
       fill(colour);
       ellipse(0, 0, 50, 50); // temp circle
       
       popMatrix();
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}