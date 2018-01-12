class Stone extends Enemy {
  boolean fire;

  Stone(float x, float y) {
    super();
    img = loadImage("img/stone4.png") ;
    this.x = x;
    this.y = y;
    this.w = 30;
    this.h = 13;
    fire = false;
  }

  void move(float speed) {
    super.move(speed+5);
  }

  void display() {
    if (fire) {
      super.display();
      image(img, x, y, w, h);
    }
  }
}