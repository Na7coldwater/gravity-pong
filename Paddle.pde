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
    if(destroyNextFrame)
      return;
    
    float offsetX = pos.x - halfWidth;
    float offsetY = pos.y;
    
    // Draw the paddle
    rectMode(CORNER);
    ctx.fill(255);
    ctx.noStroke();
    ctx.rect(offsetX,offsetY,width,height);
    
    // Draw the no-deflect zone
    float offset = width - noDeflectWidth();
    ctx.stroke(127);
    float drawX = offsetX+offset/2;
    ctx.line(drawX,offsetY,drawX,offsetY+height);
    drawX = offsetX-offset/2+width;
    ctx.line(drawX,offsetY,drawX,offsetY+height);
    
    //ctx.rect(pos.x+offset/2,pos.y,width-offset,height);
  }
  void update()
  {
    width = min(max(width,0),300);
    halfWidth = width / 2;
  }
  float calculateDeflect(PVector collision)
  {
    println("Calculating deflect");
    // Distance from the center of the paddle
    println(collision.x, pos.x, halfWidth);
    float offset = collision.x - pos.x;
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
    // TODO: Spawn a particle or something
  }
}
