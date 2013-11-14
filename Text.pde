class Text extends GameObject
{
  PVector vel;
  String message;
  float alpha;
  float lifeTimer;
  float lifeTimerMax;
  float scale = 1.0;

  Text(float x, float y, String message)
  {
    this.pos = new PVector(x, y);
    if (pos.y>height)
      pos.y = height;
    this.vel = new PVector(0, -2);
    if (pos.y<0)
    {
      pos.y = 0;
      vel.y = 2;
    }
    this.alpha = 255;
    this.lifeTimer = 0;
    this.lifeTimerMax = 55;
    this.message = message;
  }
  void update()
  {
    pos.y += vel.y * accelLerp(1,0,lifeTimer / lifeTimerMax);
    vel.y *= .87;
    lifeTimer++;
    float t = clampStepLast(lifeTimer,lifeTimerMax,45);
    if(t > 0)
      alpha = lerp(255,0,t);
    
    if (lifeTimer>=lifeTimerMax)
    {
      this.destroy();
      return;
    }
  }
  void draw(PGraphics ctx)
  {
    ctx.pushMatrix();
    //ctx.textFont(font, 12);
    float x = pos.x;
    float y = pos.y;
    ctx.translate(x, y);
    ctx.textAlign(CENTER, CENTER);
    ctx.scale(this.scale);
    
    ctx.fill(255, alpha);
    ctx.text(message, 0, 0);
    ctx.popMatrix();
  }
}

