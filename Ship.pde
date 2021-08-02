class Ship {
  PVector position;
  PVector velocity;
  float heading;
  float rotation;
  float fuel   = 100;
  int munition = MAX_MUNITIONS;
  int size;
  boolean isAccelerating;
  boolean isShooting;
  boolean flashing = true;
  ArrayList<Laser> lasers = new ArrayList<Laser>();

  Ship () {
    position = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    size = 25;
    heading = 0;
    rotation = 0;
    isAccelerating = false;

    flashingDelay = 1.5;
  }

  void render () {
    renderLasers();
    pushMatrix();
    translate(position.x, position.y);
    rotate(heading + PI/2);
    fill(0);
    stroke(shipColor);
    strokeWeight(3);
    triangle(-size, size, size, size, 0, -size);
    popMatrix();
    _rotate();
    update();
  }

  void update () {
    munitionRechargeTime += 1.0/60.0;
    flashingDelay -= 1.0/60;

    if (isAccelerating && fuel > 0) {
      accelerate();
    }
    if (!isAccelerating && fuel < 100) {
      rechargeFuel();
    }
    if (!isShooting && munition < MAX_MUNITIONS && munitionRechargeTime > 1) {
      rechargeMunition();
      munitionRechargeTime = 0;
    }
    if (flashingDelay > 0) {
      shipColor = shipColor == 255 ? 0 : 255;
    } else {
      flashing = false;
      shipColor = 255;
    }

    position.add(velocity);
    velocity.mult(FRICTION);
    verifyEdges();
    drawFuelSlider();
    drawMunitions();
    drawPoints(points);
  }

  void _rotate () {
    heading += rotation;
  }

  void accelerate () {
    fuel = fuel - FUEL_USE;
    PVector force = PVector.fromAngle(heading).mult(.5);
    velocity.add(force);
  }

  void rechargeFuel () {
    fuel = fuel + FUEL_USE;
  }

  void shootLaser () {
    if (munition > 0) {
      setShootingState(true);
      munition--;
      lasers.add(new Laser(position, heading));
    }
  }

  void rechargeMunition () {
    munition++;
  }

  void handlePressedKey (int _key) {
    switch (_key) {
    case LEFT:
      setRotation(-0.1);
      break;
    case RIGHT:
      setRotation(0.1);
      break;
    case UP:
      setAcceleratingState(true);
      break;
    case ' ':
      shootLaser();
      break;
    }
  }

  void handleReleasedKey (int _key) {
    switch (_key) {
    case LEFT:
      setRotation(0);
      break;
    case RIGHT:
      setRotation(0);
      break;
    case UP:
      setAcceleratingState(false);
      break;
    case ' ':
      setShootingState(false);
      break;
    }
  }

  void verifyEdges () {
    if (position.x > width + size) {
      position.x = -size;
    } else if (position.x < - size) {
      position.x = width + size;
    }

    if (position.y > height + size) {
      position.y = -size;
    } else if (position.y < - size) {
      position.y = height + size;
    }
  }

  boolean verifyCollision (Asteroid asteroid) {
    float distance = dist(position.x, position.y, asteroid.position.x, asteroid.position.y);
    return distance < size + asteroid.size;
  }

  void renderLasers () {
    for (int i = lasers.size() - 1; i >= 0; i--) {
      Laser laser = lasers.get(i);
      if (laser.position.x < 0 || laser.position.x > width || laser.position.y < 0 || laser.position.y > height) {
        lasers.remove(i);
      } else {
        laser.render();
        laser.update();
      }
    }
  }

  void drawFuelSlider() {
    int sliderWidth = 200;
    int sliderHeight = 35;
    stroke(255);
    rect(30, height - sliderHeight - 40, sliderWidth + 2, sliderHeight + 2);
    fill(color(239, 165, 55));
    noStroke();
    rect(32, height - sliderHeight - 38, fuel * 2, sliderHeight);
  }

  void drawMunitions () {
    for (int i = 0; i < MAX_MUNITIONS; i++) {
      fill(255);
      rect(250 + (i * 19), height - 75, 16, 37);
    }
    for (int i = 0; i < munition; i++) {
      fill(57, 255, 20);
      rect(253 + (i * 19), height - 72, 10, 32);
    }
  } 

  void setRotation (float angle) {
    rotation = angle;
  }

  void setAcceleratingState (boolean b) {
    isAccelerating = b;
  }

  void setShootingState (boolean b) {
    isShooting = b;
  }
}
