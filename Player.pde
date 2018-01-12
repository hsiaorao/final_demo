class Player {

  PImage img, girlWL, girlWR, girlJ, girlS;
  float x, y;
  float w = 90, h = 90;
  float jumpSpeed = 13;
  final float PLAYER_INIT_X = 80;
  final float PLAYER_INIT_Y = height - 80 - h;
  float checkX;
  float checkY;
  float checkW;
  float checkH;
  float t;
  final float a = 50;

  int moveDirection = 0;
  float currentX;
  boolean stay;
  boolean isFly, isInvincible, isAfterFly, isDie;
  int flyState;
  int flyTimer;
  int walkTimer;
  int InTimer;
  int dieTimer;
  int hurtTimer;
  //Egg egg;

  Player() {  // remember the gender
    //img = loadImage("img/player" + gender + ".png");
    img = girlIdle;
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    stay = true;
    isFly = false;
    isDie = false;
    walkTimer = 15;
    dieTimer = 30;
    girlWL = girlWalk1;
    girlWR = girlWalk2;
    girlJ = girlJump;
    girlS = girlSlip;
  }

  void die() {
    cameraSpeed = 0;
    this.stay = false;
    this.isDie = true;
    img = ghost;
    dieTimer-=0.5;
    if (dieTimer > 0) {
      y-=2;
    }
  }

  void Invincible() {
    //if (isAfterFly) {
    //  InTimer = 30;
    //} else if (isInvincible) {
    //  InTimer = 50;
    //}

    InTimer--;

    if (InTimer < 0) {
      girlWL = girlWalk1;
      girlWR = girlWalk2;
      girlJ = girlJump;
      girlS = girlSlip;
      objectCanHit = true;
      isAfterFly = false;
      isInvincible = false;
    } else if (InTimer < 100) {
      objectCanHit = false;
      if (InTimer % 20 == 0) {
        girlWL = girlWalk1;
        girlWR = girlWalk2;
        girlJ = girlJump;
        girlS = girlSlip;
      } else if (InTimer % 20 == 10) {
        girlWL = girlWalk1Inv;
        girlWR = girlWalk2Inv;
        girlJ = girlJumpInv;
        girlS = girlSlipInv;
      }
    } else {
      objectCanHit = false;
      girlWL = girlWalk1Inv;
      girlWR = girlWalk2Inv;
      girlJ = girlJumpInv;
      girlS = girlSlipInv;
    }
  }

  void fly() {
    img = girlFlyInv;
    w = 120;
    h = 120;
    if (isFly) {
      player.stay = false;
      switch(flyState) {

      case uptoFly:
        objectCanHit = false;
        if (y > a*sin(t)+100) {
          y -= 8;
        } else {
          flyTimer = 200;
          flyState = flying;
        }
        break;

      case flying:
        objectCanHit = false;
        cameraSpeed = 15;
        flyTimer--;
        t += 0.14;
        y = a*sin(t)+100;
        if (flyTimer <= 0) {
          flyState = downtoRun;
        }
        break;

      case downtoRun:
        objectCanHit = false;
        cameraSpeed = INITIAL_SPEED;
        if (y < PLAYER_INIT_Y) {
          y += 6;
        } else {
          y = PLAYER_INIT_Y;
          //objectCanHit = true;
          isFly = false;
          stay = true;
          isAfterFly = true;
          InTimer = 100;
          w = 90;
          h = 90;
        }
        break;
      }
    }
  }

  void update() {



    if (stay) {
      if (jumpState) {
        currentX = 0;
        img = girlJ;
        moveDirection = UP;
        //moveTimer = moveDuration;
        stay = false;
        y = PLAYER_INIT_Y;
        h = 90;
      } else if (slipState) {
        y = PLAYER_INIT_Y + 25;
        w = 93;
        h = 65;
        img = girlS;
        jumpState = false;
      } else if (backState) {
        stay = false;
        eggTrigger = true;
        eggSound.trigger();
        moveDirection = LEFT;
        y = PLAYER_INIT_Y;
        h = 90;
        //} else if (hurtState) {
        //  jumpState = false;
        //  slipState = false;
        //  hurtTimer--;
        //  if (hurtTimer > 0) {
        //    img = girlHurt;
        //  } else {
        //    hurtState = false;
        //  }
      } else {
        y = PLAYER_INIT_Y;
        h = 90;
        walkTimer--;

        if (walkTimer >= 7) {
          img = girlWL;
        } else {
          img = girlWR;
        }
        if (walkTimer <= 0) {
          walkTimer = 15;
        }
      }
    }

    if (hurtState && !isDie) {
      hurtTimer--;
      if (hurtTimer > 0) {
        img = girlHurt;
      } else {
        hurtState = false;
      }
    }
    image(img, x, y, w, h);
    checkX = x + 12;
    checkY = y + 10;
    if (slipState) {
      checkW = 55;
      checkH = 81;
    } else {
      checkW = 65;
      checkH = 80;
    }

    if (!stay && !isFly && !isDie) {

      //moveTimer --;
      currentX += 5;
      switch(moveDirection) {

      case UP:
        img = girlJ;
        y -= jumpSpeed;
        jumpSpeed -= 0.6;
        if (y > PLAYER_INIT_Y+1) {
          y = PLAYER_INIT_Y;
          jumpSpeed = 13;
          stay = true;
        }
        break;

      case LEFT:
        cameraSpeed = 0;
        img = girlEgg;
        break;
      }
    }
  }
}