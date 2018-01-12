class MummyCat extends Enemy {
  PImage mummyCat1, mummyCat2;
  float ySpeed=10;
  float timer;

  MummyCat(float x, float y) {
    super();
    mummyCat1 = loadImage("img/mummyCat1.png") ;
    mummyCat2 = loadImage("img/mummyCat2.png") ;    
    this.x = x;
    this.y = y;
    this.w = 76;
    this.h = 60;
    timer=30;
    this.category=6;
    //counter++;
  }

  void display() {
    super.display();
    timer--;
    if (timer >= 15) {
      img = mummyCat1;
    } else {
      img = mummyCat2;
      w=70;
    }
    if (timer <= 0) {
      timer = 20;
    }
    image(img, x, y, w, h);
  }

  void move(float speed) {
    super.move(speed);
    if (dist(x, y, player.x, player.y) < height+700) {
      y += ySpeed;
      //ySpeed+=0.01;
    }
    if (y>height-140) {    
      y=height-140;
    }
  }

  void playsound() {
    if (y == -540 + ySpeed*60) {
      meowSound.trigger();
    }
  }
}