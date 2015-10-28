int screenSize = 400;
SpaceShip apollo;
public void setup() {
	size(screenSize, screenSize);
	apollo = new SpaceShip();
}
public void draw() {
	background(0);
	moveShip();
	apollo.move();
	apollo.show();
}
class SpaceShip extends Floater {   
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
}
boolean goingUp = false;
boolean goingLeft = false;
boolean goingDown = false;
boolean goingRight = false;
boolean shoot = false;
//int shotCounter = -10;
public void keyPressed() {
	if (keyCode == 38) {goingUp = true;}
	if (keyCode == 40) {goingDown = true;}
	if (keyCode == 39) {goingRight = true;} 
	if (keyCode == 37) {goingLeft = true;}
	//if (keyCode == 32) {
		//if (shotCounter + 10 < gameCounter) {
			//bullets.add(new Bullet(apollo));
			//shotCounter = gameCounter;
		//}
	//}
}
public void keyReleased() {
	if (keyCode == 38) {goingUp = false;}
	if (keyCode == 40) {goingDown = false;} 
	if (keyCode == 39) {goingRight = false;} 
	if (keyCode == 37) {goingLeft = false;}
	if (keyCode == 32) {shoot = false;}
}
public void moveShip() {
	if (goingUp) {
		apollo.accelerate(0.2);
	}
	if (goingDown) {
		apollo.accelerate(-0.2);
	}
	if (goingRight) {
		apollo.rotate(5);
	}
	if (goingLeft) {
		apollo.rotate(-5);
	}
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
	public void move () {      
		//change the x and y coordinates by myDirectionX and myDirectionY       
		myCenterX += myDirectionX;
		myCenterY += myDirectionY;
		if(myCenterX > width) {
			myCenterX = 0;
		} else if (myCenterX < 0) {     
			myCenterX = width;    
		}    
		if(myCenterY > height) {    
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
