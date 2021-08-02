PFont   gameFont;

boolean PLAYING = false;
int     ASTEROIDS_NUM = 7;
int     LIFES = 3;
float   ASTEROID_GENERATION_TIME = 5;

ArrayList<Asteroid> menuAsteroids = new ArrayList<Asteroid>();
ArrayList<Asteroid> asteroids     = new ArrayList<Asteroid>();

Ship  ship;
float FRICTION = .95;
float FUEL_USE = 0.4;
int   points   = 0;
int   MAX_MUNITIONS = 10;
int   shipColor     = 255;
float munitionRechargeTime = 0;
float flashingDelay        = 1.5;
