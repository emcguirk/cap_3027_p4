class Terrain { //<>// //<>// //<>//
  int rows;
  int columns;
  float gridSize;
  boolean useStroke;
  boolean useColor;
  boolean useBlend;

  String terrainFile;

  ArrayList<PVector> points;
  ArrayList<Integer> triangles;

  Terrain(int rows, int columns, float gridSize, boolean useStroke, boolean useColor, boolean useBlend, String terrainFile) {
    this.rows = rows;
    this.columns = columns;
    this.gridSize = gridSize;
    this.useStroke = useStroke;
    this.useColor = useColor;
    this.useBlend = useBlend;
    this.terrainFile = terrainFile;

    /* Generate Triangle Indices */
    triangles = new ArrayList<Integer>();

    int verticesInARow = columns + 1;
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        int startingIndex = j * verticesInARow + i;
        // First triangle in quad
        triangles.add(startingIndex);
        triangles.add(startingIndex + 1);
        triangles.add(startingIndex + verticesInARow);

        // Second triangle in quad
        triangles.add(startingIndex + 1);
        triangles.add(startingIndex + verticesInARow + 1);
        triangles.add(startingIndex + verticesInARow);
      }
    }

    /* Create Points */
    points = new ArrayList<PVector>();
    for (int i = 0; i <= rows; i++) {
      float x = -gridSize/2 + gridSize/rows * i;
      float y = 0;
      for (int j = 0; j <= columns; j++) {
        float z = -gridSize/2 + gridSize/columns * j;
        points.add(new PVector(x, y, z));
      }
    }
  }

  void Update() {
    if (useStroke) {
      stroke(0);
    } else {
      noStroke();
    }
    
    beginShape(TRIANGLES);
    for (int i = 0; i < triangles.size(); i++) {
      int vertIdx = triangles.get(i);
      PVector vert = points.get(vertIdx);
      vertex(vert.x, vert.y, vert.z);
      //println("X: " + vert.x + " Y: " + vert.y + " Z: " + vert.z);
    }
    endShape(CLOSE);

    stroke(0);
  }
}
