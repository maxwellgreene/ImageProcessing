class Ball
{
  boolean drug;
  float x;
  float y;
  float d1;
  float d2;
  float t1;
  float t2;
  int section;
  
  Ball(boolean drugtemp, float tempx,float tempy, float tempd1, float tempt1, float tempd2, float tempt2)
  {
    drug = drugtemp;
    x = tempx;
    y = tempy;
    d1 = tempd1;
    t1 = tempt1;
    d2 = tempd2;
    t2 = tempt2;
    section = 0;
  }
  
  void advance()
  {
    if(this.y<=this.d1 && this.section==0)
    {
      this.y = this.y+speed*(this.d1/this.t1);
    }else if(this.section==0){this.section=1;}
    
    if(this.section == 1)
    {
      if(!this.drug){fill(0);}else{fill(255,0,0);}
      ellipse(this.x,mapY(this.d1),10,10);
      stroke(255,0,0);
      line(this.x,mapY(this.d1),this.x,mapY(this.y));
      if(this.y>(this.d2)+(this.d1-this.d2)/(this.t2-this.t1))
      {this.y = this.y-speed*(this.d1-this.d2)/(this.t2-this.t1);}
      
    }    
  }
  
  
  void display()
  {
    stroke(0);
    if(!this.drug){fill(0);}else{fill(255,0,0);}
    //image(ant,this.x,map(this.y,0,175,height-100,100),30,-40);
    ellipse(this.x,mapY(this.y),10,10);
    stroke(0,0,255);
    line(this.x,height-100,this.x,mapY(this.y));
    
    line(this.x-5,mapY((this.d1+this.d2)/2),this.x+5,mapY((this.d1+this.d2)/2));
    text((this.d1+this.d2)/2+"cm",this.x+5,mapY((this.d1+this.d2)/2));
  }
}