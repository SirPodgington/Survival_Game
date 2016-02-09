// Create player & add to game objects
void loadPlayer()
{
   Player player = new Player(width/2, view_Bottom_Boundry*0.9f, 'W', 'S', 'A', 'D', ' ', 'F');
   game_Objects.add(player);
}
   
// The Player class
class Player extends GameObject
{
   int kills, score, bullets_Fired, bullets_Landed;   // Variables to store statistical information on player's performance
   char move, reverse, left, right, speedboost, shield;   // Keys for movement & abilities
   boolean alive;   
   float default_Speed, original_Speed, upgraded_Speed, speedBoost_Speed;
   float turret_Theta;
   AudioPlayer speed_Sound, cannon_Sound, shield_Sound, upgrade_Sound;
   
   boolean shield_Active, speedBoost_Active;
   boolean cannon_Unlocked, shield_Unlocked;   
   boolean cannon_Upgraded, shield_Upgraded, speed_Upgraded, speedBoost_Upgraded;
   int speedboost_CD_Length, cannon_CD_Length, shield_CD_Length;
   int speedboost_CD_Elapsed, cannon_CD_Elapsed, shield_CD_Elapsed;
   int cannon_Unlock_Score, shield_Unlock_Score;
   int cannon_Upgrade_Score, shield_Upgrade_Score, speed_Upgrade_Score, speedBoost_Upgrade_Score;
   int shield_CD_Duration, shield_Default_Duration, shield_Upgraded_Duration, shield_CD_ActivationTime;
   int speedBoost_CD_Duration, speedBoost_CD_ActivationTime;
   float shield_Width;
   
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
      
      // Player Stats
      alive = true;
      maxHealth = 100;
      remainingHealth = maxHealth;
      original_Speed = 0.8;
      upgraded_Speed = 1;
      default_Speed = original_Speed;
      speedBoost_Speed = original_Speed * 4;
      
      // Cooldown Frame Timers
      fireRate = 15;
      fireRate_Elapsed = fireRate;
      speedboost_CD_Length = 1800;
      speedboost_CD_Elapsed = speedboost_CD_Length;
      speedBoost_CD_Duration = 90;
      cannon_CD_Length = 540;
      cannon_CD_Elapsed = cannon_CD_Length;
      shield_CD_Length = 1800;
      shield_CD_Elapsed = shield_CD_Length;
      shield_Default_Duration = 300;
      shield_Upgraded_Duration = 420;
      
      // Unlockables Score Requirement
      speedBoost_Upgrade_Score = 100;
      cannon_Unlock_Score = 200;
      shield_Unlock_Score = 300;
      speed_Upgrade_Score = 400;
      cannon_Upgrade_Score = 500;
      shield_Upgrade_Score = 600;
      
      // Movement Keys
      move = 'W';
      reverse = 'S';
      left = 'A';
      right = 'D';
      speedboost = ' ';
      shield = 'F';
   }
   
   Player(float startX, float startY, char move, char reverse, char left, char right, char speedboost, char shield)
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
      shield_Sound.setGain(10);
      
      // Player Stats
      alive = true;
      maxHealth = 100;
      remainingHealth = maxHealth;
      original_Speed = 0.8;
      upgraded_Speed = 1;
      default_Speed = original_Speed;
      speedBoost_Speed = original_Speed * 4;
      
      // Cooldown Frame Timers
      fireRate = 15;
      fireRate_Elapsed = fireRate;
      speedboost_CD_Length = 1800;
      speedboost_CD_Elapsed = speedboost_CD_Length;
      speedBoost_CD_Duration = 90;
      cannon_CD_Length = 540;
      cannon_CD_Elapsed = cannon_CD_Length;
      shield_CD_Length = 1800;
      shield_CD_Elapsed = shield_CD_Length;
      shield_Default_Duration = 300;
      shield_Upgraded_Duration = 420;
      
      // Unlockables Score Requirement
      speedBoost_Upgrade_Score = 100;
      cannon_Unlock_Score = 200;
      shield_Unlock_Score = 300;
      speed_Upgrade_Score = 400;
      cannon_Upgrade_Score = 500;
      shield_Upgrade_Score = 600;
      
      // Movement Keys
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
      this.speedboost = speedboost;
      this.shield = shield;
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
      applyUpgrades();
      shieldCD();
      speedboostCD();
      
      // Calculate the X,Y values necessary for the tank to move forward in the direction of theta
      forward.x = sin(theta);
      forward.y = - cos(theta);
      forward.normalize();
      forward.mult(speed);         // Apply speed multiplier
      
      // Movement (Moving & Turning)
      if (keys[move])
         position.add(forward);
      if (keys[reverse])
         position.sub(forward.div(2));
      if (keys[left])
         theta -= 0.02f;
      if (keys[right])
         theta += 0.02f;

      // Turret points towards mouse position if mouse is within boundry
      if (mouseY < view_Bottom_Boundry)
         turret_Theta = atan2(mouseY - position.y, mouseX - position.x) + HALF_PI;
         
      // Fire LMG bullets
      if (mousePressed && mouseButton == LEFT && fireRate_Elapsed >= fireRate)
      {
         fireRate_Elapsed = 0;
         lmgSound();
         
         Bullet lmg = new LMGBullet(2);
         lmg.position.x = position.x;
         lmg.position.y = position.y;
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
         cannon_Ball.position.x = position.x;
         cannon_Ball.position.y = position.y;
         cannon_Ball.colour = colour;
         cannon_Ball.theta = turret_Theta;
         game_Objects.add(cannon_Ball);
      }
         
      // Keep Player within screen boundary
      if (position.x < view_Left_Boundry + halfW)
            position.x = view_Left_Boundry + halfW;
      if (position.x > view_Right_Boundry - halfW)
            position.x = view_Right_Boundry - halfW;
      if (position.y < view_Top_Boundry + halfW)
            position.y = view_Top_Boundry + halfW;
      if (position.y > view_Bottom_Boundry - halfW)
            position.y = view_Bottom_Boundry - halfW;
      
      // Increment the cooldown timers each frame
      if (fireRate_Elapsed < fireRate)
         fireRate_Elapsed++;
      if (speedboost_CD_Elapsed < speedboost_CD_Length)
         speedboost_CD_Elapsed++;
      if (cannon_CD_Elapsed < cannon_CD_Length)
         cannon_CD_Elapsed++;
      if (shield_CD_Elapsed < shield_CD_Length)
         shield_CD_Elapsed++;
   }
   
   void render()
   {
       pushMatrix();
       translate(position.x, position.y);
       rotate(theta);
       
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
       translate(position.x, position.y);
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
       
       // Draw crosshair @ mouse position
       stroke(colour);
       strokeWeight(1);
       line(mouseX-10, mouseY, mouseX-4, mouseY);    // Left line
       line(mouseX+10, mouseY, mouseX+4, mouseY);    // Right line
       line(mouseX, mouseY-10, mouseX, mouseY-4);    // Top line
       line(mouseX, mouseY+10, mouseX, mouseY+4);    // Bottom line
   }
   
   
   // SPEED BOOST --------------------------------------------------------------
   void speedboostCD()
   {
      // Activate Speedboost
      if (keys[speedboost]  &&  speedboost_CD_Elapsed >= speedboost_CD_Length)
      {
         speedBoost_CD_ActivationTime = frameCount;   // Store the activation time
         speedSound();                   // Play sound effect
         speedBoost_Active = true;      // Set Speed Boost to active
         speedboost_CD_Elapsed = 0;      // Reset elapsed timer
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
   }
      
   // DEFENSE SHIELD -----------------------------------------------------------
   void shieldCD()
   {
      // Activate Defense Shield
      if (keys[shield] && shield_Unlocked && shield_CD_Elapsed >= shield_CD_Length)
      {
         shield_CD_ActivationTime = frameCount;
         shieldSound();
         shield_Active = true;
         shield_CD_Elapsed = 0;
      }
      
      // Remove shield when time runs out
      if (frameCount > shield_CD_ActivationTime  + shield_CD_Duration && shield_Active)
         shield_Active = false;
         
      // Apply Upgraded Shield Time
      if (shield_Upgraded)
         shield_CD_Duration = shield_Upgraded_Duration;
      else
         shield_CD_Duration = shield_Default_Duration;
   }
   
   // Activate Newly Unlocked Upgrades
   void applyUpgrades()
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
}