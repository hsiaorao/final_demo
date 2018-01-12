class Bat extends Enemy {
  PImage bat1, bat2;
  float renewX;
  float timer;
  float t;
  final float a=50; 

  Bat(float x, float y) {
    super();
    bat1 = loadImage("img/bat1.png") ;
    bat2 = loadImage("img/bat2.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 40;
    timer = 30;
    renewX = x;
    this.category=3;
  }

  void move(float speed) {
    super.move(speed+1);
    //timer--;
    t += 0.1;
    y=a*sin(t)+90;
    renewX -= speed;
  }

  void display() {
    timer--;
    if (timer >= 15) {
      img = bat1;
    } else {
      img = bat2;
      h=24;
    }
    if (timer <= 0) {
      timer = 30;
    }
    image(img, x, y, w, h);
  }

  boolean reset() {
    if (renewX <= LIMIT_X) {
      return true;
    } else {
      return false;
    }
  }
}