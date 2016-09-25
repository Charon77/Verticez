PShape model;
VerticeMaster verticeMaster = new VerticeMaster();
float zoom = 1.0f;
ArrayList<Vertex> pathList = new ArrayList<Vertex>();

float tx, ty, tz;

Vertex nextVectorToVisit = null;

enum DrawMode
{
    SOLID,
    WIRE,
    EDGE,
    NONE
};

DrawMode drawMode = DrawMode.SOLID;
PFont myFont;
void setup()
{
  myFont = createFont("Georgia",42);
  textFont(myFont);
  size(600,600,P3D);
  loadModel(); 
  //Vertex vec = verticeMaster.findVertex(new PVector(0,0,0));
  //Vertex vec = verticeMaster.verticeList.get(0);
  //Vertex vec = verticeMaster.findVertex(verticeMaster.lowestPos);
  
  Vertex vec = verticeMaster.findLongestPath();
  
  nextVectorToVisit = vec;
  //println(pathList.size());
  
  // DEBUG
  //Run some times
  for (int i=0 ; i<417; i++)
    nextVectorToVisit = nextVectorToVisit.findPath(pathList);
}

void draw()
{
  background(0);
  text("CODRA: DNA Origami",30,60);
  
  translate(width/2,height/2);
  
  rotateX(3*PI/4);
  stroke(255);
  noFill();
  scale(30 * zoom);
  rotateX(tx);
  rotateY(ty);
  rotateZ(tz);
  drawModel();
  
  strokeWeight(0.02f);
  stroke(255,230);
  noFill();
  beginShape();
  for(Vertex v : pathList)
  {
    vertex(v.vertex.x,v.vertex.y,v.vertex.z);
  }
  endShape();
  
  stroke(255);
  
  
  //drawAxes();
  
  //delay(100);
}

void loadModel()
{
  // Load model
  model = loadShape("hBShape.obj");
  
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
      else
      {
        prevChildVector = roundVector(childShape.getVertex(childShape.getVertexCount()-1));
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

void mouseWheel(MouseEvent event) {
  float e = event.getCount() * 0.1f;
  println(e);
  zoom += e;
} 

void keyPressed()
{
  
  if(key>='0' && key<='9')
  {
    int keyNum = Integer.parseInt(str(key));
    switch(keyNum)
    {
      case 1:
        drawMode = DrawMode.SOLID;
      break;
      case 2:
        drawMode = DrawMode.WIRE;
      break;
      case 3:
        drawMode = DrawMode.EDGE;
      break;
      case 4:
        drawMode = DrawMode.NONE;
      break;
    }
    
    return;
  }
  
  
  if (nextVectorToVisit != null)
  {
    nextVectorToVisit.print();
    nextVectorToVisit = nextVectorToVisit.findPath(pathList);
  }
  else
  {
    println("Path is done, can't continue.");
  }
  
}

void drawModel()
{
  switch(drawMode)
  {
    case WIRE:
    {
      // Iterate each face
      for (int _childAcc=0; _childAcc<model.getChildCount();_childAcc++)
      {
        PShape childShape = model.getChild(_childAcc);
        
        // Iterate each vertices
        for (int _vertexAcc=0; _vertexAcc<childShape.getVertexCount(); _vertexAcc++)
        {
          PVector childVector = roundVector(childShape.getVertex(_vertexAcc));
          Vertex childVertex = verticeMaster.findVertex(childVector);
          PVector prevChildVector;
          
          if (_vertexAcc>0)
          {
            prevChildVector = roundVector(childShape.getVertex(_vertexAcc-1));
            
            
            // Next Edges
            Vertex[] verticesTo = new Vertex[]{
              childVertex.x_plus,
              childVertex.y_plus,
              childVertex.z_plus,
              childVertex.x_min,
              childVertex.y_min,
              childVertex.z_min,
            };
            
            for(Vertex vertexTo : verticesTo)
            {
              if(vertexTo != null)
              {
                strokeWeight(0.07f);
                stroke(180,70,0,20);  
                line(
                  childVector.x,
                  childVector.y,
                  childVector.z,
                  vertexTo.x(),
                  vertexTo.y(),
                  vertexTo.z()
                );
              }
            }
            
            // Dots
            stroke(childVertex.isVisited() ? color(0, 255,0) : color (255,0,0));            
            strokeWeight(0.1f * zoom);
            point(
              childVector.x,
              childVector.y,
              childVector.z
            );
            
            
          }
        }
      }
    }
    break;
    
    case EDGE:
    {
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
            
          }
          else
          {
            drawLineFromVec(childShape.getVertex(0),childShape.getVertex(childShape.getVertexCount()-1));
          }
        }
      }
    }
    break;
    
    case NONE:
    {
    }
    break;
    
    default:
    case SOLID:
    {
      shape(model);
    }
    break;
  }
}