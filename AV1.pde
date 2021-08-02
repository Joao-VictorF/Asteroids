void setup () {
  fullScreen();
  configSetup();
}

void draw () { // 60 fps
  background(0);
  screens();
}

void screens () {
  if (!PLAYING) {
    startScreen();
  } else if (LIFES > 0) {
    game();
  } else {
    gameOverScreen();
  }
}

void game () {
  renderAsteroids(asteroids);
  ship.render();                                    
  drawLifes();
}

void keyPressed () {
  ship.handlePressedKey(keyCode);
}

void keyReleased () {
  if (keyCode == ENTER && !PLAYING) {
    PLAYING = true;
  }
  if (keyCode == ENTER && PLAYING && LIFES == 0) {
    PLAYING = true;
    LIFES   = 3;
    asteroids.clear();
    points = 0;
    for (int i = 0; i < ASTEROIDS_NUM; i++) {
      asteroids.add(new Asteroid(randomPosition(), randomSize()));
    }

    ship = new Ship();
  }
  ship.handleReleasedKey(keyCode);
}
