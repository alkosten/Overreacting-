PImage labImg;
PImage lab2Img;
Animation scientistAnimation;
Animation beakerAnimation;
Animation gogglesAnimation;
Animation beakAnimation;
PImage[] scientistImages = new PImage[2];
PImage[] beakerImages = new PImage[2];
PImage[] gogglesImages = new PImage[2];
PImage[] beakImages = new PImage[2];

import processing.sound.*;
SoundFile Music;
SoundFile bullet;


Player p1;

int state = 0;
int winScore;
int maxOfEquipment = 5;
int numberOfEquipment = 0;
int numberOfEquipment2 = 0;
int numberOfEquipment3 = 0;
boolean numberEquipmentLost = false;
int p1Score = 0;
int p2Score = 0;
int p3Score = 0;

int startTime;
int endTime;
int interval = 20;

ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;


void setup() {
  size(800, 600);
  rectMode(CENTER);
  imageMode(CENTER);

  p1 = new Player(width/2, height-25, 50, 50, color(255));

  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList <Enemy>();
  
  bullet = new SoundFile(this, "pew.wav");
  Music = new SoundFile(this, "anotheronebites.wav");


  for (int index = 0; index < 2; index++) {
    scientistImages[index] = loadImage("scientist" + index + ".png");
  }
  scientistAnimation = new Animation(scientistImages, 0.1, 0.2);

  for (int index = 0; index < 2; index++) {
    beakerImages[index] = loadImage("beaker" + index + ".png");
  }
  beakerAnimation = new Animation(beakerImages, 0.1, 0.2);

  for (int index = 0; index < 2; index++) {
    gogglesImages[index] = loadImage("goggles" + index + ".png");
  }
  gogglesAnimation = new Animation(gogglesImages, 0.1, 0.2);

  for (int index = 0; index < 2; index++) {
    beakImages[index] = loadImage("beak" + index + ".png");
  }
  beakAnimation = new Animation(beakImages, 0.1, 0.2);

  labImg = loadImage("lab.jpeg");
  labImg.resize(labImg.width*5/3, labImg.height*5/3);

  lab2Img = loadImage("lab2.jpeg");
  lab2Img.resize(labImg.width, labImg.height);
}


void draw() {
  background(0);
  
  if (Music.isPlaying() == false) {
  Music.play();
  }

  switch(state) {

  case 0:
    background(255);
    image(labImg, width/2, height/2);
    textSize(70);
    fill(0);
    text("Overreacting!", width*0.75/3, height/3);
    textSize(40);
    text("Press 'b' to begin", width*0.95/3, height*2/3);

    break;

  case 1:
    background(0);
    image(lab2Img, width/2, height/2);
    scientistAnimation.display(p1.x, p1.y);
    beakerAnimation.isAnimating = true;
    gogglesAnimation.isAnimating = false;
    beakAnimation.isAnimating = false;
    fill(0);
    text(numberOfEquipment, 600, 150);
    p1.move();
    fill(0);
    p1.drawScore(p1Score, 600, 100);
    winScore = 15;
    player1WinScreen();
    loseScreen();

    beakerAnimation.next();
    for (Enemy eachEnemy : enemyList) {
      beakerAnimation.display(eachEnemy.x, eachEnemy.y);
      eachEnemy.move();
      eachEnemy.wallDetect();
    }

    for (Bullet aBullet : bulletList) {
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();

      for (Enemy anEnemy : enemyList) {
        aBullet.shootEnemy(anEnemy);
      }
    }

    for (int i = bulletList.size()-1; i >= 0; i = i - 1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    for (int i = enemyList.size()-1; i >= 0; i = i - 1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        p1Score += 1;
      }

      if (anEnemy.shouldRemove2 == true) {
        enemyList.remove(anEnemy);
        numberOfEquipment += 1;
      }
    }

    endTime = millis();
    if (endTime - startTime >= interval) {
      enemyList.add(new Enemy());
    } else {
    }
    startTime = endTime;

    break;

  case 2:
    background(255);
    image(labImg, width/2, height/2);
    textSize(30);
    text("Oh no! Science Guy accidentally spilled", width/6, height*35/100);
    text("some chemicals in his lab! Now all of", width/6, height*40/100);
    text("his lab equipment has turned evil.", width/6, height*45/100);
    text("Science Guy needs your help to stop the", width/6, height/2);
    text("equipment from taking over his lab!", width/6, height*55/100);
    text("press 's' to start the game.", width/6, height*60/100);

    break;

  case 3:
    background(0);
    image(labImg, width/2, height/2);
    textSize(40);
    fill(0);
    text("level 2", width*43/100, height*45/100);
    text("Press 'l' for round 2", width*30/100, height*60/100);
    
    for (int i=0; i <enemyList.size(); i++ ) {
      enemyList.remove(i);
    }


    break;

  case 4:
    background(0);
    image(lab2Img, width/2, height/2);
    beakerAnimation.isAnimating = false;
    gogglesAnimation.isAnimating = true;
    beakAnimation.isAnimating = false;
    scientistAnimation.display(p1.x, p1.y);
    fill(0);
    text(numberOfEquipment2, 600, 150);
    p1.move();
    fill(0);
    p1.drawScore(p2Score, 600, 100);
    winScore = 20;
    player2WinScreen();
    loseScreen2();
    gogglesAnimation.next();
    
    
    for (Enemy eachEnemy : enemyList) {
      gogglesAnimation.display(eachEnemy.x, eachEnemy.y);
      eachEnemy.move();
      eachEnemy.wallDetect();
    }


    for (Bullet aBullet : bulletList) {
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();

      for (Enemy anEnemy : enemyList) {
        aBullet.shootEnemy(anEnemy);
      }
    }

    for (int i = bulletList.size()-1; i >= 0; i = i - 1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    for (int i = enemyList.size()-1; i >= 0; i = i - 1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        p2Score += 1;
      }

      if (anEnemy.shouldRemove2 == true) {
        numberOfEquipment2 += 1;
        enemyList.remove(anEnemy);
      }
    }

    endTime = millis();
    if (endTime - startTime >= interval) {
      enemyList.add(new Enemy());
    } else {
    }
    startTime = endTime;


    break;

  case 5:
    background(0);
    image(lab2Img, width/2, height/2);
    beakerAnimation.isAnimating = false;
    gogglesAnimation.isAnimating = false;
    beakAnimation.isAnimating = true;
    scientistAnimation.display(p1.x, p1.y);
    fill(0);
    text(numberOfEquipment3, 600, 150);
    p1.move();
    fill(0);
    winScore = 25;
    p1.drawScore(p3Score, 600, 100);
    player3WinScreen();
    loseScreen3();
    beakAnimation.next();
    for (Enemy eachEnemy : enemyList) {
      beakAnimation.display(eachEnemy.x, eachEnemy.y);
      eachEnemy.move();
      eachEnemy.wallDetect();
    }


    for (Bullet aBullet : bulletList) {
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();

      for (Enemy anEnemy : enemyList) {
        aBullet.shootEnemy(anEnemy);
      }
    }

    for (int i = bulletList.size()-1; i >= 0; i = i - 1) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    for (int i = enemyList.size()-1; i >= 0; i = i - 1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        p3Score += 1;
      }

      if (anEnemy.shouldRemove2 == true) {
        numberOfEquipment3 += 1;
        enemyList.remove(anEnemy);
      }
    }

    endTime = millis();
    if (endTime - startTime >= interval) {
      enemyList.add(new Enemy());
    } else {
    }
    startTime = endTime;

    break;

  case 6:
    background(0);
    image(labImg, width/2, height/2);
    textSize(40);
    fill(0);
    text("level 3", width*43/100, height*45/100);
    text("Press 'j' for round 3", width*30/100, height*60/100);

for (int i=0; i <enemyList.size(); i++ ) {
      enemyList.remove(i);
    }

    break;

  case 7:
    background(0);
    image(labImg, width/2, height/2);
    textSize(40);
    fill(0);
    text("You saved the Science Guy's lab!", width*16/100, height*40/100);
    text("Thank you for all your help!", width*20/100, height*50/100);
    text("To replay, press 'r'", width*30/100, height*60/100);

    p1Score = 0;
    p2Score = 0;
    p3Score = 0;
    numberOfEquipment = 0;

    for (int i=0; i <enemyList.size(); i++ ) {
      enemyList.remove(i);
    }

    break;

  case 8:

    background(0);
    image(labImg, width/2, height/2);
    textSize(40);
    fill(0);
    text("Oh no! The lab equipment was too", width*15/100, height*40/100);
    text("quick. Better luck next time!", width*20/100, height*50/100);
    text("Want to try again? Press 'r'.", width*21/100, height*70/100);

    p1Score = 0;
    p2Score = 0;
    p3Score = 0;
    numberOfEquipment = 0;
    numberOfEquipment2 = 0;
    numberOfEquipment3 = 0;

    for (int i=0; i <enemyList.size(); i++ ) {
      enemyList.remove(i);
    }


    break;
  }
}

void keyPressed() {
  if (key == 'b') {
    state = 2;
  }
  if (key == 's') {
    state = 1;
  }
  if (key == 'j') {
    state = 5;
  }
  if (key == 'r') {
    state = 0;
  }
  if (key == 'l') {
    state = 4;
  }
  if (key == 'a') {
    p1.isMovingLeft = true;
    scientistAnimation.isAnimating = true;
  }
  if (key == 'd') {
    p1.isMovingRight = true;
    scientistAnimation.isAnimating = true;
  }
  if (key == ' ') {
    bulletList.add(new Bullet(p1.x, p1.y));
    bullet.play();
  }
}

void keyReleased() {
  if (key == 'a') {
    p1.isMovingLeft = false;
  }
  if (key == 'd') {
    p1.isMovingRight = false;
  }
}

void player1WinScreen() {
  if (p1Score >= winScore) {
    state = 3;
  }
}
void player2WinScreen() {
  if (p2Score >= winScore) {
    state = 6;
  }
}
void player3WinScreen() {
  if (p3Score >= winScore) {
    state = 7;
  }
}
void loseScreen() {
  if (numberOfEquipment > maxOfEquipment) {
    state = 8;
  }
}
  
  void loseScreen2() {
  if (numberOfEquipment2 > maxOfEquipment) {
    state = 8;
  }
  }
  
  void loseScreen3() {
  if (numberOfEquipment3 > maxOfEquipment) {
    state = 8;
  }
  }
