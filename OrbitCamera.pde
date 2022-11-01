class OrbitCamera {

  PVector cameraPosition;
  Integer target;
  PVector lookAtTarget;

  float radius;
  float theta;
  float phi;

  ArrayList<PVector> targets;

  OrbitCamera() {
    cameraPosition = new PVector(0f, -190f, 200f);
    targets = new ArrayList<>();
    lookAtTarget = new PVector(0f, 0f, 0f);

    radius = 200;
    phi = 0f;
    theta = 120f;
    println("Phi: " + phi + " Theta: " + theta);
  }

  void Update() {
    //phi = map(mouseX, 0, width-1, 0, 360);
    //theta = map(mouseY, 0, height-1, 1, 179);
    
    //cameraPosition.x = lookAtTarget.x + findX();
    //cameraPosition.y = lookAtTarget.y + findY();
    //cameraPosition.z = lookAtTarget.z + findZ();


    camera(
      findX(), findY(), findZ(),
      lookAtTarget.x, lookAtTarget.y, lookAtTarget.z,
      0, 1, 0
      );
  }

  void AddLookAtTarget(PVector target) {
    targets.add(target);
  }

  void CycleTarget() {
    if (target == null && targets.size() == 0) {
      return;
    } else if (target == null && targets.size() > 0) {
      target = 0;
      lookAtTarget = targets.get(0);
      return;
    } else {
      target = (target + 1 == targets.size())
        ? 0
        : target + 1;
      lookAtTarget = targets.get(target);
    }
  }

  void Zoom(float f) {
    radius += 10*f;
    radius = (radius + 10*f <= 5) ? 5 : radius + 10*f;
  }

  float findX() {
    return radius * cos(radians(phi)) * sin(radians(theta));
  }

  float findY() {
    return radius * cos(radians(theta));
  }

  float findZ() {
    return radius * sin(radians(theta)) * sin(radians(phi));
  }
}
