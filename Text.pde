class Text extends GameObject
{
  PVector vel;
  String message;
  float alpha;
  float lifeTimer;
  Text(float x,float y,String message)
  {
    this.pos = new PVector(x, y);
    if(pos.y>height)
      pos.y = height;
    this.vel = new PVector(0, -2);
    if(pos.y<0)
    {
      pos.y = 0;
      vel.y = 2;
    }
    this.alpha = 255;
    this.lifeTimer = 55;
    this.message = message;
  }
  void update()
  {
    pos.y += vel.y;
    vel.y*=.87;
    lifeTimer--;
    alpha = (min(lifeTimer,48)/48)*255;
    if(lifeTimer<=0)
    {
      this.destroy();
      return;
    }
  }
  void draw(PGraphics ctx)
  {
    ctx.fill(255,alpha);
    //ctx.textFont(font, 12);
    ctx.text(message, pos.x, pos.y);
  }
}
