import controlP5.*;

OrbitCamera oCamera;
ControlP5 cp5;

/* Grid Data */
int rows;
int columns;
float gridSize;

/* ControlP5 Data */
boolean useStroke;
boolean useColor;
boolean useBlend;

float heightMod;
float snowThresh;

String terrainFile;

/* Terrain Data */

ArrayList<PVector> terrainVectors;
ArrayList<Integer> triangleIndices;


void setup() {
  size(1200, 800, P3D);

  cp5 = new ControlP5(this);
  oCamera = new OrbitCamera();

  cp5.addSlider("rows")
    .setPosition(20, 20)
    .setRange(1, 100)
    .setValue(10);

  cp5.addSlider("columns")
    .setPosition(20, 40)
    .setRange(1, 100)
    .setValue(10);

  cp5.addSlider("gridSize")
    .setPosition(20, 60)
    .setRange(20, 50)
    .setValue(30f)
    .setLabel("Terrain Size");

  cp5.addButton("Generate")
    .setPosition(20, 80);

  cp5.addTextfield("terrainFile")
    .setPosition(20, 120)
    .setValue("terrain1")
    .setLabel("Load from File");

  cp5.addToggle("useStroke")
    .setPosition(220, 20)
    .setValue(false)
    .setLabel("stroke");

  cp5.addToggle("useColor")
    .setPosition(280, 20)
    .setValue(false)
    .setLabel("color");

  cp5.addToggle("useBlend")
    .setPosition(340, 20)
    .setValue(false)
    .setLabel("blend");

  cp5.addSlider("heightMod")
    .setPosition(220, 60)
    .setRange(-5.0, 5.0)
    .setValue(1.00)
    .setLabel("Height Modifier");

  cp5.addSlider("snowThresh")
    .setPosition(220, 80)
    .setRange(1, 5)
    .setValue(5)
    .setLabel("Snow Threshold");
}

void draw() {
  background(0);
  perspective(radians(90f), width/(float)height, 0.1, 1000);
  oCamera.Update();


  ///* Old Grid Method */
  //// Draw rest of grid
  //stroke(255);
  //for (int i = -100; i <= 100; i += 10) {
  //  // X values
  //  line(i, 0, -100, i, 0, 100);

  //  // Z values
  //  line(-100, 0, i, 100, 0, i);
  //}
  //// Draw Origin
  //stroke(255, 0, 0);
  //line(-100, 0, 0, 100, 0, 0);

  //stroke(0, 0, 255);
  //line(0, 0, -100, 0, 0, 100);

  /* New Grid Method */
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
  


  perspective();
  camera();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  oCamera.Zoom(e);
}

void mouseDragged() {
  if (cp5.isMouseOver()) return;
  float deltaX = (mouseX - pmouseX) * 0.15f;
  float deltaY = (mouseY - pmouseY) * 0.15f;

  oCamera.phi = oCamera.phi + deltaX >= 179f ? 179f : oCamera.phi + deltaX;
  oCamera.theta = oCamera.theta + deltaY >= 179f ? 179f : oCamera.theta + deltaY;
}
