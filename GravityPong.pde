Paddle playerPaddle = new Paddle(100,450);
ArrayList<GameObject> objects = new ArrayList<GameObject>(30);
//PFont font = loadFont("cour.ttf");
int score = 0;
int numberBalls = 0;
PGraphics context;
boolean paused = false;
int gameTicks = 0;

void setup()
{
  size(400,500);
  context = createGraphics(width, height);
  frameRate(35);
  background(0);
  addObject(new Ball(random((float)width),-5,random(5)-2.5,random(2)));
  gameTicks = 0;
  stroke(255);
}

void newBall(float x,float y,float vx,float vy)
{
  Ball ball = new Ball(x,y,vx,vy);
  addObject(ball);
}

void spawnMessage(GameObject obj, String[] messages)
{
  int rand = int(random(messages.length));
  spawnMessage(obj, messages[rand]);
}

void spawnMessage(GameObject obj, String message)
{
  addObject(new Text(obj.pos.x, obj.pos.y, message));
}

void addObject(GameObject obj)
{
  objects.add(obj);
}

void draw()
{
  background(0);
  context.beginDraw();
  context.background(0);
  context.noStroke();
  playerPaddle.pos.x = mouseX - playerPaddle.width/2;
  updateArray(objects,context);
  playerPaddle.update();
  playerPaddle.draw(context);
  context.endDraw();
  image(context, 0, 0);
  fill(255);
  //textFont(font, 12);
  text(""+score,5,15);
  gameTicks += 1;
}

void mouseClicked()
{
  redraw();
}

void keyPressed()
{
  paused = !paused;
  if(paused)
    noLoop();
  else
    loop();
}

void updateArray(ArrayList<GameObject> a,PGraphics ctx)
{
  for(int i = 0;i < a.size(); i++)
  {
    GameObject obj = a.get(i);
    obj.update();
    if(obj.destroyNextFrame==true)
    {
      a.remove(i);
      obj.onDestroyed();
      i--;
    }
    obj.draw(ctx);
  }
}

void scorePaddleHit()
{
  score+=numberBalls;
}

