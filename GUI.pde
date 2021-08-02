void configSetup () { //<>//
  gameFont = createFont("HyperspaceBold.otf", 18);
  for (int i = 0; i < ASTEROIDS_NUM; i++) {
    asteroids.add(new Asteroid(randomPosition(), randomSize()));
  }
  for (int i = 0; i < ASTEROIDS_NUM + 5; i++) {
    menuAsteroids.add(new Asteroid(randomPosition(), randomSize()));
  }
  ship = new Ship();
}

void drawLifes () {
  int x = 30;
  int y = 50;
  for (int i = 0; i < LIFES; i++) {
    fill(255);
    triangle(x  + (i * 40), y, x + x/2  + (i * 40), y/2, x*2  + (i * 40), y);
  }
}

void startScreen () {
  renderAsteroids(menuAsteroids);
  drawText("ASTEROIDS", "Aperte enter para começar!");
}

void gameOverScreen () {
  renderAsteroids(menuAsteroids);
  drawText("VOCÊ PERDEU", "Aperte enter para recomeçar!");
}

void drawText (String title, String subtitle) {
  fill(255);
  textFont(gameFont);

  textSize(90);
  textAlign(CENTER, CENTER);
  text(title, width/2, height/2 - 100);

  textSize(30);
  text(subtitle, width/2, height/2);
}

void drawPoints (int points) {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(45);
  text(str(points), width - 40 - (points/100) * 10, 50);
}
