// This is the player's character

class Tank extends GameObject
{
   PImage turret_Sprite;
   float turret_Theta = 0.0f;
   float turret_Width, turret_Height, turret_HalfWidth, turret_HalfHeight;
   char move, reverse, left, right;
   int lmg_FireRate, cannon_FireRate;
   color crosshairCol;
   AudioPlayer cannonSfx, bulletSfx;
   
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank_body_grey1.png");
      turret_Sprite = loadImage("tank_turret_default.png");
      cannonSfx = minim.loadFile("tank_cannon.mp3");
      bulletSfx = minim.loadFile("tank_bullet.wav");
      
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      turret_Width = turret_Sprite.width;
      turret_Height = turret_Sprite.height;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfHeight = turret_Height / 2;
      
      speed = 0.8;
      crosshairCol = color(255,0,0);
      
      lmg_FireRate = 10;
      cooldown1 = lmg_FireRate;
      cannon_FireRate = 300;
      cooldown2 = cannon_FireRate;
   
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right)
   {
      super(startX, startY);
      sprite = loadImage("tank_body_black2.png");
      turret_Sprite = loadImage("tank_turret_default.png");
      cannonSfx = minim.loadFile("tank_cannon.mp3");
      bulletSfx = minim.loadFile("tank_bullet.wav");
      
      w = sprite.width;
      h = sprite.height;
      halfW = w / 2;
      halfH = h / 2;
      turret_Width = turret_Sprite.width;
      turret_Height = turret_Sprite.height;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfHeight = turret_Height / 2;
      
      speed = 0.8;
      crosshairCol = color(255,0,0);
      
      lmg_FireRate = 10;
      cooldown1 = lmg_FireRate;
      cannon_FireRate = 300;
      cooldown2 = cannon_FireRate;
      
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
      // Calculate tank direction & apply speed factor
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);
      
      // Turret points towards mouse position if mouse is within boundry
      if (mouseY < view_Bottom_Boundry)
         turret_Theta = atan2(mouseY - pos.y, mouseX - pos.x) + HALF_PI;
      
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
      if (mousePressed && mouseButton == LEFT && cooldown1 >= lmg_FireRate)
      {
         cooldown1 = 0;
         bulletSound();
         
         Bullet bullet = new Bullet();
         bullet.pos.x = pos.x;
         bullet.pos.y = pos.y;
         bullet.ammoType = 1;
         //bullet.pos.add(PVector.mult(forward, 0));
         bullet.theta = turret_Theta;
         game_Objects.add(bullet);
      }
      
      // Fire cannon shells
      if (mousePressed && mouseButton == RIGHT && cooldown2 >= cannon_FireRate)
      {
         cooldown2 = 0;
         cannonSound();
         
         Bullet shell = new Bullet();
         shell.pos.x = pos.x;
         shell.pos.y = pos.y;
         shell.ammoType = 2;
         //shell.pos.add(PVector.mult(forward, 0));
         shell.theta = turret_Theta;
         game_Objects.add(shell);
      }
      
      // Keep tank within screen boundary
      if (pos.x < view_Left_Boundry + halfW)
            pos.x = view_Left_Boundry + halfW;
      if (pos.x > view_Right_Boundry - halfW)
            pos.x = view_Right_Boundry - halfW;
      if (pos.y < view_Top_Boundry + halfH)
            pos.y = view_Top_Boundry + halfH;
      if (pos.y > view_Bottom_Boundry - halfW)
            pos.y = view_Bottom_Boundry - halfW;
      
      // Keep cooldown timers within range
      if (cooldown1 < 10)
         cooldown1++;
      if (cooldown2 < 300)
         cooldown2++;
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
       rotate(turret_Theta);
       image(turret_Sprite, -turret_HalfWidth, -turret_HalfHeight);
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