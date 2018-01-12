class Torch extends Object {
  boolean isAlive;

  Torch(float x, float y) {
    super();
    img = loadImage("img/torch.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 90;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && isHit(x, y, w, h, player.checkX, player.checkY, player.checkW, player.checkH)) {
      //add the light
      light.w+=1700;
      light.h+=1000;
      isAlive = false;
      openBoxSound.trigger();
    }
  }

  void display() {
    if (isAlive) {
      super.display();
    }
  }
}