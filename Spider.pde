class Spider extends Enemy {
  PImage img;
  float ySpeed = 3;
  //int counter=0;

  Spider(float x, float y) {
    super();
    img = loadImage("img/spider.png") ;
    this.x = x;
    this.y = y;
    this.w = 60;
    this.h = 43;
    this.category=2;
    //counter++;
  }

  void move(float speed) {
    super.move(speed);
    //detect the distance
    if (dist(x, y, player.x, player.y) < 240) {
      y += (ySpeed + (currentCS - INITIAL_SPEED)/2);
      if (y >=280 || y <= 50) {
        ySpeed *= -1;
      }
    }
  }

  void display() {
    super.display();
    stroke(1);  
    line(x+w/2, 0, x+w/2, y+h/2);
    image(img, x, y, w, h);
  }    

  void playsound() {
    if (y == height-300+ ySpeed + (currentCS - INITIAL_SPEED)/2) {
      spiderSound.trigger();
    }
  }
}