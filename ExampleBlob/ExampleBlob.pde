import processing.video.*;
Capture cam;
PImage camThresh,camThreshSmooth,camEdge,camThreshEdge;
double scaleThreshold = 150;
double edgeThreshold = 20;
boolean search = false;

  color white = color(255,255,255);
  color black = color(0);

void setup()
{
  size(1280,960);
  frameRate(60);
  
  String[] cameras = Capture.list();
  
  if(search)
  {
    if (cameras.length == 0) 
    {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
      cam = new Capture(this, cameras[0]);
      cam.start();
      camThresh = new PImage(cam.width,cam.height);
      camThreshSmooth = new PImage(cam.width,cam.height);
      camEdge = new PImage(cam.width,cam.height);
    }
  }else{
    cam = new Capture(this, 640,480,30);
    cam.start();
    camThresh = new PImage(cam.width,cam.height);
    camThreshSmooth = new PImage(cam.width,cam.height);
    camEdge = new PImage(cam.width,cam.height);
  }
}

void draw()
{
  if(cam.available()==true && false)
  {
    cam.read();
    cam.loadPixels();
  }
  
  threshCam();
  smoothThreshCam();
  edgeCam();
  
  image(cam,0,0,width/2,height/2);
  image(camEdge,0,height/2,width/2,height/2);
  image(camThresh,width/2,0,width/2,height/2);
  
  threshEdgeCam();
  
  image(camThresh,width/2,height/2,width/2,height/2);
}

void captureEvent(Capture cam)
{
   cam.read();
}