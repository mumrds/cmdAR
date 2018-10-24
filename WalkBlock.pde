public class WalkBlock extends AbstractCommandBlock{
	private int order;
  private long id;
	public WalkBlock(int order, long id){
    this.order = order;
    this.id = id;
	}
	@Override
	public void run(){
		turnOnLight();
		turnOffLight();
	}
  public void turnOnLight(){
    System.out.println("光る");
  }
  public void turnOffLight(){
    System.out.println("光るをやめる");
  }  
  public int getOrder(){
    return this.order;
  }
  public long getId(){
    return this.id;
  }
}
