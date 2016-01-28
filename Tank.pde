
class Tank extends GameObject
{
   PImage tankTurret;
   float turretTheta = 0.0f;
   float turretW, turretH, turretHalfW, turretHalfH;
   char move, reverse, left, right;
   color bulletCol = color(250);
   color cannonCol = color(0,0,200);
   color crosshairCol = color(255,0,0);
   int bulletFrate;
   int cannonFrate;
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
      bulletFrate = 10;
      cooldown1 = bulletFrate;
      cannonFrate = 300;
      cooldown2 = cannonFrate;
   
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right)
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
      bulletFrate = 10;
      cooldown1 = bulletFrate;
      cannonFrate = 300;
      cooldown2 = cannonFrate;
      
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
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
   
   void update()
   {
      // Calculate tank position & apply speed factor
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);
      
      // Switch between weapons
      if (keyPressed && key == '1')
         tankTurret = loadImage("tank_turret_default.png");
      if (keyPressed && key == '2')
         ;// ....
      
      // Turret points towards mouse position if mouse is within boundry
      if (mouseY < bBoundry)
         turretTheta = atan2(mouseY - pos.y, mouseX - pos.x) + HALF_PI;
      
      // Tank movement
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
      
      // Fire bullets
      if (mousePressed && mouseButton == LEFT && cooldown1 >= bulletFrate)
      {
         cooldown1 = 0;
         bulletSound();
         
         Bullet bullet = new Bullet();
         bullet.pos.x = pos.x;
         bullet.pos.y = pos.y;
         bullet.ammoType = 1;
         bullet.pos.add(PVector.mult(forward, 0));
         bullet.theta = turretTheta;
         gameObjects.add(bullet);
      }
      
      // Fire cannon shells
      if (mousePressed && mouseButton == RIGHT && cooldown2 >= cannonFrate)
      {
         cooldown2 = 0;
         cannonSound();
         
         Bullet shell = new Bullet();
         shell.pos.x = pos.x;
         shell.pos.y = pos.y;
         shell.ammoType = 2;
         shell.pos.add(PVector.mult(forward, 0));
         shell.theta = turretTheta;
         gameObjects.add(shell);
      }
      
      // Keep tank within screen boundary
      if (pos.x < lBoundry + halfW)
            pos.x = lBoundry + halfW;
      if (pos.x > rBoundry - halfW)
            pos.x = rBoundry - halfW;
      if (pos.y < tBoundry + halfH)
            pos.y = tBoundry + halfH;
      if (pos.y > bBoundry - halfW)
            pos.y = bBoundry - halfW;
      
      // Keep cooldown timers within range
      if (cooldown1 < 10)
         cooldown1++;
      if (cooldown2 < 300)
         cooldown2++;
   }
   
   int cannonCooldown(int elapsed)
   {
      return(elapsed);
   }
   
   void render()
   {
       // Tank body
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(theta);
       image(sprite, -halfW, -halfH);
       stroke(70);
       strokeWeight(1);
       line(-8, -25, 0, -30);
       line(0, -30, 8, -25);
       popMatrix();
       
       // Tank turret
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turretTheta);
       image(tankTurret, -turretHalfW, -turretHalfH);
       popMatrix();
       
       // Crosshair
       stroke(crosshairCol);
       strokeWeight(1);
       line(mouseX-10, mouseY, mouseX-4, mouseY);    // Left line
       line(mouseX+10, mouseY, mouseX+4, mouseY);    // Right line
       line(mouseX, mouseY-10, mouseX, mouseY-4);    // Top line
       line(mouseX, mouseY+10, mouseX, mouseY+4);    // Bottom line
   }
}