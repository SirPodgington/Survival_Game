
void gameOver()
{
   int kills = player.kills;
   int score = player.score;
   int bullets_Landed = player.bullets_Landed;
   int bullets_Fired = player.bullets_Fired;
   float accuracy = (float) (bullets_Landed / bullets_Fired) * 100;
   String gameover_Msg = "GAME OVER";
   
   float header_X = width/2;
   float header_Y = height/4;
   textAlign(CENTER, CENTER);
   textSize(35);
   fill(theme_Colour);
   text(gameover_Msg, header_X, header_Y);
   
   float offset = width / 3;
   float gap = 50;
   float score_Y = 450;
   float kills_Y = score_Y + gap;
   float bullets_Y = kills_Y + gap;
   float accuracy_Y = bullets_Y + gap;
   
   // Labels
   float label_X = offset;
   textAlign(LEFT, CENTER);
   textSize(30);
   text("Score: ", label_X, score_Y);
   text("Kills: ", label_X, kills_Y);
   text("Bullets Landed: ", label_X, bullets_Y);
   text("Accuracy: ", label_X, accuracy_Y);
   
   // Stats
   float stats_X = width - offset;
   textAlign(RIGHT, CENTER);
   text(score, stats_X, score_Y);
   text(kills, stats_X, kills_Y);
   text(bullets_Landed + "/" + bullets_Fired, stats_X, bullets_Y);
   text(accuracy + "%", stats_X, accuracy_Y);
}