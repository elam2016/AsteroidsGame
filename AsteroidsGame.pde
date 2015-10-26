int screenSize = 400;
SpaceShip apollo = new SpaceShip();
public void setup() {
  size(screenSize, screenSize);
  background(0);
}
public void draw() {
  apollo.show();
  apollo.move();
  keyPressed();
}
class SpaceShip extends Floater {   
    public SpaceShip() {
      corners = 12;
      int[] xS = {-25, 0,25,-5, -5, 25,  0,-25,-25,-10,-10,-25};
      int[] yS = { 15,15,10,10,-10,-10,-15,-15,-10,-10, 10, 10};
      xCorners = xS;
      yCorners = yS;
      myColor = color(204, 204, 204);;
      myCenterX = screenSize/2;
      myCenterY = screenSize/2;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection = 0;
    }
    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int)myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int)myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}
}
abstract class Floater {   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected color myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount) {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation) {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }

  boolean goingUp = false;
  boolean sIsPressed = false;
  boolean dIsPressed = false;
  boolean wIsPressed = false;
  boolean spaceIsPressed = false;
  boolean pIsPressed = false;
  public void keyPressed() {
    if (key == CODED) {
      if (keyCode == UP) {apollo.accelerate(1);}
      if (keyCode == DOWN) {apollo.accelerate(1);}
      if (keyCode == RIGHT) {apollo.rotate(1);}
      if (keyCode == LEFT) {apollo.rotate(-1);}
    }
  }
  public void keyPressed() {
  if (key == 'a' || key == 'A') {goingUp = true;}
  if (key == 'd' || key =='D') {dIsPressed = true;}
  if (key == 'w' || key == 'W') {wIsPressed = true;} 
  if (key == 's' || key == 'S') {sIsPressed = true;}
  if (key == 'q' || key == 'Q') { //Hyperspace
    normandy.setX((int)(Math.random()*width));
    normandy.setY((int)(Math.random()*height));
    normandy.setPointDirection((int)(Math.random()*360));
    normandy.setDirectionX(0);
    normandy.setDirectionY(0);
  } 
  if (key == 32) {
    if (shotCounter + 10 < gameCounter) {
      bullets.add(new Bullet(normandy));
      shotCounter = gameCounter;
    }
  }
}

public void keyReleased() {
  if (key == 'a' || key == 'A') {goingUp = false;}
  if (key == 'd' || key == 'D') {dIsPressed = false;} 
  if (key == 'w' || key == 'W') {wIsPressed = false;} 
  if (key == 's' || key == 'S') {sIsPressed = false;} 
  if (key == 'p' || key == 'P') {togglePause = !togglePause;}
  if (keyCode == 32) {spaceIsPressed = false;}
}

  public void move () {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
    if(myCenterX >width) {
      myCenterX = 0;
    } else if (myCenterX<0) {     
      myCenterX = width;    
    }    
    if(myCenterY >height) {    
      myCenterY = 0;    
    } else if (myCenterY < 0) {     
      myCenterY = height;    
    }   
  }   
  public void show () {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++) {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
