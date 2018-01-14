class Mummy extends Enemy {

  float timer;
  Stone stone;
  PImage mummy1, mummy2;
  boolean mummyTrigger=true;

  Mummy(float x, float y) {
    super();
    mummy1 = loadImage("img/mummy1.png");
    mummy2 = loadImage("img/mummy2.png");
    this.x = x;
    this.y = y-10;
    this.w = 50 ;
    this.h = 100;
    timer = 30;
    stone = new Stone(750, this.y+20);
    //this.category=7;
    //counter++;
  }

  void move(float speed) {
    super.move(speed);
    if (x <= 750) {
      stone.fire = true;
      stone.move(speed);
    }
  }

  void display() {
    timer--;
    if (timer >= 15) {
      img = mummy1;
    } else {
      img = mummy2;
    }
    if (timer <= 0) {
      timer = 30;
    }
    image(img, x, y, w, h);
    stone.display();
  }

  void checkCollision(Player player) {
    stone.canHit = this.canHit;
    super.checkCollision(player);
    stone.checkCollision(player);
  }

  void playsound() {
    if (mummyTrigger) {
      if (x <= 750) {
        mummySound.trigger();
        mummyTrigger=false;
      }
    }
  }
}