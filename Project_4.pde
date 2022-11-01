import controlP5.*;

OrbitCamera oCamera;

void setup() {
  size(1200, 800, P3D);

  oCamera = new OrbitCamera();
}

void draw() {
  background(50);
  perspective(radians(90f), width/(float)height, 0.1, 1000);
  oCamera.Update();


  // Draw rest of grid
  stroke(255);
  for (int i = -100; i <= 100; i += 10) {
    // X values
    line(i, 0, -100, i, 0, 100);

    // Z values
    line(-100, 0, i, 100, 0, i);
  }
  // Draw Origin
  stroke(255, 0, 0);
  line(-100, 0, 0, 100, 0, 0);

  stroke(0, 0, 255);
  line(0, 0, -100, 0, 0, 100);


  box(1.5);


  perspective();
  camera();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  oCamera.Zoom(e);
}

void mouseDragged() {
  float deltaX = (mouseX - pmouseX) * 0.15f;
  float deltaY = (mouseY - pmouseY) * 0.15f;

  oCamera.phi = oCamera.phi + deltaX >= 179f ? 179f : oCamera.phi + deltaX;
  oCamera.theta = oCamera.theta + deltaY >= 179f ? 179f : oCamera.theta + deltaY;
}
