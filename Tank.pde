// Sounds cutting out after duration ..  need to fix


class Tank extends GameObject
{
   boolean alive;
   PImage tankTurret;
   float turretTheta = 0.0f;
   float turretW, turretH, turretHalfW, turretHalfH;
   char move, reverse, left, right, fire;
   color bulletCol = color(250);
   color cannonCol = color(0,0,200);
   float bulletFrate = 10;
   float cannonFrate = 60;
   AudioPlayer cannonSfx, bulletSfx;
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank_body_grey1.png");
      tankTurret = loadImage("tank_turret_default.png");
      cannonSfx = minim.loadFile("tank_cannon.mp3");
      bulletSfx = minim.loadFile("tank_bullet.wav");
      
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
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right, char fire)
   {
      super(startX, startY);
      sprite = loadImage("tank_body_black2.png");
      tankTurret = loadImage("tank_turret_default.png");
      cannonSfx = minim.loadFile("tank_cannon.mp3");
      bulletSfx = minim.loadFile("tank_bullet.wav");
      
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
      if (cannonSfx.position() != 0)
         cannonSfx.rewind();

      cannonSfx.play();
   }
   
   void bulletSound()
   {
      if (bulletSfx.position() != 0)
         bulletSfx.rewind();
         
      bulletSfx.play();
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
      
      if (mousePressed && mouseButton == LEFT && elapsed > bulletFrate)
      {
         elapsed = 0;
         bulletSound();
         
         Bullet bullet = new Bullet();
         bullet.pos.x = pos.x;
         bullet.pos.y = pos.y;
         bullet.ammoType = 1;
         bullet.pos.add(PVector.mult(forward, 6));
         bullet.colour = color(200,0,0);
         bullet.theta = turretTheta;
         gameObjects.add(bullet);
      }
      if (mousePressed && mouseButton == RIGHT && elapsed > cannonFrate)
      {
         elapsed = 0;
         cannonSound();
         
         Bullet shell = new Bullet();
         shell.pos.x = pos.x;
         shell.pos.y = pos.y;
         shell.ammoType = 2;
         shell.pos.add(PVector.mult(forward, 6));
         shell.colour = color(200,0,0);
         shell.theta = turretTheta;
         gameObjects.add(shell);
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