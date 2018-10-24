
public class Pv{
  private PVector pv;
  private Long id;
  private float pvY;
  public Pv(PVector pv, Long id){
    this.pv = pv;
    this.id = id;
    this.pvY = this.pv.y;
  }
  public PVector getPVec(){
	  return this.pv;
  }
  public Long getId(){
	  return this.id;
  }
  public float getPVecY(){
	  return this.pvY;
  }
}
