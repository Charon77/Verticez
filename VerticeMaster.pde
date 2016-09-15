class VerticeMaster
{
  ArrayList<Vertex> verticeList = new ArrayList<Vertex>();
  float lowestX = MAX_FLOAT;
  float lowestY = -MAX_FLOAT;
  float lowestZ = MAX_FLOAT;
  PVector lowestPos = null;
  // Challenge lowest X, Y, Z
  void contestLowest(PVector vec)
  {
    /*
    println("X: " + lowestX + " " + vec.x);
    println("Y: " + lowestY + " " + vec.y);
    println("Z: " + lowestZ + " " + vec.z);
    println("---");
    */
    if(vec.x<=lowestX && vec.y>=lowestY && vec.z<=lowestZ)
    {     
      lowestX = vec.x;
      lowestY = vec.y;
      lowestZ = vec.z;
      lowestPos = vec;
    }
  }
  
  void addVertex (PVector v,PVector w )
  {
    contestLowest(v);
    contestLowest(w);
    // Adds edge to list
    Vertex v_src = new Vertex(v);
    Vertex v_dst = new Vertex(w);
    // Only adds if edge doesn't exist
    if(!vertexExists(v_src))
    {
      verticeList.add(v_src);
      //println("Added " + v_src.vertex);
    }
    
    if(!vertexExists(v_dst))
    {
      verticeList.add(v_dst);
      //println("Added " + v_dst.vertex);
    }
    
    Vertex v_vertex = findVertex(v);
    Vertex w_vertex = findVertex(w);
    
    // X
    if( v_src.x() < w.x)
    {
      v_vertex.x_plus = w_vertex;
      w_vertex.x_min= v_vertex;
    }
    else if( v_src.x() > w.x)
    {
      v_vertex.x_min = w_vertex;
      w_vertex.x_plus= v_vertex;
    }
  
    // Y
    else if( v_src.y() < w.y)
    {
      v_vertex.y_plus = w_vertex;
      w_vertex.y_min= v_vertex;
    }
    else if( v_src.y() > w.y)
    {
      v_vertex.y_min = w_vertex;
      w_vertex.y_plus= v_vertex;
    }
  
    // Z
    else if( v_src.z() < w.z)
    {
      v_vertex.z_plus = w_vertex;
      w_vertex.z_min= v_vertex;
    }
    else if( v_src.z() > w.z)
    {
      v_vertex.z_min = w_vertex;
      w_vertex.z_plus= v_vertex;
    }
    else 
    {
      throw(new Error("OH no"));
    }
  }
  
  boolean vertexExists (Vertex target)
  {
    for (Vertex v : verticeList)
    {
      if(
          v.x() == target.x() &&
          v.y() == target.y() &&
          v.z() == target.z()
        )
        {
          return true;
        }
    }
    // Edge doesn't exist
    return false;
  }
  Vertex findVertex (PVector target)
  {
    for (Vertex v : verticeList)
    {
      if(
          v.x() == target.x &&
          v.y() == target.y &&
          v.z() == target.z
        )
        {
          return v;
        }
    }
    // Edge doesn't exist
    println(target);
    throw new Error("Not found");
  }
  
  // Clears all visited flag from vertices
  void clearVisited()
  {
    for( Vertex v : verticeList)
    {
      v.unVisit();
    }
  }
  
  Vertex findLongestPath()
  {
    
    int longestPathLength = 0;
    Vertex bestStartingPoint = null;
    
    for(Vertex startingVertexIteration : verticeList)
    {
      Vertex currentVertex = startingVertexIteration;
      Vertex nextVertex;
      ArrayList<Vertex> breadcrumbs = new ArrayList<Vertex>();
      while ((nextVertex = currentVertex.findPath(breadcrumbs)) != null)
      {
        currentVertex=nextVertex;
      }
      println(breadcrumbs.size());
      
      if (breadcrumbs.size() > longestPathLength)
      {
        longestPathLength = breadcrumbs.size();
        bestStartingPoint = startingVertexIteration;
      }
      
      clearVisited();
    }
    println("Best so far: ", longestPathLength);
    return bestStartingPoint;
  }
}