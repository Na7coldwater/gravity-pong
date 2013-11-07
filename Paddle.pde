class Paddle extends GameObject
{
  float width;
  float halfWidth;
  float height;
  float bounce = -1;
  float maxDeflect = PI/4;
  Paddle(float x,float y)
  {
    this.pos = new PVector(x, y);
    this.width = 200;
    this.halfWidth = this.width / 2;
    this.height = 12;
  }
  void draw(PGraphics ctx)
  {
    ctx.fill(255);
    ctx.rect(pos.x,pos.y,width,height);
  }
  void update()
  {
    width-=.07 + (gameTicks * gameTicks) / 50000000.0;
    width = min(max(width,0),600);
    halfWidth = width / 2;
  }
  float calculateDeflect(PVector collision)
  {
    float offset = collision.x - pos.x - halfWidth;
    float deflect = (offset / halfWidth) * maxDeflect;
    
    println("Calculating deflect");
    println((offset / halfWidth));
    println(offset, width, degrees(deflect));
    /*if(width <= 30)
    {
      return deflect;
    }*/
    
    /*if(offset < 5 - halfWidth)
    {
      return -maxDeflect;
    }
    if(offset > halfWidth - 5)
    {
      return maxDeflect;
    }*/
    //assert deflect <= maxDeflect;
    //assert deflect >= -maxDeflect;
    
    return deflect;
  }
  void hit(GameObject other)
  {
    width+=3.5;
    //if(other instanceof Ball)
    //width-=0.5*abs(((Ball)other).vy);
  }
}
