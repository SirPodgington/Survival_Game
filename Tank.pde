// This is the player's character

class Tank extends GameObject
{
   float turret_Theta = 0.0f;
   float turret_Width, turret_Length, turret_Half_Width, turret_Half_Length;
   char move, reverse, left, right;
   AudioPlayer cannon_Sound, speed_Sound;
   
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      cannon_Sound = minim.loadFile("tank_cannon_sound.mp3");
      gun_Sound = minim.loadFile("tank_lmg_sound.wav");
      speed_Sound = minim.loadFile("tank_speed_sound.mp3");
      
      w = 50;
      half_W = w / 2;
      turret_Width = w * 0.2f;
      turret_Length = half_W;
      turret_Half_Width = turret_Width / 2;
      turret_Half_Length = turret_Length / 2;
      colour = color(255,0,0);
      
      default_Speed = 0.8;
      upgraded_Speed = default_Speed * 1.75f;
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
      cannon_Sound = minim.loadFile("tank_cannon_sound.mp3");
      gun_Sound = minim.loadFile("tank_lmg_sound.wav");
      speed_Sound = minim.loadFile("tank_speed_sound.mp3");
      
      w = 50;
      half_W = w / 2;
      turret_Width = 10;
      turret_Length = half_W;
      turret_Half_Width = turret_Width / 2;
      turret_Half_Length = turret_Length / 2;
      colour = color(255,155,0);
      
      default_Speed = 0.8;
      upgraded_Speed = default_Speed * 4;
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
      if (millis() < cd_Start_Time + cd2_Length && millis() > cd2_Length)
      {
         speed = upgraded_Speed;
      }
      else
         speed = default_Speed;
      
      // Speed Boost CD
      if (keyPressed && key == ' ' && cd2_Elapsed >= cd2_Length)
      {
         cd2_Elapsed = 0;
         speedSound();
         cd_Start_Time = millis();
      }
      
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
      
      
      
      
      // Keep tank within screen boundary
      if (pos.x < view_Left_Boundry + half_W)
            pos.x = view_Left_Boundry + half_W;
      if (pos.x > view_Right_Boundry - half_W)
            pos.x = view_Right_Boundry - half_W;
      if (pos.y < view_Top_Boundry + half_W)
            pos.y = view_Top_Boundry + half_W;
      if (pos.y > view_Bottom_Boundry - half_W)
            pos.y = view_Bottom_Boundry - half_W;
      
      // Increment the cooldowns each frame
      if (fire_Rate_Elapsed < fire_Rate)
         fire_Rate_Elapsed++;
      if (cd1_Elapsed < cd1_Length)
         cd1_Elapsed++;
      if (cd2_Elapsed < cd2_Length)
         cd2_Elapsed++;
   }
   
   void render()
   {
       // Player body & direction indicator
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(theta); 
       fill(0);
       stroke(colour);
       strokeWeight(3);
       
       // Direction Indicator
       line(-8, -half_W, 0, -half_W - 7);
       line(0, -half_W - 7, 8, -half_W);
       // Body
       ellipse(0,0,w,w);
       
       popMatrix();
       
       
       // Turret Base & Barrel
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turret_Theta);
       strokeWeight(1);
       stroke(colour);
       fill(colour);
       
       // Base
       ellipse(0, 0, turret_Width, turret_Width);
       // Barrel
       rect(-turret_Half_Width, 0, turret_Width, -turret_Length);
       
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