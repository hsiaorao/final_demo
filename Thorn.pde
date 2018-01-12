class Thorn extends Enemy {
  PImage img;  

  Thorn(float x, float y) {
    super();
    img = loadImage("img/thorn.png") ;
    this.x = x;
    this.y = y;
    this.w = 90;
    this.h = 30;
    this.category=4;
    //counter++;
  }
  void display() {
    super.display();
    image(img, x, y, w, h);
  }
}