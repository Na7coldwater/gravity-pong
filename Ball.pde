class Ball extends GameObject
{
  PVector vel;
  
  Ball(float x,float y,float vx,float vy)
  {
    this.pos = new PVector(x,y);
    this.vel = new PVector(vx,vy);
    numberBalls += 1;
  }
  
  Ball(PVector pos, PVector vel)
  {
    this.pos = pos.get();
    this.vel = vel.get();
    numberBalls += 1;
  }
  
  void update()
  {
    ArrayList<String> messages = new ArrayList<String>(5);
    
    // Simulate gravity
    vel.add(0, GRAVITY, 0);
    
    pos.add(vel);
    
    if(pos.y < playerPaddle.pos.y 
      && vel.y + pos.y >= playerPaddle.pos.y)
    {
      // Calculate the exact point at which the ball will reach
      // the paddle's height
      float paddleAdjustY = playerPaddle.pos.y - pos.y;
      float diff = paddleAdjustY / vel.y;
      PVector collisionPoint = 
        new PVector(
          lerp(pos.x, pos.x + vel.x, diff),
          playerPaddle.pos.y
        );
      
      if(collisionPoint.x > playerPaddle.pos.x-playerPaddle.halfWidth && 
         collisionPoint.x < playerPaddle.pos.x+playerPaddle.halfWidth)
      {
        scorePaddleHit();
        
        float deflectAmount = playerPaddle.calculateDeflect(pos);
        
        vel.rotate(-deflectAmount);
        vel.y = playerPaddle.bounce*abs(vel.y);
        // Clamp the bounce angle to a minimum
        // (prevent the ball from bouncing through the paddle)
        // TODO: This doesn't work
        if(vel.y > 0)
        {
          // The maximum amount that the ball's heading can
          // deviate from 90 degrees
          float minAngle = 75;
          
          PVector newVel = PVector.fromAngle(
              radians((vel.x<0?-1:1) * minAngle - 90)
            );
          newVel.setMag(vel.mag());
          vel = newVel;
        }
        
        // TODO: This is moving the ball twice in one frame
        // Figure out what to do instead
        pos.y = 2 * playerPaddle.pos.y - pos.y + vel.y;
        pos.x = pos.x + vel.x;
        
        playerPaddle.hit(this);
        
        if(random(1)<.1)
          messages.add("Boing!");
      }
    }
    
    if(pos.x>width)
    {
      vel.x = -abs(vel.x);
    }
    if(pos.x<0)
    {
      vel.x = abs(vel.x);
    }
    if(pos.y>height)
    {
      this.destroy();
      spawnMessage(this, "Oops!");
      return;
    }
    if(pos.y<-15 && vel.y<GRAVITY && vel.y>0)
    {
      messages.add("Height: "+int(height+abs(pos.y)));
    }
    if(abs(vel.y)<=GRAVITY && random(1)<.1)
    {
      messages.add("Whee!");
      messages.add("Whoa!");
      messages.add("Yippee!");
      messages.add("Higher!");
    }
    if(messages.size() > 0)
    {
      spawnRandomMessage(this, messages.toArray(new String[messages.size()]));
    }
  }
  void draw(PGraphics ctx)
  {
    ctx.noStroke();
    ctx.fill(255);
    ctx.ellipse(pos.x,pos.y,10,10);
    if(pos.y < -15)
    {
      ctx.stroke(255,0,255);
      ctx.line(pos.x-5, 0, pos.x - 5, 10);
      ctx.line(pos.x-5, 0, pos.x - 10, 5);
      ctx.line(pos.x-5, 0, pos.x, 5);
      ctx.noStroke();
      ctx.fill(127,127,127);
      float size = max(10 + (pos.y / 50),0);
      ctx.ellipse(pos.x-5, 20, size, size);
    }
    
    PVector last = pos;
    for(int i = 0; i < 150; i++)
    {
      float displacement = vel.y*(i) + (0.5*GRAVITY * (i) * (i)) + 0.5 * GRAVITY * i;
      PVector next = pos.get();
      next.add(vel.x*i,displacement,0);
      ctx.stroke(125,67,201);
      ctx.line(last.x,last.y,next.x,next.y);
      last = next;
    }
    
    {
      float time = quadratic(GRAVITY/2,vel.y+GRAVITY/2,pos.y - playerPaddle.pos.y);
      float displacement = vel.y*time + (GRAVITY * time * time)/2;
      PVector hit = new PVector(time*vel.x + pos.x,playerPaddle.pos.y);
      ctx.ellipse(hit.x,hit.y,5,5);
    }
  }
  void onDestroyed()
  {
    numberBalls -= 1;
    lives -= 1;
  }
}
