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

boolean ready;

/* Terrain Data */
Terrain terrain;


void setup() {
  size(1200, 800, P3D);
  ready = false;
  
  terrainFile = "terrain1";

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

  cp5.addButton("generate")
    .setPosition(20, 80);

  cp5.addTextfield("terrainFile")
    .setPosition(20, 120)
    .setValue("terrain1")
    .setLabel("Load from File");

  cp5.addToggle("useStroke")
    .setPosition(220, 20)
    .setValue(true)
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
    
    terrain = new Terrain(rows, columns, gridSize, useStroke, useColor, useBlend, null);
    ready = true;
}

void draw() {
  background(0);
  perspective(radians(90f), width/(float)height, 0.1, 1000);
  oCamera.Update();
  terrain.Update();

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
  
  float newPhi = oCamera.phi + deltaX;
  if (newPhi < 0) {
    oCamera.phi = 0f;
  } else if (newPhi > 179) {
    oCamera.phi = 179f;
  } else {
    oCamera.phi = newPhi;
  }
  
  float newTheta = oCamera.theta + deltaY;
  if (newTheta < 0) {
    oCamera.theta = 0;
  } else if (newTheta > 179f) {
    oCamera.theta = 179;
  } else {
    oCamera.theta = newTheta;
  }
}

void generate() {
  terrainFile = cp5.get(Textfield.class, "terrainFile").getText();
  terrain = new Terrain(rows, columns, gridSize, useStroke, useColor, useBlend, terrainFile); //<>//
}
