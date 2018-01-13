PImage girlIdle, girlJump, girlFly, girlSlip, girlWalk1, girlWalk2, ghost;
PImage girlJumpInv, girlFlyInv, girlSlipInv, girlWalk1Inv, girlWalk2Inv;
PImage girlEgg, ghostEgg, girlHurt;
PImage gameStart, gameStartH, gameOver, gameOverH, hp, gameIntro, lion;
float cameraSpeed, moveDistance=0;
float currentCS;
String depthString;
String score, currentScore;
int delayTimer=120, hpX;
int introTimer;
int fade;
Player player;
Light light;
Egg egg;
Background[] bg = new Background[3]; 
Object[] object = new Object[6];
PFont papyrus;
boolean objectCanHit = true;
boolean jumpState = false;
boolean slipState = false;
boolean backState = false;
boolean eggTrigger = false;
boolean hurtState = false;
final int uptoFly = 0, flying = 1, downtoRun = 2;
final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2, GAME_INTRO=3;
int gameState = 0;
final int DelayObject = 50*15;
final float divideObject = 2.5;
int mummyCount=0;
int objectRandom;
int highscore=0;
int objectNew, nowScore;
final int INITIAL_OBJECT_X = 800;
final int RENEW_OBJECT_X = 2400;
final int NEXT_OBJECT = 600;
final int INITIAL_SPEED = 7;
final int addObject = 75;

import ddf.minim.*;
Minim minim;
AudioPlayer playingSong, openingSong;
AudioSample eatPotionSound, openBoxSound, dieSound, flySound, meowSound, mummySound, spiderSound, isHitSound;
AudioSample eggSound, enemyHitSound;

void setup() {
  size(800, 450, P2D);

  //load Image
  ghost= loadImage("img/ghost.png");
  girlIdle = loadImage("img/girlIdle.png");
  girlJump = loadImage("img/girlJump.png"); 
  girlFly = loadImage("img/girlFly.png");
  girlSlip = loadImage("img/girlSlip.png");
  girlWalk1 = loadImage("img/girlWalk1.png");  
  girlWalk2 = loadImage("img/girlWalk2.png");  
  girlJumpInv = loadImage("img/girlJumpInv.png"); 
  girlFlyInv = loadImage("img/girlFlyInv.png");
  girlSlipInv = loadImage("img/girlSlipInv.png");
  girlWalk1Inv = loadImage("img/girlInvincibleLeft.png");  
  girlWalk2Inv = loadImage("img/girlInvincibleRight.png");
  girlEgg = loadImage("img/girlEgg.png");  
  girlHurt = loadImage("img/girlHurt.png");  
  gameStart = loadImage("img/gameStart0.png");
  gameStartH = loadImage("img/gameStart1.png");
  gameOver= loadImage("img/gameOver0.png");
  gameOverH= loadImage("img/gameOver1.png");
  gameIntro = loadImage("img/gameIntro.png");
  lion = loadImage("img/lion.png");
  hp= loadImage("img/hp.png");

  //load sound
  minim=new Minim(this);
  playingSong = minim.loadFile("sound/Pyramids.wav");
  openingSong = minim.loadFile("sound/mystery.wav");
  openBoxSound = minim.loadSample("sound/magic.wav");
  dieSound = minim.loadSample("sound/gameover.wav", 128);
  flySound = minim.loadSample("sound/fly.wav");
  meowSound = minim.loadSample("sound/meow.wav");
  mummySound = minim.loadSample("sound/mummy.wav");
  spiderSound = minim.loadSample("sound/spider.wav");
  isHitSound = minim.loadSample("sound/gotHit.wav");
  eggSound = minim.loadSample("sound/egg.wav");
  enemyHitSound = minim.loadSample("sound/enemyHit.wav");
  openingSong.play();
  openingSong.loop();

  //load font
  papyrus = createFont("font/papyrus.ttf", 45, true);
  textFont(papyrus);
  objectRandom = floor(random(0, 9));
  initGame();
}

void initGame() {

  cameraSpeed = INITIAL_SPEED;
  //speedup = 0;
  moveDistance =0;
  delayTimer=120;
  introTimer=1000;
  hpX=216;
  fade=255;

  //initialize player
  player = new Player();
  backState = false;
  eggTrigger = false;

  //initialize background
  for (int i=0; i<bg.length; i++) {
    bg[i] = new Background(i*800, 0);
  }

  //initialize object
  for (int i=0; i<object.length; i++) {
    objectRandom = floor(random(1, 4));
    switch(objectRandom) {      
      //item      
    case 0:
      object[i] = new Torch(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-360);
      object[i].isTorch = true;
      break;        
    case 1:
      object[i] = new Thorn(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-110);
      break;  
      //enemy in the air   


    case 2:
      object[i] = new Bat(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-random(240, 360));
      break;

      //enemy on the ground         
    case 3:
      object[i] = new Brick(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-140);
      break;
    case 4:
      object[i] = new Spider(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-300);
      break;    
    case 5:
      object[i] = new Potion(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-330);
      break;
    case 6:
      object[i] = new MummyCat(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-140);
      break;    
    case 7:
      object[i] = new Box(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-160);
      break;
    case 8:
      object[i] = new Mummy(INITIAL_OBJECT_X + i*NEXT_OBJECT, height-170);
      break;
    }
  }

  //initialize light
  light= new Light();

  //initialize egg
  egg = new Egg();
}

void draw() {
  switch (gameState) {

  case GAME_START: // Start Screen
    image(gameStart, 0, 0);
    if (mouseX > 320  && mouseX < 480 && mouseY > 350  && mouseY < 410 || keyPressed) {
      if (mousePressed || keyPressed) {
        if (keyPressed) {
          image(gameStartH, 0, 0);
        }
        mousePressed = false;
        keyPressed = false;                  
        gameState =  GAME_INTRO;      
        openingSong.pause();
        playingSong.play();
        playingSong.loop();
      } else {
        image(gameStartH, 0, 0);
      }
    }
    break;

  case GAME_INTRO:
    backState = false;
    introTimer--;
    //println(introTimer);
    for (int i=0; i<bg.length; i++) {
      bg[i].move(cameraSpeed);
      bg[i].display();
    }
    player.update();

    //intro word
    tint(255, fade);
    image(gameIntro, -210, -60, 1040, 565);
    if (introTimer>0 && introTimer<100) {
      fade-=5;
      if (fade<0) fade=0;
    }
    tint(255);
    if (introTimer<=0) {
      gameState=GAME_RUN;
    }
    if (keyPressed && key == ' ') {
      gameState=GAME_RUN;
      keyPressed = false;
    }

    break;

  case GAME_RUN:

    moveDistance += cameraSpeed;
    //Background
    for (int i=0; i<bg.length; i++) {
      bg[i].move(cameraSpeed);
      bg[i].display();
    }

    //hp
    noStroke();
    fill(255, 0, 0);
    rect(16, 17, hpX, 21);
    image(hp, 10, 10, 229, 35); 

    objectCanHit(objectCanHit);

    //Object
    nowScore = floor(moveDistance/50);
    objectNew = min(nowScore/addObject+4, 9);
    for (int i=0; i<object.length; i++) {
      object[i].move(cameraSpeed);
      object[i].display();
      object[i].update();   
      object[i].checkCollision(player);
      object[i].playsound();
      if (object[i].reset()) {
        //if (object[i].isMummy())
        //  mummyCount=0;
        object[i] = renew(objectNew);
      }
    }

    // cameraSpeed
    if (!player.isDie) {
      for (int i=0; i<20; i++) {
        if ((moveDistance/50)>=100+i*200) {
          cameraSpeed=INITIAL_SPEED+(i+1)*0.5;
        }
      }
    }

    //player
    player.update();
    if (player.isFly) {
      player.fly();
    }
    if (player.isAfterFly || player.isInvincible) {
      player.Invincible();
    }

    //light  
    light.update();
    light.display(); //add from light  

    //let the torch show up
    for (int i=0; i<object.length; i++) {
      if (object[i].isTorch) {
        object[i].display();
      }
    }

    //egg
    if (eggTrigger) {
      egg.move();
      egg.display();
      egg.checkCollision(player);
    }

    // m Count UI
    depthString = "Best :" + highscore +" m ";
    currentScore="Current :"+(floor(moveDistance/50))+" m ";
    score=(floor(moveDistance/50))+" m ";
    textAlign(RIGHT, TOP);
    textSize(16);
    textFont(papyrus);
    fill(0, 120);
    text(currentScore, width-13, 3);
    fill(#ffcc00);
    text(currentScore, width-10, 0);
    fill(0, 120);
    text(depthString, width-13, 53);
    fill(255, 0, 0);
    text(depthString, width-10, 50);

    if (player.isDie == true) {
      delayTimer--;
      if (delayTimer==119) {
        playingSong.pause();
      }
      if (delayTimer == 0) {
        gameState = GAME_OVER;
        openingSong.play();
        openingSong.loop();
      }
    }
    break;

  case GAME_OVER:
    imageMode(CORNER); 
    image(gameOver, 0, 0);
    if (highscore < (floor(moveDistance/50)))
      highscore=(floor(moveDistance/50));
    if (mouseX > 325  && mouseX < 480 && mouseY > 360  && mouseY < 430 || keyPressed) {
      if (mousePressed  || keyPressed) {
        if (keyPressed) {
          image(gameOverH, 0, 0);
        }
        gameState = GAME_RUN;
        mousePressed = false;
        keyPressed = false;
        initGame();
        openingSong.pause();
        playingSong.play();
        playingSong.loop();
      } else {
        image(gameOverH, 0, 0);
      }
    }  
    textAlign(CENTER, CENTER);
    textSize(65);
    textFont(papyrus);
    fill(0, 120);
    text("Score : "+score, 403, 293);
    fill(#ffcc00);
    text("Score : "+score, 400, 290);
    break;
  }
}


void objectCanHit(boolean objectCanHit) {
  //if (player.isFly) {
  //  player.fly();
  //}
  //if (player.isAfterFly || player.isInvincible) {
  //  player.Invincible();
  //}
  if (objectCanHit) {
    for (int i=0; i<object.length; i++) {
      object[i].canHit = true;
    }
  } else if (!objectCanHit) {
    for (int i=0; i<object.length; i++) {
      object[i].canHit = false;
    }
  }
}

Object renew(int objectNew) {
  Object object;
  int objectRandom = floor(random(0, objectNew));
  //if (objectRandom==7 && mummyCount==1)
  //objectRandom = (objectRandom + floor(random(1, 9)))%9;
  switch(objectRandom) {
    //item    
  case 0:
    object = new Torch(RENEW_OBJECT_X+NEXT_OBJECT, height-360);
    object.isTorch = true;
    return object;
  case 1:
    object = new Thorn(RENEW_OBJECT_X+NEXT_OBJECT, height-110);
    return object;

    //enemy in the air  
  case 2:
    object = new Bat(RENEW_OBJECT_X+NEXT_OBJECT, height-random(240, 360));
    return object;

    //enemy on the ground   
  case 3:
    object = new Brick(RENEW_OBJECT_X+NEXT_OBJECT, height-140);
    return object; 
  case 4:
    object = new Spider(RENEW_OBJECT_X+NEXT_OBJECT, height-300);
    return object;
  case 5:
    object = new Potion(RENEW_OBJECT_X+NEXT_OBJECT, height-330);
    return object; 
  case 6:
    object = new MummyCat(RENEW_OBJECT_X+NEXT_OBJECT, -540);
    return object;    
  case 7:
    object = new Box(RENEW_OBJECT_X+NEXT_OBJECT, height-160);
    return object;
  case 8:
    object = new Mummy(RENEW_OBJECT_X+NEXT_OBJECT, height-170);
    return object;
  }
  return null;
}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  return  ax + aw > bx &&    // a right edge past b left
    ax < bx + bw &&    // a left edge past b right
    ay + ah > by &&    // a top edge past b bottom
    ay < by + bh;
}

void keyPressed() {
  if (key==CODED) {
    switch(keyCode) {
    case UP:
      jumpState = true;
      break;
    case LEFT:
      backState = true;
      break;
    case DOWN:
      slipState  = true;
      break;
    }
  }
}

void keyReleased() {
  if (key==CODED) {
    switch(keyCode) {
    case UP:
      jumpState = false;
      break;
      //case LEFT:
      //  backState = false;
      //  break;
    case DOWN:
      slipState = false;
      break;
    }
  }
}