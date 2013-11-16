/* @pjs globalKeyEvents=true; 
 */

Paddle playerPaddle = new Paddle(100,350);
ArrayList<GameObject> objects = new ArrayList<GameObject>();
//PFont font = loadFont("cour.ttf");
int score = 0;
int numberBalls = 0;
boolean paused = false;
int gameTicks = 0;
int difficulty = 0;
int difficultyTimer = 0;
int nextDifficultyTimer = 1500;
int lives = 3;

boolean gameOver = false;

PGraphics context;

boolean browser = false;

void setup()
{
  //println("This window here is where debugging data goes");
  //println("Feel free to ignore it, if you want");
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
  addBall();
  gameTicks = 0;
  stroke(255);
  loop();
}

void newBall(float x,float y,float vx,float vy)
{
  Ball ball = new Ball(x,y,vx,vy);
  addObject(ball);
}

void addBall()
{
  newBall(random(1)*(float)width,-5,random(5)-2.5,random(2));
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
  context.background(0,0);
  context.noStroke();
  playerPaddle.pos.x = mouseX - playerPaddle.width/2;
  updateArray(objects,context);
  playerPaddle.update();
  playerPaddle.draw(context);
  if(!gameOver)
  {
    gameTicks += 1;
    adjustDifficulty();
    if(lives <= 0)
    {
      gameOver = true;
    }
    if(numberBalls <= 0 && lives > 0)
    {
      addBall();
    }
  }
  
  context.endDraw();
  if(!browser)
  {
    image(context, 0, 0);
  }
  
  fill(255);
  //textFont(font, 12);
  context.beginDraw();
  context.background(0,0);
  
  drawDifficulty(context);
  drawLives(context);
  drawScore(context);
  
  context.endDraw();
  
  noTint();
  image(context,0,0);
}

void drawDifficulty(PGraphics ctx)
{
  ctx.textAlign(LEFT, CENTER);
  ctx.text("New ball in: " + (nextDifficultyTimer-difficultyTimer),5,42);
}

void drawScore(PGraphics ctx)
{
  ctx.textAlign(LEFT);
  ctx.text(""+score,5,15);
}

void drawLives(PGraphics ctx)
{
  ctx.pushMatrix();
  String livesText = "Lives: ";
  ctx.translate(5,26);
  ctx.textAlign(LEFT, CENTER);
  ctx.text(livesText,0,0);
  ctx.translate(ctx.textWidth(livesText)+3,2);
  ctx.fill(255);
  ctx.noStroke();
  for(int i=0;i<lives;i++)
  {
    ctx.ellipse(0,0,8,8);
    ctx.translate(15,0);
  }
  ctx.popMatrix();
}

void newGame()
{
  // TODO: New game logic
}

void adjustDifficulty()
{
  difficultyTimer += 1;
  int nextTimer = nextDifficultyTimer;
  if(difficultyTimer >= nextTimer)
  {
    difficultyTimer -= nextTimer;
    difficulty += 1;
    Text text = new Text(width / 2, height / 2, "Level up!");
    text.scale = 5;
    text.lifeTimerMax = 150;
    addObject(text);
    addBall();
  }
}

void mouseClicked()
{
  if(paused)
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

