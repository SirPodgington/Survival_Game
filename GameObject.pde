class GameObject
{
   
   PVector pos;
   PVector forward;
   float w, halfW;
   float speed = 2;
   float theta = 0.0f;
   color colour;
   
   GameObject()
   {
      this(width*0.5f, height*0.5f, width*0.1f);
   }
   
   GameObject(float startX, float startY, float w)
   {
      pos = new PVector(startX, startY);
      forward = new PVector(0, -1);
      this.w = w;
      halfW = w * 0.5f;
   }
   
   
   void update()
   {
   }
   
   void render()
   {
   }
   
   
}