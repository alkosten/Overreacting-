class Player{
  
  int x;
  int y;
  
  int w;
  int h;
  
  boolean isMovingLeft;
  boolean isMovingRight;
  
  int speed;
  
  int c1;
  
  
  Player(int startingX, int startingY, int startingW, int startingH, int color1) {
    
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
    isMovingLeft = false;
    isMovingRight = false; 
    
    speed = 10;
    
    c1 = color1;
  }
  
  
  void render() {
    rectMode(CENTER);
    fill(c1);
    rect(x,y,w,h);
    
  }
  
  void move() {
    
    if(isMovingLeft == true){
      x -= speed;
    } 
    
    if(isMovingRight == true){
      x += speed;
  }
  }
  
  void drawScore(int score, int x, int y) {
  text(score, x, y);
  }


}
