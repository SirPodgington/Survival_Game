class Tank extends GameObject
{

   char move, reverse, left, right, fire;
   AudioPlayer moving, cannon;
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank.png");
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      speed = 2;
      moving = minim.loadFile("tank_moving.mp3");
      cannon = minim.loadFile("tank_cannon.mp3");
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
      moving = minim.loadFile("tank_moving.mp3");
      cannon = minim.loadFile("tank_cannon.mp3");
      
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
         moving.play();
         pos.add(forward);
      }
      else
      {
         moving.rewind();
      }
      
      if (keys[reverse])
      {
         pos.sub(forward.div(2));
      }
      if (keys[left])
      {
         theta -= 0.05f;
      }
      if (keys[right])
      {
         theta += 0.05f;
      }
      
      if (keys[fire])
      {
         println(cannon.length());
         if (cannon.position() == cannon.length())
         {
            cannon.rewind();
            cannon.play();
         }
         else cannon.play();
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