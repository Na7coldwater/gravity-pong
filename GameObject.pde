abstract class GameObject
{
  PVector pos;
  boolean destroyNextFrame = false;
  public void destroy()
  {
    destroyNextFrame = true; 
  }
  
  public abstract void update();
  
  public abstract void draw(PGraphics ctx);
  
  public void hit()
  {
    return;
  }
  
  public void onDestroyed()
  {
    return;
  }
}
