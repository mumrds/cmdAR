import processing.video.*;
import jp.nyatla.nyar4psg.*;
 
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import java.lang.Object;


Capture cam;
MultiMarker nyId;

List<Integer> idList = new ArrayList<Integer>();
List<Pv> pvList = new ArrayList<Pv>();
List<CommandBlock> cmdList = new ArrayList<CommandBlock>();

float vecX, vecY;
float deg;
float foo[];

void setup() {
  //画面サイズ
  size(640,480,P3D);
  //カメラのキャプチャ
  colorMode(RGB, 100);
  //println(MultiMarker.VERSION);
  String[] cams = Capture.list();
  cam = new Capture(this, cams[0]);
  //cam = new Capture(this, width, height); 
  nyId = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG); 
  //検出したいNyIDマーカーを登録,idListに追加
  
  for(int i = 0; i < 50; i++){
    nyId.addNyIdMarker(i, 50);
    idList.add(i);
  }  
  //カメラの起動
  cam.start();
}
 

void draw(){
  //例外処理
  if (cam.available() == false) {
    return;
  }

  //カメラから映像を取得
  cam.read();
  
  //背景描画
  background(0);
  nyId.drawBackground(cam);
  
  //マーカーの検出
  nyId.detect(cam);
  
  //座標の取得
  //int j = 0;
  for(int i = 0; i < idList.size(); i++){
    if(!nyId.isExist(i)){
      System.out.print(i);
      System.out.println("例外です。");
      i--;
      return;
    }
    
    if(nyId.isExist(i)){
      //   pvList.add(j, new Pv(getCenterOfMarker(i), nyId.getNyId(j)));
      //   System.out.print(j);
      pvList.add(i, new Pv(getCenterOfMarker(i), nyId.getNyId(i)));
      System.out.print(i);
      System.out.println(getCenterOfMarker(i));
    }
  }
  
  System.out.println(pvList.size());

  for(int i = 1; i < pvList.size(); i++){
    foo[i] = pvList.get(i).getPVecY();
    System.out.println(pvList.get(i).getPVecY());
  }
  Arrays.sort(foo);
  
  //
  for(int i = 1; i < pvList.size(); i++){
    //順番に入れたリストのIDをidに代入したい
    long id = pvList.get(i).getId();
    if(id < 10){
      System.out.print("WalkBlock: ");
      cmdList.add(new WalkBlock(i, id));
    }else if(id < 20){
      System.out.print("TurnBlock: ");
      cmdList.add(new TurnBlock(i, id));
    }else if(id < 30){
      System.out.print("WaitBlock: ");
      cmdList.add(new WaitBlock(i, id));
    }else if(id < 40){
      System.out.print("ColorBlock: ");
      cmdList.add(new ColorBlock(i, id));
    }else{
      System.out.print("SoundBlock: ");
      cmdList.add(new SoundBlock(i, id));
    }
    System.out.println(pvList.get(i));
  }
}

//マーカーの中心を取得する
PVector getCenterOfMarker(int id) {
  PVector[] vec = nyId.getMarkerVertex2D(id);
  vecX = (vec[0].x + vec[2].x)/2;
  vecY = (vec[0].y + vec[2].y)/2;
  deg = atan2(vecX, vecY);
  return new PVector(vecX, vecY);
}
