// The scoreboard. Displays the player's kills and score
void draw_Scoreboard()
{
   color scoreBoard_Colour = theme_Colour;
   float x = width - 20;
   float y = 20;
   fill(scoreBoard_Colour);
   textAlign(RIGHT,TOP);
   textSize(14);
   text("Kills: " + player.kills + "  |  Score: " + player.score, x, y);
}


void update_Upgrades()
{
   if (player.score >= player.cannon_Unlock_Score && player.cannon_Upgrade == false)   // Cannon Upgrade
   {
      player.upgradeSound();
      player.cannon_Upgrade = true;
   }
   
   //if (player.score >= player.cannon_Unlock_Score)   // Cannon Upgrade
      //player.cannon_Upgrade = true;
}


// The Player class
class Player extends GameObject
{
   char move, reverse, left, right;
   boolean alive, cannon_Upgrade, speed_Upgrade, explosive_Upgrade;
   int speedBoost_CD_Length, cannon_CD_Length, defShield_CD_Length, airstrike_CD_Length;
   int speedBoost_CD_Elapsed, cannon_CD_Elapsed, defShield_CD_Elapsed, airstrike_CD_Elapsed;
   int cannon_Unlock_Score, defShield_Unlock_Score, airstrike_Unlock_Score;
   int cannon_Upgrade_Score, defShield_Upgrade_Score, airstrike_Upgrade_Score, speed_Upgrade_Score, speedBoost_Upgrade_Score;
   int kills, score;
   float default_Speed, speedBoost_Speed;
   float turret_Theta;
   AudioPlayer speed_Sound, cannon_Sound, upgrade_Sound;
   
   Player()
   {
      super(view_Width*0.5f, view_Height*0.5f);
      upgrade_Sound = minim.loadFile("upgrade_sound.mp3");
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
      speedBoost_Speed = default_Speed * 4;
      fireRate = 15;   // lmg fire-rate
      fireRate_Elapsed = fireRate;
      cannon_CD_Length = 300;   // cannon cooldown (milliseconds)
      cannon_CD_Elapsed = cannon_CD_Length;
      cannon_Unlock_Score = 500;
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
      upgrade_Sound = minim.loadFile("upgrade_sound.mp3");
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      attack_Sound.setGain(-10);
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
      speedBoost_Speed = default_Speed * 4;
      fireRate = 15;   // lmg fire-rate
      fireRate_Elapsed = fireRate;
      cannon_CD_Length = 300;   // cannon cooldown (milliseconds)
      cannon_CD_Elapsed = cannon_CD_Length;
      cannon_Unlock_Score = 10;
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
   
   void upgradeSound()
   {
      if (upgrade_Sound.position() != 0)
         upgrade_Sound.rewind();
         
      upgrade_Sound.play();
   }
   
   /*****************/
   //     UPDATE     \ -----------------------------------------------------------------------------------
   /*****************/
   
   void update()
   {
      update_Upgrades();
      
      // Activate Speedboost
      if (keyPressed  &&  key == ' '  &&  speedBoost_CD_Elapsed >= speedBoost_CD_Length)
      {
         speedBoost_CD_Elapsed = 0;      // Reset elapsed timer
         speedSound();                   // Play sound effect
         cd_ActivationTime = millis();   // Store the activation time
      }
      
      // Apply Speedboost Effect
      if (time_Played < cd_ActivationTime + speedBoost_CD_Length  &&  time_Played > speedBoost_CD_Length)
         speed = speedBoost_Speed;
      else
         speed = default_Speed;

      // Calculate the X,Y values necessary for the tank to move forward in the direction of theta
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.mult(speed);         // Apply speed multiplier
      
      // Movement (Moving & Turning)
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

      // Turret points towards mouse position if mouse is within boundry
      if (mouseY < view_Bottom_Boundry)
         turret_Theta = atan2(mouseY - pos.y, mouseX - pos.x) + HALF_PI;
         
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
      
      // Increment the cooldown timers each frame
      if (fireRate_Elapsed < fireRate)
         fireRate_Elapsed++;
      if (speedBoost_CD_Elapsed < speedBoost_CD_Length)
         speedBoost_CD_Elapsed++;
      if (cannon_CD_Elapsed < cannon_CD_Length)
         cannon_CD_Elapsed++;
   }
   
   void render()
   {
       // --Player--
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(theta);   // Rotate sketch to the direction the player is facing
       
       fill(0);   // Player body colour
       stroke(colour);   // Player outline colour
       strokeWeight(3);   // Player outline thickness
       
       line(-8, -halfW, 0, -halfW - 7);   // Direction Indicator
       line(0, -halfW - 7, 8, -halfW);
       ellipse(0,0,w,w);   // Body
       popMatrix();
       
       // --Turret--
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turret_Theta);
       strokeWeight(1);
       fill(colour);
       
       if (cannon_Upgrade)   // Upgraded cannon
       {
          ellipse(0, 0, turret_Width, turret_Width);
          rect(-turret_HalfWidth, 0, turret_Width, -turret_Length);
       }
       else   // Default cannon
       {
          strokeWeight(3);
          line(0, 0, 0, -turret_Length);
       }
       popMatrix();
       
       // Crosshair (Mouse Position)
       stroke(colour);
       strokeWeight(1);
       line(mouseX-10, mouseY, mouseX-4, mouseY);    // Left line
       line(mouseX+10, mouseY, mouseX+4, mouseY);    // Right line
       line(mouseX, mouseY-10, mouseX, mouseY-4);    // Top line
       line(mouseX, mouseY+10, mouseX, mouseY+4);    // Bottom line
   }
}