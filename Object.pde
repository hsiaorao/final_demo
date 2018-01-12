class Object {
  PImage img;
  float x, y, w, h;
  float xSpeed;
  boolean canHit;
  boolean isTorch;
  boolean isMummy;
  final float LIMIT_X = -400;
  final float RESET_X = 800+360*2;
  int category;

  Object() {
    canHit = true;
    isTorch= false;
  }

  void move(float speed) {
    this.xSpeed = speed;
    x -= xSpeed;
  }

  void checkCollision(Player player) {
  }

  void display() {
    imageMode(CORNER);
    image(img, x, y, w, h);
  }

  void update() {
  }

  void playsound() {
  }

  boolean isMummy() {
    if (this.category == 7)
      return true;
    else
      return false;
  }

  boolean reset() {
    if (x <= LIMIT_X) {    
      return true;
    } else {
      return false;
    }
  }
}