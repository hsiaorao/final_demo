class Egg extends Enemy {

  Egg() {
    super();
    img = loadImage("img/lion.png");
    this.x = -w-800;
    this.y = height - 80 - 285;
    this.w = 300;
    this.h = 285;
  }

  void move() {
    super.move(-12);
    println(this.y);
    //cameraSpeed = -3;
  }

  void display() {
    super.display();
    image(img, x, y, w, h);
  }

  void checkCollision(Player player) {
    //hpX = -1;
    super.checkCollision(player);
    
  }
}