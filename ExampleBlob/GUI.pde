void keyPressed()
{
  if(keyCode == UP)
  {
    if(mouseX>width/2 && mouseY < height/2)
    {scaleThreshold++;}
    if(mouseX<width/2 && mouseY > height/2)
    {edgeThreshold++;}    
  }
  if(keyCode == DOWN)
  {
    if(mouseX>width/2 && mouseY < height/2)
    {scaleThreshold--;}
    if(mouseX<width/2 && mouseY > height/2)
    {edgeThreshold--;}    
  }
}
