
void bulletCollision()
{
   for (int i = game_Objects.size() - 1; i >= 0; i--)
   {
      GameObject object1 = game_Objects.get(i);
      
      if (object1 instanceof Bullet)
      {
         Bullet bullet = (Bullet) object1;
         
         if (bullet.enemy)   // Enemy Bullets ------
         {
            // Remove bullet when it touches the shield (if shield is active)
            if (player.shield_Active && bullet.position.dist(player.position) < bullet.half_Height + (player.shield_Width / 2))
               game_Objects.remove(bullet);
            
            // Otherwise remove bullet if touches player & apply damage
            else if (bullet.position.dist(player.position) < bullet.half_Height + player.half_Width)
            {
               player.remaining_Health -= bullet.damage;      // Apply Damage
               game_Objects.remove(bullet);   // Remove Bullet
            }
         }
         else   // Player Bullets -----
         {
            for (int j = game_Objects.size() - 1; j >= 0; j--)
            {
               GameObject object2 = game_Objects.get(j);
               
               // Friendly Bullet / AI
               if (object2 instanceof AI && !bullet.enemy)
               {
                  AI ai = (AI) object2;
                  
                  // Bullet / AI Collision
                  if (bullet.position.dist(ai.position) < bullet.half_Height + ai.half_Width)
                  {
                     if (bullet instanceof CannonBall)
                     {
                        // If upgraded cannonball set the AI on fire
                        CannonBall cannonBall = (CannonBall) bullet;
                        if (cannonBall.onFire)   // Apply burn effect to ai unit
                              ai.burning = true;
                     }
                     ai.remaining_Health -= bullet.damage;   // Apply bullet damage
                     game_Objects.remove(bullet);   // Remove Bullet
                     player.bullets_Landed++;   // 
                  }
               }
            }
         }
      }
   }
}