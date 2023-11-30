class Bullet {
  
  int x;
  int y;
  int d;
  
  int speed;
  
  boolean shouldRemove;
  
  int left;
  int right;
  int top;
  int bottom;
  
  
  
  Bullet(int startingX, int startingY) {
    x = startingX;
    y = startingY;
    
    d = 5;
    
    speed = 15;
    
    shouldRemove = false;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
    
  }
  
  void render() {
    fill(color(255,0,0));
    circle(x,y,d);
  }
  
  void move() {
    y -= speed;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void checkRemove() {
    if (y < 0) {
      shouldRemove = true;
    }
  }
  
  void shootEnemy(Enemy anEnemy) {
    if (top <= anEnemy.bottom && 
        bottom >= anEnemy.top &&
        left <= anEnemy.right &&
        right >= anEnemy.left){
          anEnemy.shouldRemove = true;
          shouldRemove = true;
        }
  }
  
}
