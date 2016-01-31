// This is the player's character

class Tank extends GameObject
{
   PImage turret_Sprite;
   float turret_Theta = 0.0f;
   float turret_Width, turret_Height, turret_half_Width, turret_half_Height;
   char move, reverse, left, right;
   int cannon_Cooldown;
   AudioPlayer cannon_Sound;
   
   
   Tank()
   {
      super(width*0.5f, height*0.8f);
      sprite = loadImage("tank_body_grey1.png");
      turret_Sprite = loadImage("tank_turret.png");
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
      
      speed = 0.8;
      colour = color(255,0,0);
      
      fire_Rate = 10;
      cannon_Cooldown = 300;
      cooldown1 = fire_Rate;
      cooldown2 = cannon_Cooldown;
   
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
      
      speed = 0.8;
      colour = color(255,0,0);
      
      fire_Rate = 10;
      cooldown1 = fire_Rate;
      cannon_Cooldown = 300;
      cooldown2 = cannon_Cooldown;
      
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
      if (mousePressed && mouseButton == LEFT && cooldown1 >= fire_Rate)
      {
         cooldown1 = 0;
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
      if (mousePressed && mouseButton == RIGHT && cooldown2 >= cannon_Cooldown)
      {
         cooldown2 = 0;
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
      if (pos.y < view_Top_Boundry + half_H)
            pos.y = view_Top_Boundry + half_H;
      if (pos.y > view_Bottom_Boundry - half_W)
            pos.y = view_Bottom_Boundry - half_W;
      
      // Increment the cooldowns each frame
      if (cooldown1 < fire_Rate)
         cooldown1++;
      if (cooldown2 < cannon_Cooldown)
         cooldown2++;
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