class Terrain {
  int rows;
  int columns;
  float gridSize;
  boolean useStroke;
  boolean useColor;
  boolean useBlend;

  String terrainFile;

  ArrayList<PVector> terrainVectors;
  ArrayList<Integer> triangleIndices;

  Terrain(int rows, int columns, float gridSize, boolean useStroke, boolean useColor, boolean useBlend, String terrainFile) {
    this.rows = rows;
    this.columns = columns;
    this.gridSize = gridSize;
    this.useStroke = useStroke;
    this.useColor = useColor;
    this.useBlend = useBlend;
    this.terrainFile = terrainFile;
  }
  
  void Update() {
    if (useStroke) {
      stroke(0);
    } else {
      noStroke();
    }
    pushMatrix();
    translate(-gridSize/2, 0, -gridSize/2);
    for (int i = 0; i < columns; i++) {
      pushMatrix();
        translate(gridSize/columns * i, 0, 0);
        box(1);
        pushMatrix();
          for (int j = 0; j < rows; j++) {
            pushMatrix();
              translate(0, 0, gridSize/rows * j);
              box(1);
            popMatrix();
          }
        popMatrix();
      popMatrix();
    }
  popMatrix();
  
  stroke(0);
  }
}
