void threshCam()
{
  for (int x = 0; x < cam.width; x++)
  {
    for(int y = 0; y < cam.height; y++)
    {
      int pixel = x+ y * cam.width;
      
      float b = brightness(cam.pixels[pixel]);
      //println(r1);
      
      if (b > scaleThreshold)
      {
        camThresh.set(x,y,white);
      }else{
        camThresh.set(x,y,black);
      }
    }
  }  
  
  camThresh.updatePixels();
}

void smoothThreshCam()
{
  
}

void edgeCam()
{
  for (int x = 0; x < cam.width-1; x++)
  {
    for(int y = 0; y < cam.height; y++)
    {
      int pixel = x+ y * cam.width;
      
      float b1 = brightness(cam.pixels[pixel]);
      float b2 = brightness(cam.pixels[pixel+1]);
      
      float diff = b1-b2;
      
      if (diff > edgeThreshold)
      {
        camEdge.set(x,y,white);
      }else{
        camEdge.set(x,y,black);
      }
    }
  }
  camEdge.updatePixels();
}

void threshEdgeCam()
{
  color red = color(255,0,0);
  for (int x = 0; x < cam.width-1; x++)
  {
    for(int y = 0; y < cam.height; y++)
    {
      int pixel = x+ y * cam.width;
      
      if(brightness(camEdge.pixels[pixel])>0)
      {
        camThresh.pixels[pixel] = (red); 
      }
    }
  }
  camThresh.updatePixels();
}