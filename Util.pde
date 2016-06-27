
PVector roundVector (PVector original)
{
  PVector res = original.copy();
  res.x = roundFloat(res.x);
  res.y = roundFloat(res.y);
  res.z = roundFloat(res.z);
  return res;
}

Float roundFloat (Float f)
{
  float scale = 10E4f;
  return (float) (round(f * scale) / scale);
}

void drawLineFromVec(PVector a, PVector b)
{
  //if(counter<0) return;
  stroke(255);
  strokeWeight(0.1);
  line(a.x,a.y,a.z,b.x,b.y,b.z);
}

void drawAxes()
{
 stroke(255,0,0,160);
 line(0,0,0,100,0,0);  
 stroke(0,255,0,160);
 line(0,0,0,0,100,0);
 stroke(0,0,255,160);
 line(0,0,0,0,0,100);
}