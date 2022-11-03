class Terrain { //<>// //<>// //<>// //<>//
  int rows;
  int columns;
  float gridSize;
  boolean useBlend;

  ArrayList<PVector> points;
  ArrayList<Integer> triangles;


  color snow = color(255, 255, 255);
  color grass = color(143, 170, 64);
  color rock = color(135, 135, 135);
  color dirt = color(160, 126, 84);
  color water = color(0, 75, 200);

  //Terrain(int rows, int columns, float gridSize, boolean useStroke, boolean useColor, boolean useBlend) {
  //  this.rows = rows;
  //  this.columns = columns;
  //  this.gridSize = gridSize;
  //  this.useStroke = useStroke;
  //  this.useColor = useColor;
  //  this.useBlend = useBlend;

  //  /* Generate Triangle Indices */
  //  triangles = new ArrayList<Integer>();

  //  int verticesInARow = columns + 1;
  //  for (int i = 0; i < columns; i++) {
  //    for (int j = 0; j < rows; j++) {
  //      int startingIndex = j * verticesInARow + i;
  //      // First triangle in quad
  //      triangles.add(startingIndex);
  //      triangles.add(startingIndex + 1);
  //      triangles.add(startingIndex + verticesInARow);

  //      // Second triangle in quad
  //      triangles.add(startingIndex + 1);
  //      triangles.add(startingIndex + verticesInARow + 1);
  //      triangles.add(startingIndex + verticesInARow);
  //    }
  //  }
  //  /* Create Points */
  //  points = new ArrayList<PVector>();
  //  for (int i = 0; i <= rows; i++) {
  //    float x = -gridSize/2 + gridSize/rows * i;
  //    for (int j = 0; j <= columns; j++) {
  //      float y = 0;
  //      float z = -gridSize/2 + gridSize/columns * j;
  //      points.add(new PVector(x, y, z));
  //    }
  //  }
  //}

  Terrain(int rows, int columns, float gridSize, boolean useBlend) {
    this.rows = rows;
    this.columns = columns;
    this.gridSize = gridSize;
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



  void Update(PImage heightmap, float heightMod, float snowThresh, boolean useColor, boolean useStroke) {
    if (useStroke) {
      stroke(0);
    } else {
      noStroke();
    }

    if (heightmap != null) {
      for (int i = 0; i <= rows; i++) {
        for (int j = 0; j <= columns; j++) {
          int x_index = (int)map(j, 0, columns + 1, 0, heightmap.width);
          int y_index = (int)map(i, 0, rows + 1, 0, heightmap.height);
          color c = heightmap.get(y_index, x_index);

          float colorHeight = map(red(c), 0, 255, 0, 1.0f);
          int idx = i * (columns + 1) + j;
          points.get(idx).y = colorHeight;
        }
      }
    }

    beginShape(TRIANGLES);
    for (int i = 0; i < triangles.size(); i++) {
      int vertIdx = triangles.get(i);
      PVector vert = points.get(vertIdx);
      if (useColor) {
        float relHeight = abs(vert.y * heightMod / -snowThresh);
        fill(getSnow(relHeight));
      }
      vertex(vert.x, vert.y * -heightMod, vert.z);
      //println("X: " + vert.x + " Y: " + vert.y + " Z: " + vert.z);
    }
    endShape(CLOSE);
    
    fill(255);
    stroke(0);
  }

  float getHeight(float x, float y, PImage heightmap) {
    int x_index = (int)map(x, 0, this.columns, 0, heightmap.width);
    int y_index = (int)map(y, 0, this.rows, 0, heightmap.height);
    color c = heightmap.get(x_index, y_index);
    float heightFromColor = map(red(c), 0, 255, 0, 1.0f);

    return heightFromColor;
  }

  String getFile() {
    return terrainFile;
  }

  color getSnow(float relHeight) {
    if (useBlend) {
      // Calculate blend here
    } else {
      if (relHeight <= 1.0 && relHeight >= 0.8) return snow;
      else if (relHeight >= 0.4) return rock;
      else if (relHeight >= 0.2) return grass;
      else return water;
    }
    return 0;
  }
}
