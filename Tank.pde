// This is the player's character

class Tank extends GameObject
{
   PImage turret_Sprite;
   float turret_Theta = 0.0f;
   float turret_Width, turret_Height, turret_half_Width, turret_half_Height;
   char move, reverse, left, right;
   AudioPlayer cannon_Sound, speed_Sound;
   
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank_body_grey1.png");
      turret_Sprite = loadImage("tank_turret.png");
      cannon_Sound = minim.loadFile("tank_cannon_sound.mp3");
      gun_Sound = minim.loadFile("tank_lmg_sound.wav");
      speed_Sound = minim.loadFile("tank_speed_sound.mp3");
      
      w = sprite.width;
      h = sprite.height;
      half_W = w / 2;
      half_H = h / 2;
      turret_Width = turret_Sprite.width;
      turret_Height = turret_Sprite.height;
      turret_half_Width = turret_Width / 2;
      turret_half_Height = turret_Height / 2;
      
      default_Speed = 0.8;
      colour = color(255,0,0);
      
      fire_Rate = 10;   // lmg fire-rate
      fire_Rate_Elapsed = fire_Rate;
      cd1_Length = 300;   // cannon cooldown (milliseconds)
      cd1_Elapsed = cd1_Length;
      cd2_Length = 1800;   // Speedboost cooldown (ms)
      cd2_Elapsed = cd2_Length;
   
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right)
   {
      super(startX, startY);
      sprite = loadImage("tank_body_black2.png");
      turret_Sprite = loadImage("tank_turret_sprite.png");
      cannon_Sound = minim.loadFile("tank_cannon_sound.mp3");
      gun_Sound = minim.loadFile("tank_lmg_sound.wav");
      
      w = sprite.width;
      h = sprite.height;
      half_W = w / 2;
      half_H = h / 2;
      turret_Width = turret_Sprite.width;
      turret_Height = turret_Sprite.height;
      turret_half_Width = turret_Width / 2;
      turret_half_Height = turret_Height / 2;
      
      default_Speed = 0.8;
      colour = color(255,0,0);
      
      fire_Rate = 10;   // lmg fire-rate
      fire_Rate_Elapsed = fire_Rate;
      cd1_Length = 300;   // cannon cooldown (milliseconds)
      cd1_Elapsed = cd1_Length;
      cd2_Length = 1800;   // Speedboost cooldown (ms)
      cd2_Elapsed = cd2_Length;
      
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
      if (cannon_Sound.position() != 0)
         cannon_Sound.rewind();

      cannon_Sound.play();
   }
   
   void lmgSound()
   {
      if (gun_Sound.position() != 0)
         gun_Sound.rewind();
         
      gun_Sound.play();
   }
   
   void speedSound()
   {
      if (speed_Sound.position() != 0)
         speed_Sound.rewind();
         
      speed_Sound.play();
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
      if (mousePressed && mouseButton == LEFT && fire_Rate_Elapsed >= fire_Rate)
      {
         fire_Rate_Elapsed = 0;
         lmgSound();
         
         Bullet bullet = new Bullet();
         bullet.pos.x = pos.x;
         bullet.pos.y = pos.y;
         bullet.ammo_Type = 1;
         bullet.colour = colour;
         bullet.theta = turret_Theta;
         game_Objects.add(bullet);
      }
      
      // Fire cannon shells
      if (mousePressed && mouseButton == RIGHT && cd1_Elapsed >= cd1_Length)
      {
         cd1_Elapsed = 0;
         cannonSound();
         
         Bullet shell = new Bullet();
         shell.pos.x = pos.x;
         shell.pos.y = pos.y;
         shell.ammo_Type = 2;
         shell.colour = colour;
         shell.theta = turret_Theta;
         game_Objects.add(shell);
      }
      
      // Speed Boost CD
      if (keyPressed && key == ' ' && cd2_Elapsed >= cd2_Length)
      {
         cd2_Length = 0;
         speedSound();
         
         
      }
      
      if 
      
      // Keep tank within screen boundary
      if (pos.x < view_Left_Boundry + half_W)
            pos.x = view_Left_Boundry + half_W;
      if (pos.x > view_Right_Boundry - half_W)
            pos.x = view_Right_Boundry - half_W;
      if (pos.y < view_Top_Boundry + half_H)
            pos.y = view_Top_Boundry + half_H;
      if (pos.y > view_Bottom_Boundry - half_W)
            pos.y = view_Bottom_Boundry - half_W;
      
      // Increment the cooldowns each frame
      if (fire_Rate_Elapsed < fire_Rate)
         fire_Rate_Elapsed++;
      if (cd1_Elapsed < cd1_Length)
         cd1_Elapsed++;
   }
   
   void render()
   {
       pushMatrix();
       
       // Tank body
       translate(pos.x, pos.y);
       rotate(theta);
       image(sprite, -half_W, -half_H);
       
       // Tank direction indicator
       stroke(colour);
       strokeWeight(1);
       line(-8, -25, 0, -30);
       line(0, -30, 8, -25);
       popMatrix();
       
       // Tank turret
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turret_Theta);
       image(turret_Sprite, -turret_half_Width, -turret_half_Height);
       popMatrix();
       
       // Crosshair
       stroke(colour);
       strokeWeight(1);
       line(mouseX-10, mouseY, mouseX-4, mouseY);    // Left line
       line(mouseX+10, mouseY, mouseX+4, mouseY);    // Right line
       line(mouseX, mouseY-10, mouseX, mouseY-4);    // Top line
       line(mouseX, mouseY+10, mouseX, mouseY+4);    // Bottom line
   }
}