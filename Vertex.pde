class Vertex
{
  PVector vertex;
  
  Vertex x_plus = null;
  Vertex y_plus = null;
  Vertex z_plus = null;
  Vertex x_min = null;
  Vertex y_min = null;
  Vertex z_min = null;
  boolean visited = false;
  
  float x()
  {
    return vertex.x;
  }
  float y()
  {
    return vertex.y;
  }
  float z()
  {
    return vertex.z;
  }
  
  Vertex (PVector v)
  {
    vertex = roundVector(v);
  }
  
  void print()
  {
    println("");
    println("X",x());
    println("Y",y());
    println("Z",z());
  }
  void visit()
  {
    visited = true;
    //print();
  }
  
  void unVisit()
  {
    visited = false;
  }
  
  public boolean isVisited()
  {
    return visited;
  }
  
  Vertex findPath(ArrayList<Vertex> trail)
  {
        
    /*
    -Y
    -X
    -Z
    X
    Z
    Y
    */
    visit();
    trail.add(this);
    
    
    /* -Y */
    if(y_min != null && !y_min.visited)
    {
      return y_min;
    }
    
    /* -X */
    if(x_min != null && !x_min.visited)
    {
      return x_min;
    }
    
    /* -Z */
    if(z_min != null && !z_min.visited)
    {
      return z_min;
    }
    
    /* +X */
    if(x_plus != null && !x_plus.visited)
    {
      return x_plus;
    }
    
    /* +Z */
    if(z_plus != null && !z_plus.visited)
    {
      return z_plus;
    }
    
    /* +Y */
    if(y_plus != null && !y_plus.visited)
    {
      return y_plus;
    }
    
    
    return null;
   
  }
  
}