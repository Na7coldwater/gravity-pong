Paddle playerPaddle = new Paddle(100,350);
ArrayList<GameObject> objects = new ArrayList<GameObject>();
//PFont font = loadFont("cour.ttf");
int score = 0;
int numberBalls = 0;
PGraphics context;
boolean paused = false;
int gameTicks = 0;
boolean browser = false;
int difficulty = 0;
int difficultyTimer = 9000;

void setup()
{
  println("This window here is where debugging data goes");
  println("Feel free to ignore it, if you want");
  size(600,400);
  
  context = createGraphics(width, height);
  
  noLoop();
  if(!browser)
    realSetup(context);
}

// Called by javascript if we're running in a browser,
// directly if we're not
void realSetup(PGraphics ctx)
{
  context = ctx;
  frameRate(35);
  background(0);
  addObject(new Ball(random((float)width),-5,random(5)-2.5,random(2)));
  gameTicks = 0;
  stroke(255);
  loop();
}

void newBall(float x,float y,float vx,float vy)
{
  Ball ball = new Ball(x,y,vx,vy);
  addObject(ball);
}

void spawnRandomMessage(GameObject obj, String[] messages)
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
  if(!browser)
  {
    image(context, 0, 0);
  }
  fill(255);
  //textFont(font, 12);
  text(""+score,5,15);
  gameTicks += 1;
  adjustDifficulty();
  //spawnMessage(playerPaddle,"Test!");
}

void adjustDifficulty()
{
  difficultyTimer += 1;
  int nextTimer = 7000;
  if(difficultyTimer >= nextTimer)
  {
    difficultyTimer -= nextTimer;
    difficulty += 1;
    Text text = new Text(width / 2, height / 2, "Level up!");
    text.scale = 5;
    text.lifeTimerMax = 150;
    addObject(text);
  }
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

