class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, halfW;
   float h, halfH;
   float speed = 4;
   float theta = 0.0f;
   color colour;
   color outline;
   PImage sprite;

   AudioPlayer sound;
   
   GameObject()
   {
      this(width*0.5f, height*0.5f);
   }
   
   GameObject(float startX, float startY)
   {
      pos = new PVector(startX, startY);
      forward = new PVector(0, -1);
   }
   
   
   void update()
   {
   }
   
   void render()
   {
   }
   
   
}