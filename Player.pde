// The scoreboard. Displays the player's kills and score
void draw_Scoreboard()
{
   fill(ui_Background);
   textAlign(RIGHT,TOP);
   textSize(14);
   text("Kills: " + kill_Counter + "  |  Score: " + score, width-20,20);
}

// The Player class
class Player extends GameObject
{
   boolean alive;
   float turret_Theta = 0.0f;
   char move, reverse, left, right;
   boolean cannon_Upgrade, speed_Upgrade, explosive_Upgrade;
   int speedBoost_CD_Length, speedBoost_CD_Elapsed;
   int cannon_CD_Length, cannon_CD_Elapsed;
   AudioPlayer speed_Sound, cannon_Sound;
   
   
   Player()
   {
      super(view_Width*0.5f, view_Height*0.5f);
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      speed_Sound = minim.loadFile("speed_sound.mp3");
      
      w = 50;
      halfW = w / 2;
      turret_Width = w * 0.15f;
      turret_Length = halfW;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfLength = turret_Length / 2;
      colour = color(255,0,0);
      
      alive = true;
      maxHealth = 100;
      remainingHealth = maxHealth;
      default_Speed = 0.8;
      upgraded_Speed = default_Speed * 4;
      fireRate = 15;   // lmg fire-rate
      fireRate_Elapsed = fireRate;
      cannon_CD_Length = 300;   // cannon cooldown (milliseconds)
      cannon_CD_Elapsed = cannon_CD_Length;
      speedBoost_CD_Length = 1800;   // Speedboost cooldown (ms)
      speedBoost_CD_Elapsed = speedBoost_CD_Length;
      
      move = 'W';
      reverse = 'S';
      left = 'A';
      right = 'D';
   }
   
   Player(float startX, float startY, char move, char reverse, char left, char right)
   {
      super(startX, startY);
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      speed_Sound = minim.loadFile("speed_sound.mp3");
      
      w = 50;
      halfW = w / 2;
      turret_Width = w * 0.15;
      turret_Length = halfW;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfLength = turret_Length / 2;
      colour = color(255,155,0);
      
      alive = true;
      maxHealth = 100;
      remainingHealth = maxHealth;
      default_Speed = 0.8;
      upgraded_Speed = default_Speed * 4;
      fireRate = 15;   // lmg fire-rate
      fireRate_Elapsed = fireRate;
      cannon_CD_Length = 300;   // cannon cooldown (milliseconds)
      cannon_CD_Elapsed = cannon_CD_Length;
      speedBoost_CD_Length = 1800;   // Speedboost cooldown (ms)
      speedBoost_CD_Elapsed = speedBoost_CD_Length;
      
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
   }
   
   
   /*****************/
   //  PLAYER SOUNDS   \ -----------------------------------------------------------------------------------
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
      if (time_Played < cd_ActivationTime + speedBoost_CD_Length  &&  time_Played > speedBoost_CD_Length)
         speed = upgraded_Speed;
      else
         speed = default_Speed;
      
      // Activate Speed Boost
      if (keyPressed  &&  key == ' '  &&  speedBoost_CD_Elapsed >= speedBoost_CD_Length)
      {
         speedBoost_CD_Elapsed = 0;
         speedSound();
         cd_ActivationTime = millis();
      }
      
      // Calculate direction co-ords
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);
      
      // Turret points towards mouse position if mouse is within boundry
      if (mouseY < view_Bottom_Boundry)
         turret_Theta = atan2(mouseY - pos.y, mouseX - pos.x) + HALF_PI;
      
      // Player movement
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
      if (mousePressed && mouseButton == LEFT && fireRate_Elapsed >= fireRate)
      {
         fireRate_Elapsed = 0;
         lmgSound();
         
         Bullet lmg = new LMGBullet(2);
         lmg.pos.x = pos.x;
         lmg.pos.y = pos.y;
         lmg.colour = colour;
         lmg.theta = turret_Theta;
         game_Objects.add(lmg);
      }
      
      // Fire Cannon balls
      if (cannon_Upgrade && mousePressed && mouseButton == RIGHT && cannon_CD_Elapsed >= cannon_CD_Length)
      {
         cannon_CD_Elapsed = 0;
         cannonSound();
         
         Bullet cannon_Ball = new CannonBall(2, explosive_Upgrade);
         cannon_Ball.pos.x = pos.x;
         cannon_Ball.pos.y = pos.y;
         cannon_Ball.colour = colour;
         cannon_Ball.theta = turret_Theta;
         game_Objects.add(cannon_Ball);
      }
      
      // Keep Player within screen boundary
      if (pos.x < view_Left_Boundry + halfW)
            pos.x = view_Left_Boundry + halfW;
      if (pos.x > view_Right_Boundry - halfW)
            pos.x = view_Right_Boundry - halfW;
      if (pos.y < view_Top_Boundry + halfW)
            pos.y = view_Top_Boundry + halfW;
      if (pos.y > view_Bottom_Boundry - halfW)
            pos.y = view_Bottom_Boundry - halfW;
      
      // Increment the cooldowns each frame
      if (fireRate_Elapsed < fireRate)
         fireRate_Elapsed++;
      if (speedBoost_CD_Elapsed < speedBoost_CD_Elapsed)
         speedBoost_CD_Elapsed++;
      if (cannon_CD_Elapsed < cannon_CD_Elapsed)
         cannon_CD_Elapsed++;
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
       line(-8, -halfW, 0, -halfW - 7);
       line(0, -halfW - 7, 8, -halfW);
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
          rect(-turret_HalfWidth, 0, turret_Width, -turret_Length);
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