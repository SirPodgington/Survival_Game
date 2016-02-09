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


// The Player class
class Player extends GameObject
{
   int kills, score;
   char move, reverse, left, right, speedboost, shield, airstrike;
   boolean alive;
   boolean cannon_Unlocked, shield_Unlocked, airstrike_Unlocked;
   boolean cannon_Upgraded, shield_Upgraded, airstrike_Upgraded, speed_Upgraded, speedBoost_Upgraded;
   boolean shield_Active, speedBoost_Active;
   int speedBoost_CD_Length, cannon_CD_Length, shield_CD_Length, airstrike_CD_Length;
   int speedBoost_CD_Elapsed, cannon_CD_Elapsed, shield_CD_Elapsed, airstrike_CD_Elapsed;
   int cannon_Unlock_Score, shield_Unlock_Score, airstrike_Unlock_Score;
   int cannon_Upgrade_Score, shield_Upgrade_Score, airstrike_Upgrade_Score, speed_Upgrade_Score, speedBoost_Upgrade_Score;
   int shield_CD_Duration, shield_Default_Duration, shield_Upgraded_Duration, shield_CD_ActivationTime;
   int speedBoost_CD_Duration, speedBoost_CD_ActivationTime;
   float shield_Width;
   float default_Speed, original_Speed, upgraded_Speed, speedBoost_Speed;
   float turret_Theta;
   AudioPlayer speed_Sound, cannon_Sound, shield_Sound, airstrike_Sound, upgrade_Sound;
   
   Player()
   {
      // Player Properties
      super(view_Width*0.5f, view_Height*0.5f);   // Position
      w = 50;
      halfW = w / 2;
      turret_Width = w * 0.15f;
      turret_Length = halfW;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfLength = turret_Length / 2;
      shield_Width = w * 1.75;
      colour = color(255,0,0);
      
      // Sounds
      upgrade_Sound = minim.loadFile("upgrade_sound.mp3");
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      attack_Sound.setGain(-10);
      speed_Sound = minim.loadFile("speed_sound.mp3");
      shield_Sound = minim.loadFile("defshield_sound.mp3");
      shield_Sound.setGain(10);
      airstrike_Sound = minim.loadFile("airstrike_sound.mp3");
      
      // Player Stats
      alive = true;
      maxHealth = 100;
      remainingHealth = maxHealth;
      original_Speed = 0.8;
      upgraded_Speed = 1;
      default_Speed = original_Speed;
      speedBoost_Speed = default_Speed * 4;
      
      // Cooldown Frame Timers
      fireRate = 15;
      fireRate_Elapsed = fireRate;
      speedBoost_CD_Length = 1800;
      speedBoost_CD_Elapsed = speedBoost_CD_Length;
      speedBoost_CD_Duration = 90;
      cannon_CD_Length = 540;
      cannon_CD_Elapsed = cannon_CD_Length;
      shield_CD_Length = 1800;
      shield_CD_Elapsed = shield_CD_Length;
      shield_Default_Duration = 300;
      shield_Upgraded_Duration = 420;
      airstrike_CD_Length = 2700;
      airstrike_CD_Elapsed = airstrike_CD_Length;
      
      // Unlockables Score Requirement
      speedBoost_Upgrade_Score = 100;
      cannon_Unlock_Score = 200;
      shield_Unlock_Score = 300;
      airstrike_Unlock_Score = 400;
      speed_Upgrade_Score = 500;
      cannon_Upgrade_Score = 700;
      shield_Upgrade_Score = 700;
      airstrike_Upgrade_Score = 800;
      
      // Movement Keys
      move = 'W';
      reverse = 'S';
      left = 'A';
      right = 'D';
      speedboost = ' ';
      shield = 'F';
      airstrike = 'R';
   }
   
   Player(float startX, float startY, char move, char reverse, char left, char right, char speedboost, char shield, char airstrike)
   {
      // Player Properties
      super(startX, startY);
      w = 50;
      halfW = w / 2;
      turret_Width = w * 0.15;
      turret_Length = halfW;
      turret_HalfWidth = turret_Width / 2;
      turret_HalfLength = turret_Length / 2;
      shield_Width = w * 1.75;
      colour = color(255,155,0);
      
      // Sounds
      upgrade_Sound = minim.loadFile("upgrade_sound.mp3");
      cannon_Sound = minim.loadFile("cannon_sound.mp3");
      attack_Sound = minim.loadFile("lmg_sound.wav");
      attack_Sound.setGain(-10);
      speed_Sound = minim.loadFile("speed_sound.mp3");
      shield_Sound = minim.loadFile("defshield_sound.mp3");
      airstrike_Sound = minim.loadFile("airstrike_sound.mp3");
      
      // Player Stats
      alive = true;
      maxHealth = 100;
      remainingHealth = maxHealth;
      default_Speed = 0.8;
      speedBoost_Speed = default_Speed * 4;
      
      // Cooldown Frame Timers
      fireRate = 15;
      fireRate_Elapsed = fireRate;
      speedBoost_CD_Length = 1800;
      speedBoost_CD_Elapsed = speedBoost_CD_Length;
      speedBoost_CD_Duration = 90;
      cannon_CD_Length = 540;
      cannon_CD_Elapsed = cannon_CD_Length;
      shield_CD_Length = 1800;
      shield_CD_Elapsed = shield_CD_Length;
      shield_Default_Duration = 300;
      shield_Upgraded_Duration = 420;
      airstrike_CD_Length = 2700;
      airstrike_CD_Elapsed = airstrike_CD_Length;
      
      // Unlockables Score Requirement
      speedBoost_Upgrade_Score = 100;
      cannon_Unlock_Score = 200;
      shield_Unlock_Score = 300;
      airstrike_Unlock_Score = 400;
      speed_Upgrade_Score = 500;
      cannon_Upgrade_Score = 600;
      shield_Upgrade_Score = 700;
      airstrike_Upgrade_Score = 800;
      
      // Movement Keys
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
      this.speedboost = speedboost;
      this.shield = shield;
      this.airstrike = airstrike;
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
   
   void shieldSound()
   {
      if (shield_Sound.position() != 0)
         shield_Sound.rewind();
         
      shield_Sound.play();
   }
   
   void airstrikeSound()
   {
      if (airstrike_Sound.position() != 0)
         airstrike_Sound.rewind();
         
      airstrike_Sound.play();
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
      
      // DEFENSE SHIELD ------------------------------------------------------------
      // Activate Defense Shield
      if (keys[shield] && shield_Unlocked && shield_CD_Elapsed >= shield_CD_Length)
      {
         shield_CD_ActivationTime = frameCount;
         shieldSound();
         shield_Active = true;
         shield_CD_Elapsed = 0;
      }
      if (frameCount > shield_CD_ActivationTime  + shield_CD_Duration && shield_Active)
         shield_Active = false;
         
      // Apply Upgraded Shield Time
      if (shield_Upgraded)
         shield_CD_Duration = shield_Upgraded_Duration;
      else
         shield_CD_Duration = shield_Default_Duration;
      // --------------------------------------------------------------------------
      
      // SPEED BOOST --------------------------------------------------------------
      // Activate Speedboost
      if (keys[speedboost]  &&  speedBoost_CD_Elapsed >= speedBoost_CD_Length)
      {
         speedBoost_CD_ActivationTime = frameCount;   // Store the activation time
         speedSound();                   // Play sound effect
         speedBoost_Active = true;      // Set Speed Boost to active
         speedBoost_CD_Elapsed = 0;      // Reset elapsed timer
      }
      // Apply Speedboost Effect
      if (frameCount < speedBoost_CD_ActivationTime + speedBoost_CD_Duration && speedBoost_Active)
         speed = speedBoost_Speed;
      else
      {
         speed = default_Speed;
         speedBoost_Active = false;
      }
      // Apply Passive Speed Upgrade
      if (speed_Upgraded)
         default_Speed = upgraded_Speed;
      else
         default_Speed = original_Speed;
      // --------------------------------------------------------------------------
      
      // Calculate the X,Y values necessary for the tank to move forward in the direction of theta
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.normalize();
      forward.mult(speed);         // Apply speed multiplier
      
      // Movement (Moving & Turning)
      if (keys[move])
         pos.add(forward);
      if (keys[reverse])
         pos.sub(forward.div(2));
      if (keys[left])
         theta -= 0.02f;
      if (keys[right])
         theta += 0.02f;

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
      if (cannon_Unlocked && mousePressed && mouseButton == RIGHT && cannon_CD_Elapsed >= cannon_CD_Length)
      {
         cannon_CD_Elapsed = 0;
         cannonSound();
         
         Bullet cannon_Ball = new CannonBall(2, cannon_Upgraded);
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
      if (shield_CD_Elapsed < shield_CD_Length)
         shield_CD_Elapsed++;
      if (airstrike_CD_Elapsed < airstrike_CD_Length)
         airstrike_CD_Elapsed++;
   }
   
   void render()
   {
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(theta);   // Rotate sketch to the direction the player is facing
       
       // Defense Shield
       if (shield_Active)
       {
          noFill();
          stroke(162,80,0);
          strokeWeight(5);
          ellipse(0, 0, shield_Width, shield_Width);
       }
       
       // Player
       fill(0);   // Player body colour
       stroke(colour);   // Player outline colour
       strokeWeight(3);   // Player outline thickness
       
       line(-8, -halfW, 0, -halfW - 7);   // Direction Indicator
       line(0, -halfW - 7, 8, -halfW);
       ellipse(0,0,w,w);   // Body
       popMatrix();
       
       // Turret
       pushMatrix();
       translate(pos.x, pos.y);
       rotate(turret_Theta);
       strokeWeight(1);
       fill(colour);
       
       if (cannon_Unlocked)   // Upgraded cannon
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


// Check if player has unlocked any upgraded - called in Player update()
void update_Upgrades()
{
   if (player.score >= player.cannon_Unlock_Score && player.cannon_Unlocked == false)   // Cannon Unlock
   {
      player.upgradeSound();
      player.cannon_Unlocked = true;
   }
   
   if (player.score >= player.cannon_Upgrade_Score && player.cannon_Upgraded == false)   // Cannon Upgrade
   {
      player.upgradeSound();
      player.cannon_Upgraded = true;
   }
   
   if (player.score >= player.shield_Unlock_Score && player.shield_Unlocked == false)   // Defense Shield Unlock
   {
      player.upgradeSound();
      player.shield_Unlocked = true;
   }
   
   if (player.score >= player.shield_Upgrade_Score && player.shield_Upgraded == false)   // Defense Shield Upgrade
   {
      player.upgradeSound();
      player.shield_Upgraded = true;
   }
   
   if (player.score >= player.airstrike_Unlock_Score && player.airstrike_Unlocked == false)   // Airstrike Unlock
   {
      player.upgradeSound();
      player.airstrike_Unlocked = true;
   }
   
   if (player.score >= player.airstrike_Upgrade_Score && player.airstrike_Upgraded == false)   // Airstrike Upgrade
   {
      player.upgradeSound();
      player.airstrike_Upgraded = true;
   }
   
   if (player.score >= player.speed_Upgrade_Score && player.speed_Upgraded == false)   // Passive Speed Upgrade
   {
      player.upgradeSound();
      player.speed_Upgraded = true;
   }
   
   if (player.score >= player.speedBoost_Upgrade_Score && player.speedBoost_Upgraded == false)   // Speed Boost Upgrade
   {
      player.upgradeSound();
      player.speedBoost_Upgraded = true;
   }
}