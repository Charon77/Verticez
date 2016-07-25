PShape model;
VerticeMaster verticeMaster = new VerticeMaster();
int counter = 0;

ArrayList<Vertex> pathList = new ArrayList<Vertex>();

float tx, ty, tz;

void setup()
{
  size(400,400,P3D);
  loadModel(); 
  Vertex vec = verticeMaster.findVertex(new PVector(0,0,0));
  //Vertex vec = verticeMaster.verticeList.get(0);
  println(vec.vertex);
  
  vec.findPath(pathList);
  //println(pathList.size());
}

void draw()
{
  background(0);
  translate(width/2,height/2);
  rotateX(3*PI/4);
  stroke(255);
  noFill();
  scale(30);
  rotateX(tx);
  rotateY(ty);
  rotateZ(tz);
  shape(model);
  int i = 0;
  beginShape();
  for(Vertex v : pathList)
  {
    i++;
    if(i> counter) break;
    vertex(v.vertex.x,v.vertex.y,v.vertex.z);
  }
  endShape();
  
  drawAxes();
  
  delay(100);
  counter++;
}

void loadModel()
{
  // Load model
  model = loadShape("hShape.obj");
  
  // Iterate each face
  for (int _childAcc=0; _childAcc<model.getChildCount();_childAcc++)
  {
    PShape childShape = model.getChild(_childAcc);
    
    // Iterate each vertices
    for (int _vertexAcc=0; _vertexAcc<childShape.getVertexCount(); _vertexAcc++)
    {
      PVector childVector = roundVector(childShape.getVertex(_vertexAcc));
      PVector prevChildVector;
      
      if (_vertexAcc>0)
      {
        prevChildVector = roundVector(childShape.getVertex(_vertexAcc-1));
        
        drawLineFromVec(prevChildVector,childVector);
        verticeMaster.addVertex(prevChildVector,childVector);
      }
    }
  }
}

void mouseDragged()
{
  float x = 0.01f;
  ty-=x*(mouseX-pmouseX);
  tx-=x*(mouseY-pmouseY);
  
}