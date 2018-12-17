Table data;
Ball[] balls;
PImage ant;
float speed = .1;
void setup()
{
  size(1000,1000);
  data = loadTable("data3.csv","header");
  ant = loadImage("ant.jpg");
  balls = new Ball[data.getRowCount()];
  for(int i=0;i<data.getRowCount();i++)
  {
    balls[i] = new Ball(
                        boolean(data.getString(i,"drug")),
                        map(i,0,data.getRowCount(),0,width-100)+200/3,
                        0.0,
                        float(data.getString(i,"d1")),
                        float(data.getString(i,"t1")),
                        float(data.getString(i,"d2")),
                        float(data.getString(i,"t2"))
                        );
  }
}

void draw()
{
  background(255,255,255,254);
  stroke(0);
  line(0,100,width,100);
  line(0,height-100,width,height-100);
  line(0,height-100-mapY(100.0),width,height-100-mapY(100.0));
  
  for(Ball ball : balls)
  {
    ball.advance();
    ball.display();
  }
}

public float mapY(float thisY)
{
  return map(thisY,0,175,height-100,100);
}