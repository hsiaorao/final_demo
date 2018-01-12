class Brick extends Enemy {
  PImage img;
  int number;

  Brick(float x, float y) {
    super();
    this.number = floor(random(0, 2));
    img = loadImage("img/brick.png") ;
    this.x = x;
    this.y = y;
    this.w = 60 + 60*number;
    this.h = 60;
    this.category=5;
    //counter++;
  }

  void display() {
    switch(number) {
    case 0:
      image(img, x, y, 60, 60);
      break;

    case 1:
      image(img, x, y, 60, 60);
      image(img, x+60, y, 60, 60);
      break;

    }
  }
}