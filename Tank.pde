class Tank extends GameObject
{

   char move, reverse, left, right, fire;
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank.png");
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      speed = 2;
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right, char fire)
   {
      super(startX, startY);
      
      sprite = loadImage("tank.png");
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      speed = 2;
      
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
      this.fire = fire;
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
         pos.sub(forward.div(2));
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
       image(sprite, -halfW, -halfH);
       //ellipse(0, 0, 50, 50); // temp circle
       
       popMatrix();
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}