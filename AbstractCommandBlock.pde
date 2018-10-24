public abstract class AbstractCommandBlock implements CommandBlock{
  private int order;
  private long id;
  public AbstractCommandBlock(){
    
  }
   public AbstractCommandBlock(int order, long id){
    this.order = order;
    this.id = id;
  }
  public void turnOnLight(){
    System.out.println("光る");
  }
  public void turnOffLight(){
    System.out.println("光るをやめる");
  }
  public abstract void run();
  
  public int getOrder(){
    return this.order;
  }
  public long getId(){
    return this.id;
  }
}
