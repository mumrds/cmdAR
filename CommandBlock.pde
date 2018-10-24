public interface CommandBlock{
  public void turnOnLight();
  public void turnOffLight();
  public abstract void run();
  public int getOrder();
  public long getId();
}
