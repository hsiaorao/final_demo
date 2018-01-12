class Box extends Object {
  boolean isAlive;
  PImage box, boxOpen;

  Box(float x, float y) {
    super();
    box = loadImage("img/box.png");
    boxOpen = loadImage("img/boxOpen.png");
    this.x = x;
    this.y = y;
    this.w = 58;
    this.h = 80;
    this.category=8;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && isHit(x, y, w, h, player.checkX, player.checkY, player.checkW, player.checkH)) {
      player.flyState = uptoFly;
      light.w=light.MAX_LIGHT_W;
      light.h=light.MAX_LIGHT_H;
      player.isFly = true;
      objectCanHit = false;
      isAlive = false;
      openBoxSound.trigger();
      flySound.trigger();
    }
  }

  void display() {
    if (isAlive) {
      img = box;
    } else {
      img = boxOpen;
      w=54;
    }
    super.display();
    image(img, x, y, w, h);
  }
}