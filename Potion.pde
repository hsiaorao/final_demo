class Potion extends Object {
  boolean isAlive;

  Potion(float x, float y) {
    super();
    img = loadImage("img/potion.png") ;
    this.x = x;
    this.y = y;
    this.w = 48;
    this.h = 60;
    this.category=1;
    isAlive = true;
  }

  void checkCollision(Player player) {
    if (isAlive && !player.isFly && isHit(x, y, w, h, player.checkX, player.checkY, player.checkW, player.checkH)) {
      player.isInvincible = true;
      player.InTimer = 250;
      if(hpX < 216) hpX += 216*0.1;
      if(hpX >= 216) hpX = 216;
      //objectCanHit = false;
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