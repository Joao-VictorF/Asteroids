class Laser {
  PVector position;
  PVector velocity;
  float angle;
  int laserSize = 20;

  Laser (PVector shipPosition, float _angle) {
    angle = _angle;
    position = new PVector(shipPosition.x, shipPosition.y);
    velocity = PVector.fromAngle(_angle);
    velocity.mult(5);
  }

  void render () {
    pushMatrix();
    stroke(57, 255, 20);
    strokeWeight(5);
    PVector angleDirection = PVector.fromAngle(angle).mult(.5);
    velocity.add(angleDirection);
    line(position.x, position.y, position.x + (laserSize * cos(angle)), position.y + (laserSize * sin(angle)));
    popMatrix();
  }

  void update () {
    position.add(velocity);
  }

  boolean verifyCollision (Asteroid asteroid) {
    float distance = dist(position.x, position.y, asteroid.position.x, asteroid.position.y);
    return distance < asteroid.size + 10;
  }
}

void destroyLaser(int laser, ArrayList<Laser> lasers) {
  lasers.remove(laser);
}
