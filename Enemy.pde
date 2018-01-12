class Enemy extends Object {
  boolean isAlive;
  Enemy() {
    super();
    isAlive = true;
  }

  void display() {
    imageMode(CORNER);
  }

  void update() {
  }

  void checkCollision(Player player) {
    if (isAlive && canHit && isHit(x, y, w, h, player.checkX, player.checkY, player.checkW, player.checkH)) {
      if (eggTrigger) {
        hpX -= 216;
      } else {
        hpX -= (216*0.2+1);
        isAlive = false;
        hurtState = true;
        isHitSound.trigger();
        player.hurtTimer = 15;
        //game_over
      }
      if (hpX <= 0) {
        player.die();
        dieSound.trigger();
        hpX = 0;
      }
    }
  }
}