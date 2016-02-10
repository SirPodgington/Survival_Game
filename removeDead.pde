// Remove Dead & Add Score / Increment Kill Counter -------------------------------------------------------
void removeDead()
{
   for(int i = game_Objects.size() - 1; i >= 0; i --)
   {
      GameObject object = game_Objects.get(i);
      
      if ((object instanceof AI || object instanceof Player) && object.remaining_Health <= 0)
      {
         if (object instanceof AI)
         {
            AI ai = (AI) object;
            player.score += ai.score_Value;   // Add score to player
            player.kills++;   // Increment player kills
            game_Objects.remove(ai);   // Remove unit from game
         }
         else
         {
            player.alive = false;
         }
      }
   }
}