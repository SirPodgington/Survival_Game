
class GameObject
{
   PVector pos;
   PVector forward;
   float theta;
   float w, halfW;
   float speed;
   
   GameObject()
   {
      this(width*0.5f, height*0.5f, width*0.1f, 2);
   }
   
   GameObject(float x, float y, float w, int s)
   {
      pos = new PVector(x, y);
      forward = new PVector(0, -1);
      this.w = w;
      halfW = w * 0.5f;
      speed = s;
   }
   
   
   void update()
   {
   }
   
   void render()
   {
   }
   
   
}