// OOP Assignment 2 draft ... testing tank game idean out

void setup()
{
   size (1000, 700);
   Tank player = new Tank();
   gameObjects.add(player);
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

void draw()
{
   background(0);
}