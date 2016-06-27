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
    println(vertex);
    println(x_plus != null);
    println(y_plus != null);
    println(z_plus != null);
    println(x_min  != null);
    println(y_min  != null);
    println(z_min  != null);
  }
  void visit()
  {
    visited = true;
    //print();
  }
  
  void findPath(ArrayList<Vertex> trail)
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
    
    
    
    
    /* -X */
    if(x_min != null && !x_min.visited)
    {
      x_min.findPath(trail);
      return;
    }
    
    /* -Z */
    if(z_min != null && !z_min.visited)
    {
      z_min.findPath(trail);
      return;
    }
    
    /* +X */
    if(x_plus != null && !x_plus.visited)
    {
      x_plus.findPath(trail);
      return;
    }
    
    /* +Z */
    if(z_plus != null && !z_plus.visited)
    {
      z_plus.findPath(trail);
      return;
    }
    
    /* +Y */
    if(y_plus != null && !y_plus.visited)
    {
      y_plus.findPath(trail);
      return;
    }
    /* -Y */
    if(y_min != null && !y_min.visited)
    {
      y_min.findPath(trail);
      return;
    }
   
  }
  
}