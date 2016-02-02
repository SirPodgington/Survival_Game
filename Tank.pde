// This is the player's character

class Tank extends GameObject
{
   float turret_Theta = 0.0f;
   float turret_Width, turret_Length, turret_Half_Width, turret_Half_Length;
   char move, reverse, left, right;
   boolean cannon_Upgrade, speed_Upgrade, explosive_Upgrade;
   AudioPlayer speed_Sound, cannon_Sound;
   
   
   Tank()
   {
      super(view_Width*0.5f, view_Height*0.5f);
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      speed_Sound = minim.loadFile("speed_sound.mp3");
      
      w = 50;
      half_W = w / 2;
      turret_Width = w * 0.2f;
      turret_Length = half_W;
      turret_Half_Width = turret_Width / 2;
      turret_Half_Length = turret_Length / 2;
      colour = color(255,0,0);
      
      max_Health = 100;
      health = max_Health;
      default_Speed = 0.8;
      upgraded_Speed = default_Speed * 4;
      fire_Rate = 15;   // lmg fire-rate
      fire_Rate_Elapsed = fire_Rate;
      cd1_Duration = 300;   // cannon cooldown (milliseconds)
      cd1_Elapsed = cd1_Duration;
      cd2_Duration = 1800;   // Speedboost cooldown (ms)
      cd2_Elapsed = cd2_Duration;
      
      move = 'W';
      reverse = 'S';
      left = 'A';
      right = 'D';
   }
   
   Tank(float startX, float startY, char move, char reverse, char left, char right)
   {
      super(startX, startY);
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      speed_Sound = minim.loadFile("speed_sound.mp3");
      
      w = 50;
      half_W = w / 2;
      turret_Width = 10;
      turret_Length = half_W;
      turret_Half_Width = turret_Width / 2;
      turret_Half_Length = turret_Length / 2;
      colour = color(255,155,0);
      
      max_Health = 100;
      health = max_Health;
      default_Speed = 0.8;
      upgraded_Speed = default_Speed * 4;
      fire_Rate = 15;   // lmg fire-rate
      fire_Rate_Elapsed = fire_Rate;
      cd1_Duration = 300;   // cannon cooldown (milliseconds)
      cd1_Elapsed = cd1_Duration;
      cd2_Duration = 1800;   // Speedboost cooldown (ms)
      cd2_Elapsed = cd2_Duration;
      
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
      if (attack_Sound.position() != 0)
         attack_Sound.rewind();
         
      attack_Sound.play();
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
      // Check for Speed Boost cooldown
      if (time_Played < cd_Activation_Time + cd2_Duration  &&  time_Played > cd2_Duration)
         speed = upgraded_Speed;
      else
         speed = default_Speed;
      
      // Activate Speed Boost
      if (keyPressed  &&  key == ' '  &&  cd2_Elapsed >= cd2_Duration)
      {
         cd2_Elapsed = 0;
         speedSound();
         cd_Activation_Time = millis();
      }
      
      // Calculate direction co-ords
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
      
      // Fire LMG bullets
      if (mousePressed && mouseButton == LEFT && fire_Rate_Elapsed >= fire_Rate)
      {
         fire_Rate_Elapsed = 0;
         lmgSound();
         
         Bullet lmg = new LMGBullet(2);
         lmg.pos.x = pos.x;
         lmg.pos.y = pos.y;
         lmg.colour = colour;
         lmg.theta = turret_Theta;
         game_Objects.add(lmg);
      }
      
      // Fire Cannon balls
      if (cannon_Upgrade && mousePressed && mouseButton == RIGHT && cd1_Elapsed >= cd1_Duration)
      {
         cd1_Elapsed = 0;
         cannonSound();
         
         Bullet cannon_Ball = new CannonBall(2, explosive_Upgrade);
         cannon_Ball.pos.x = pos.x;
         cannon_Ball.pos.y = pos.y;
         cannon_Ball.colour = colour;
         cannon_Ball.theta = turret_Theta;
         game_Objects.add(cannon_Ball);
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
      if (cd1_Elapsed < cd1_Duration)
         cd1_Elapsed++;
      if (cd2_Elapsed < cd2_Duration)
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
       
       
       // Turret
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turret_Theta);
       strokeWeight(1);
       fill(colour);
       
       if (cannon_Upgrade)
       {
          ellipse(0, 0, turret_Width, turret_Width);
          rect(-turret_Half_Width, 0, turret_Width, -turret_Length);
       }
       else
       {
          strokeWeight(3);
          line(0, 0, 0, -turret_Length);
       }
       
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