// Sounds cutting out after duration ..  need to fix


class Tank extends GameObject
{
   boolean alive;
   PImage tankTurret;
   float turretTheta;
   char move, reverse, left, right, fire;
   AudioPlayer moving, engine, cannon;
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank.png");
      tankTurret = loadImage("tank_turret.png");
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      speed = 0.8;
      alive = true;
      engine = minim.loadFile("tank_engine.mp3");
      moving = minim.loadFile("tank_moving.mp3");
      cannon = minim.loadFile("tank_cannon.mp3");
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right, char fire)
   {
      super(startX, startY);
      
      sprite = loadImage("tank_body.png");
      tankTurret = loadImage("tank_turret.png");
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      speed = 0.8;
      alive = true;
      engine = minim.loadFile("tank_engine.mp3");
      moving = minim.loadFile("tank_moving.mp3");
      cannon = minim.loadFile("tank_cannon.mp3");
      
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
      this.fire = fire;
   }
   
   
   /*****************/
   //  TANK SOUNDS   \ -----------------------------------------------------------------------------------
   /*****************/
   
   void engineSound()
   {
      if (engine.position() > engine.length() - 1)
      {
         engine.rewind();
      }
      engine.play();
   }
   
   void movingSound()
   {
      if (moving.position() > moving.length() - 2)
      {
         moving.rewind();
      }
      moving.play();
   }
   
   void cannonSound()
   {
      if (cannon.position() != 0)
      {
         cannon.rewind();
      }
      cannon.play();
   }
   
   
   /*****************/
   //     UPDATE     \ -----------------------------------------------------------------------------------
   /*****************/
   
   void update()
   {
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);
      
      if (alive)
            engineSound();
      
      if (keys[move])
      {
         movingSound();
         pos.add(forward);
      }
      else moving.pause();
      
      if (keys[reverse])
      {
         movingSound();
         pos.sub(forward.div(2));
      }
      
      if (keys[left])
      {
         theta -= 0.02f;
      }
      if (keys[right])
      {
         theta += 0.02f;
      }
      
      if (keys[fire])
      {
         cannonSound();
      }
      
      
      if (pos.x < halfW)
            pos.x = halfW;
      if (pos.x > width - halfW)
            pos.x = width - halfW;
      if (pos.y < halfH)
            pos.y = halfH;
      if (pos.y > height - halfW)
            pos.y = height - halfW;
   }
   
   void render()
   {
       pushMatrix();
       translate(pos.x, pos.y);
       
       rotate(theta);
       image(sprite, -halfW, -halfH);

       rotate(turretTheta);
       image(tankTurret, -(halfW*0.5), -halfW);
       popMatrix();
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}