class Enemy {
  
  float x;
  float y;
  float d;
  
  float left;
  float right;
  float top;
  float bottom;
  
  float ySpeed;
  int c1;
  
  boolean shouldRemove;
  boolean shouldRemove2;
  
  Enemy(float startingX, float startingY, float startingD, int startingYSpeed, int color1) {
    
    x = startingX;
    y = startingY;
    d = startingD;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
    
    shouldRemove = false;
    shouldRemove2 = false;
    
    c1 = color1;
    ySpeed = startingYSpeed;
    
  }
  
 Enemy() {
        
        // initialize from my parameters
        x = int(random(width/4, 3*width/4));
        y = 10;
        
        // hard coded vars
        d = random(25, 100);
        c1 = color(random(0,255), random(0,255), random(0,255));
        //ySpeed = random(1,5);
        ySpeed = 5;
  }
  
  void render() {
    rectMode(CENTER);
    fill(c1);
    circle(x,y,d);
  }
  
  void move() {
    y = y + ySpeed;
    
    top = y - d/2;
  bottom = y + d/2;
  right = x + d/2;
  left = x - d/2;
  }
  
  void bottomCrash(int number, int x, int y) {
    
    text(number, x, y);


  }
  
  void wallDetect() {
    if (y >= height) {
      shouldRemove2 = true;
    }
  }
  
}
