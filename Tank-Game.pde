// OOP Assignment 2 draft ... testing tank game idean out

void setup()
{
   size (1000, 700);
   Tank player = new Tank(width/2, height*0.9f, 'W', 'S', 'A', 'D', ' ', color(255,0,0));
   gameObjects.add(player);
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}



void draw()
{
   background(0);
   
  for(int i = gameObjects.size() - 1;  i >= 0;  i --)
  {
     GameObject object = gameObjects.get(i);
     object.update();
     object.render();
  }
}