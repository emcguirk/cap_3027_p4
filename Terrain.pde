class Terrain { //<>// //<>// //<>// //<>//
  int rows;
  int columns;
  float gridSize;
  boolean useStroke;
  boolean useColor;
  boolean useBlend;

  PImage heightmap;

  ArrayList<PVector> points;
  ArrayList<Integer> triangles;

  Terrain(int rows, int columns, float gridSize, boolean useStroke, boolean useColor, boolean useBlend) {
    this.rows = rows;
    this.columns = columns;
    this.gridSize = gridSize;
    this.useStroke = useStroke;
    this.useColor = useColor;
    this.useBlend = useBlend;

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
      for (int j = 0; j <= columns; j++) {
        float y = 0;
        float z = -gridSize/2 + gridSize/columns * j;
        points.add(new PVector(x, y, z));
      }
    }
  }

  Terrain(int rows, int columns, float gridSize, boolean useStroke, boolean useColor, boolean useBlend, String terrainFile) {
    this.rows = rows;
    this.columns = columns;
    this.gridSize = gridSize;
    this.useStroke = useStroke;
    this.useColor = useColor;
    this.useBlend = useBlend;
    heightmap = terrainFile == null ? null : loadImage(terrainFile + ".png");

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
      for (int j = 0; j <= columns; j++) {
        float y = heightmap == null ? 0 : getHeight(i, j);
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

  float getHeight(float x, float y) {
    int x_index = (int)map(x, 0, columns+1, 0, heightmap.width);
    int y_index = (int)map(y, 0, rows+1, 0, heightmap.height);
    color c = heightmap.get(x_index, y_index);
    float heightFromColor = map(red(c), 0, 255, 0, 1.0f);

    return heightFromColor;
  }
  
  String getFile() {
    return terrainFile;
  }
}
