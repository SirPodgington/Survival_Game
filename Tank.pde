class Tank extends GameObject
{
   
   char move, reverse, left, right, fire;
   
   Tank()
   {
      super(width*0.5f, height*0.8f, width*0.1f);
   }
   
   Tank(float startX, float startY, char move, char left, char right, char reverse, char fire, color colour)
   {
      super(startX, startY, width*0.1f);
      this.move = move;
      this.reverse = reverse;
      this.left = left;
      this.right = right;
      this.fire = fire;
      this.colour = colour;
   }
   
   
   void update()
   {
      
   }
   
   void render()
   {
       pushMatrix();
       translate(pos.x, pos.y);
       stroke(colour);
       fill(colour);
       rotate(theta);
       
       // Draw tank here
       
       popMatrix();
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}