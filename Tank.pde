// Sounds cutting out after duration ..  need to fix


class Tank extends GameObject
{
   boolean alive;
   PImage tankTurret;
   float turretTheta = 0.0f;
   float turretW, turretH, turretHalfW, turretHalfH;
   char move, reverse, left, right, fire;
   AudioPlayer cannon;
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank_body_grey2.png");
      tankTurret = loadImage("tank_turret_default.png");
      
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      turretW = tankTurret.width;
      turretH = tankTurret.height;
      turretHalfW = turretW / 2;
      turretHalfH = turretH / 2;
      speed = 0.8;
      alive = true;

      cannon = minim.loadFile("tank_cannon.mp3");
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right, char fire)
   {
      super(startX, startY);
      sprite = loadImage("tank_body_grey2.png");
      tankTurret = loadImage("tank_turret_default.png");
      
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      turretW = tankTurret.width;
      turretH = tankTurret.height;
      turretHalfW = turretW / 2;
      turretHalfH = turretH / 2;
      speed = 0.8;
      alive = true;

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
   
   int elapsed = 40;
   
   void update()
   {
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);
      
      // Switch between weapons
      if (keyPressed && key == '1')
         tankTurret = loadImage("tank_turret_default.png");
      if (keyPressed && key == '2')
         tankTurret = loadImage("tank_turret_upgraded.png");
      
      // Turret direction
      turretTheta = atan2(mouseY - pos.y, mouseX - pos.x) + HALF_PI;
      
      // Tank direction + speed
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
         theta -= 0.02f;
      }
      if (keys[right])
      {
         theta += 0.02f;
      }
      
      if (keys[fire] && elapsed > 40)
      {
         elapsed = 0;
         cannonSound();
         
         Bullet bullet = new Bullet();
         bullet.pos.x = pos.x;
         bullet.pos.y = pos.y;
         bullet.pos.add(PVector.mult(forward, 6));
         bullet.colour = color(200,0,0);
         bullet.theta = turretTheta;
         gameObjects.add(bullet);
      }
      
      // Keep tank within screen boundary
      if (pos.x < halfW)
            pos.x = halfW;
      if (pos.x > width - halfW)
            pos.x = width - halfW;
      if (pos.y < halfH)
            pos.y = halfH;
      if (pos.y > height - halfW)
            pos.y = height - halfW;
            
      elapsed++;
   }
   
   void render()
   {
       pushMatrix();
       translate(pos.x, pos.y);
       
       rotate(theta);
       image(sprite, -halfW, -halfH);

       popMatrix();
       
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turretTheta);
       image(tankTurret, -turretHalfW, -turretHalfH);
       
       popMatrix();
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}