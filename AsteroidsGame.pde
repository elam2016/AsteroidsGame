int screenSize = 600;
Particle [] particles;
SpaceShip apollo;
Star [] stars;
public ArrayList <Bullet> bullets = new ArrayList <Bullet>();
public ArrayList<Asteroid> asteroids = new ArrayList <Asteroid>();
int level = 1;
int bulletCounter = 0;

boolean goingUp = false;
boolean goingLeft = false;
boolean goingDown = false;
boolean goingRight = false;
boolean shoot = false;

public void setup() {
	size(screenSize, screenSize);
	apollo = new SpaceShip();
	noStroke();
	particles = new Particle[screenSize/5];
	for(int n = 0; n < particles.length; n++) {
		particles[n] = new NormalParticle();
	}
	stars = new Star[screenSize/10];
	for(int s = 0; s < stars.length; s++) {
		stars[s] = new Star();
	}
	for(int a = 0; a < 50; a++) {
		asteroids.add(a, new Asteroid());
	}
}
public void draw() {
	background(0);
	for(int s = 0; s < stars.length; s++) {
		stars[s].show();
		stars[s].move();
	}
	for(int n = 0; n < particles.length; n++) {
		particles[n].show();
		particles[n].move();
	}
	for(int b = 0; b < bullets.size(); b++) {
		Bullet hit = bullets.get(b);
		hit.show();
		hit.move();
	}
	for(int a =0; a < asteroids.size();a++) {
		(asteroids.get(a)).show();
		if(dist(apollo.getX(),apollo.getY(),asteroids.get(a).getX(), asteroids.get(a).getY()) < 20) {
			asteroids.remove(a);
		} else
			(asteroids.get(a)).move();
		for(int b = 0; b < bullets.size(); b++) {
			if(dist(bullets.get(b).getX(),bullets.get(b).getY(),asteroids.get(a).getX(), asteroids.get(a).getY()) < 20) {
				asteroids.remove(a);
				bullets.remove(b);
				break;
			}
		}
	}
	Asteroid eros = new Asteroid();
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
		if(level == 1) {
			corners = 17;
			int[] xS = {-15,-25,-25, -5,-5, 5,5,25,25, 5,  5, -5, -5,-25,-25,-15,-15};
			int[] yS = { 10, 10, 15, 15,10,10,3, 3,-3,-3,-10,-10,-15,-15,-10,-10, 10};
			xCorners = xS;
			yCorners = yS;
		}
		if(level == 2) {
			corners = 12;
			int[] xS = {-25, 0,25,-5, -5, 25,  0,-25,-25,-10,-10,-25};
			int[] yS = { 15,15,10,10,-10,-10,-15,-15,-10,-10, 10, 10};
			xCorners = xS;
			yCorners = yS;
		}
		myColor = color(204, 204, 204);;
		myCenterX = screenSize/2;
		myCenterY = screenSize/2;
		myDirectionX = 0;
		myDirectionY = 0;
		myPointDirection = 0;
	}
}

public class Bullet extends Floater {
	public void setX(int x){myCenterX=x;}
	public int getX(){return (int)myCenterX;}
	public void setY(int y){myCenterY=y;}   
	public int getY(){return (int)myCenterY;}    
	public void setDirectionX(double x){myDirectionX=x;}   
	public double getDirectionX(){return myDirectionX;}   
	public void setDirectionY(double y){myDirectionY=y;}  
	public double getDirectionY(){return myDirectionY;}   
	public void setPointDirection(int degrees){myPointDirection=degrees;}   
	public double getPointDirection(){return myPointDirection;}
	private double dRadians;
	private float bSize;
	public Bullet(SpaceShip ship) {
			myCenterX = ship.getX();
			myCenterY = ship.getY();
			bSize = 4;
			myPointDirection = ship.getPointDirection();
			dRadians = myPointDirection*(Math.PI/180);
			myDirectionX = (5*Math.cos(dRadians) + ship.getDirectionX());
			myDirectionY = (5*Math.sin(dRadians) + ship.getDirectionY());
			myColor = color(255);
	}
	public void show() {
		fill(255);
		if(level == 1) {
			ellipse((float)myCenterX, (float)myCenterY, bSize, bSize);
		}
		if(level == 2) {
			if(myPointDirection > 315 && myPointDirection < 45) {
				ellipse((float)myCenterX, (float)myCenterY - 12, bSize, bSize);
				ellipse((float)myCenterX, (float)myCenterY + 12, bSize, bSize);
			}
		}
	}
	public void move() {
		myCenterX += myDirectionX;
		myCenterY += myDirectionY;
	}
}

public class Asteroid extends Floater {
	public void setX(int x){myCenterX=x;}
	public int getX(){return (int)myCenterX;}
	public void setY(int y){myCenterY=y;}   
	public int getY(){return (int)myCenterY;}    
	public void setDirectionX(double x){myDirectionX=x;}   
	public double getDirectionX(){return myDirectionX;}   
	public void setDirectionY(double y){myDirectionY=y;}  
	public double getDirectionY(){return myDirectionY;}   
	public void setPointDirection(int degrees){myPointDirection=degrees;}   
	public double getPointDirection(){return myPointDirection;}
	private double rotSpeed;
	public Asteroid() {
		corners = 8;
		int[] xS = {-11,-20,-14,5, 9, 7,10,-11};
		int[] yS = { -5,-10,  8,5,10,10, 3, -5};
		xCorners = xS;
		yCorners = yS;
		myColor = color(136, 167, 139);
		myCenterX = (int)(Math.random()*screenSize + 1);
		myCenterY = (int)(Math.random()*screenSize + 1);
		myPointDirection = 0;
		myDirectionX = (int)(Math.random()*4 - 2);
		if(myDirectionX == 0) {myDirectionX++;}
		myDirectionY = (int)(Math.random()*4 - 2);
		if(myDirectionY == 0) {myDirectionY++;}
		rotSpeed = (int)(Math.random()*3-5);
		if(rotSpeed == 0) {rotSpeed ++;}

	}
	public void move() {
		super.move();
		rotate((int)rotSpeed);
	}
}

public class Star {
	private float starX, starY, starSize;
	public Star() {
		starX = (int)(Math.random()*screenSize);
		starY = (int)(Math.random()*screenSize);
		starSize = (int)(Math.random()*5);
	}
	public void show() {
		noStroke();
		fill(255, 100);
		ellipse(starX, starY, starSize, starSize);
	}
	public void move() {
		starX += .5;
		if(starX > screenSize) {
			starX = -5;
			starY = (int)(Math.random()*screenSize);
		}
	}
}

public void keyPressed() {
	if (keyCode == 38) {goingUp = true;}
	if (keyCode == 40) {goingDown = true;}
	if (keyCode == 39) {goingRight = true;} 
	if (keyCode == 37) {goingLeft = true;}
	if (keyCode == 32) {
		if(bulletCounter < 10) {
			Bullet shot = new Bullet(apollo);
			bullets.add(shot);
			bulletCounter ++;	
		} else {
			bulletCounter = 0;
		}
	}
}
public void keyReleased() {
	if (keyCode == 38) {goingUp = false;}
	if (keyCode == 40) {goingDown = false;} 
	if (keyCode == 39) {goingRight = false;} 
	if (keyCode == 37) {goingLeft = false;}
}
public void moveShip() {
	if (goingUp) {
		apollo.accelerate(0.1);
	}
	if (goingDown) {
		apollo.accelerate(-0.1); //deccelerates ship (brakes)
	}
	if (goingRight) {
		apollo.rotate(3);
	}
	if (goingLeft) {
		apollo.rotate(-3);
	}
}

public class NormalParticle implements Particle {
	double nX, nY, nSpeed, nAngle;
	float nSize;
	color nColor = color(((int)(Math.random()*40 + 200)), ((int)(Math.random()*45 + 207)), ((int)(Math.random()*45 + 170)), 70);
	public NormalParticle() {
		nX = screenSize/2;
		nY = screenSize/2;
		nSpeed = ((Math.random()*5) + 1);
		nAngle = (Math.random()*(2*Math.PI));
		nSize = 2;
	}
	public void move() {
		if(nX > (screenSize + 10) || nY > (screenSize + 10) || nX < -10 || nY < -10) {
			nX = screenSize/2;
			nY = screenSize/2;
			nSize = 2;
			nSpeed = ((Math.random()*5) + 1);
			nAngle = (Math.random()*(2*Math.PI));
			nColor = color(((int)(Math.random()*40 + 200)), ((int)(Math.random()*45 + 180)), ((int)(Math.random()*45 + 170)), 70);
		}
		nX += (Math.cos(nAngle)*nSpeed);
		nY += (Math.sin(nAngle)*nSpeed);
		nSize += .05;
	}
	public void show() {
		fill(nColor);
		noStroke();
		ellipse((float)nX, (float)nY, (int)nSize, (int)nSize);
	}
}
public interface Particle {
	public void move();
	public void show();
}















//-------- DO NOT CHANGE CODE BELOW --------//
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
