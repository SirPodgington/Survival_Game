// The scoreboard. Displays the player's kills/score
void scoreboard()
{
   color scoreboard_Colour = theme_Colour;
   float x = width - 20;
   float y = 20;
   String kills = "Kills: " + player.kills;
   String score = "Score: " + player.score;
   fill(scoreboard_Colour);
   textAlign(RIGHT,TOP);
   textSize(14);
   text(kills + "  |  " + score, x, y);
}