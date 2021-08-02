class Asteroid {
  PVector position;
  PVector velocity;
  float size;
  int vertices;
  float[] verticesRandomOffsets;

  Asteroid (PVector _position, float _size) {
    position = _position;
    velocity = PVector.random2D();
    size = _size;
    vertices = int(random(5, 15));
    generateVerticesOffsets();
  }

  void render () {
    pushMatrix();
    translate(position.x, position.y);
    stroke(255);
    strokeWeight(2);
    
    fill(0);
    beginShape();
    for (int i = 0; i < vertices; i++) {
      float offset = size + verticesRandomOffsets[i];
      float angle = map(i, 0, vertices, 0, TWO_PI);
      float x = cos(angle) * offset;
      float y = sin(angle) * offset;
      vertex(x, y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  void update () {
    position.add(velocity);
    verifyEdges();
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

  void generateVerticesOffsets () {
    verticesRandomOffsets = new float[vertices];
    for (int i = 0; i < vertices; i++) {
      verticesRandomOffsets[i] = random(-10, 10);
    }
  }

  void asteroidSplit (PVector position, float size, ArrayList<Asteroid> asteroids) {
    if (size > 30) {
      float halfSize = size/2;
      asteroids.add(new Asteroid(new PVector(position.x - halfSize, position.y - halfSize), halfSize));
      asteroids.add(new Asteroid(new PVector(position.x + halfSize, position.y + halfSize), halfSize));
    }
  }
}

void renderAsteroids (ArrayList<Asteroid> asteroids) {
  ASTEROID_GENERATION_TIME -= 1.0/60;

  if (ASTEROID_GENERATION_TIME < 0) {
    asteroids.add(new Asteroid(new PVector(-50, -50), randomSize()));
    ASTEROID_GENERATION_TIME = 5;
  }

  for (int i = asteroids.size() - 1; i >= 0; i--) {
    Asteroid asteroid = asteroids.get(i);
    if (ship.verifyCollision(asteroid) && !ship.flashing) {
      LIFES--;
      ship = new Ship();
    }

    for (int j = ship.lasers.size() - 1; j >= 0; j--) {
      if (ship.lasers.get(j).verifyCollision(asteroid)) {
        asteroid.asteroidSplit(asteroid.position, asteroid.size, asteroids);
        destroyLaser(j, ship.lasers);
        asteroids.remove(i);
        points += 5;
      }
    }

    asteroid.render();
    asteroid.update();
  }
}

void asteroidsSelfColission() {
  for (int i = asteroids.size() - 1; i >= 0; i--) {
    Asteroid asteroidI = asteroids.get(i);
    for (int j = asteroids.size() - 1; j >= 0; j--) {
      Asteroid asteroidJ = asteroids.get(j);
      if (verifyAsteroidsSelfColission(asteroidI, asteroidJ)) {
        //print("bateu!");
        //asteroidI.velocity = asteroidI.velocity.mult(-.5);
        //asteroidJ.velocity = asteroidJ.velocity.mult(-.5);
      }
    }
  }
}

boolean verifyAsteroidsSelfColission (Asteroid asteroidI, Asteroid asteroidJ) {
  float distance = dist(asteroidI.position.x, asteroidI.position.y, asteroidJ.position.x, asteroidJ.position.y);
  return distance > asteroidI.size;
}

PVector randomPosition() {
  return new PVector(random(width), random(height));
}

float randomSize() {
  return random(40, 100);
}
