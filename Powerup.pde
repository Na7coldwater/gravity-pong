class Powerup extends GameObject
{
  final static int SPLIT = 1;
  
  int type;
  float lifeTimer = 0;
  float lifeTimerMax;
  
  Powerup(int type)
  {
    this.type = type;
    this.pos = new PVector(random(0,width),random(0,height));
    this.lifeTimerMax = 100;
  }
  
  void draw(PGraphics ctx)
  {
    ctx.noStroke();
    ctx.fill(212,189,190);
    ctx.ellipse(pos.x,pos.y,5,5);
  }
  
  void update()
  {
    lifeTimer++;
    if(lifeTimer >= lifeTimerMax)
    {
      this.destroy();
    }
  }
}
