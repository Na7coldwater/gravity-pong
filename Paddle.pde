class Paddle extends GameObject
{
  float width;
  float halfWidth;
  float height;
  float bounce = -1;
  float maxDeflect = PI/4;
  float dying = 0;
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
    ctx.noStroke();
    ctx.rect(pos.x,pos.y,width,height);
    float offset = width - noDeflectWidth();
    ctx.fill(127,255,127);
    ctx.rect(pos.x+offset/2,pos.y,width-offset,height);
  }
  void update()
  {
    width-=.07 + (gameTicks * gameTicks) / 50000000.0;
    if(width <= 75 && width > 0)
    {
      width -= dying;
      height += dying;
      pos.y -= dying / 2;
      dying += 0.1;
    }
    width = min(max(width,0),300);
    halfWidth = width / 2;
  }
  float calculateDeflect(PVector collision)
  {
    println("Calculating deflect");
    // Distance from the center of the paddle
    println(collision.x, pos.x, halfWidth);
    float offset = collision.x - pos.x - halfWidth;
    float deflect;
    float sign = offset<0?-1:1;
    // Half the width of the no-deflect zone
    float noDeflect = noDeflectWidth() / 2;
    float x,y;

    // Are we in the no-deflect zone?
    if(abs(offset) < noDeflect)
    {
      println("noDeflect:",noDeflect);
      println("Did not deflect");
      return 0;
    }
    
    offset -= noDeflect*sign;

    // Scales from 0, at the edge of the no-deflect zone
    // to 1 (or -1), at the edge of the paddle
    deflect = (offset / (halfWidth - noDeflect));
    println("Relative hit:",deflect);
    //assert abs(deflect) <= 1;
    
    deflect *= maxDeflect;

    println("Offset:",offset, 
            "Width:",width, 
            "Degrees:",degrees(deflect));
    
    return deflect;
  }
  float noDeflectWidth()
  {
    return min(width / 4, 200);
  }
  void hit(GameObject other)
  {
    width+=3.5;
    //if(other instanceof Ball)
    //width-=0.5*abs(((Ball)other).vy);
  }
}
