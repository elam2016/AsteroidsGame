int screenSize = 600;
Particle [] particles;
SpaceShip apollo;
Star [] stars;
public ArrayList <Bullet> bullets = new ArrayList <Bullet>();
public ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();
int level = 1;
int bulletCounter = 0;
int hitCount = 0;
int breakCount = 0;
boolean start = false;
boolean gameOver = false;
int gameCount = 0;

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
		for(int p = 0; p < particles.length; p++) {
			particles[p] = new NormalParticle();
		}
		stars = new Star[screenSize/10];
		for(int s = 0; s < stars.length; s++) {
			stars[s] = new Star();
		}
		for(int a = 0; a < 30; a++) {
			asteroids.add(a, new Asteroid());
	}
}
public void draw() {
	background(0);
	if(start) {
		for(int s = 0; s < stars.length; s++) {
			stars[s].show();
			stars[s].move();
		}
		for(int p = 0; p < particles.length; p++) {
			particles[p].show();
			particles[p].move();
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
				hitCount++;
				if(hitCount == 10) {
					apollo.setX(screenSize/2);
					apollo.setY(screenSize/2);
					apollo.setDirectionX(0);
					apollo.setDirectionY(0);
					apollo.setPointDirection(0);
					gameOver = true;
					gameCount++;
					asteroids.add(a, new Asteroid());
				}
			} else
				(asteroids.get(a)).move();
			for(int b = 0; b < bullets.size(); b++) {
				if(dist(bullets.get(b).getX(),bullets.get(b).getY(),asteroids.get(a).getX(), asteroids.get(a).getY()) < 25) {
					breakCount++;
					if(breakCount == 5) {
						level++;
					}
					asteroids.remove(a);
					bullets.remove(b);
					break;
				}
			}
		}
		fill(255);
		textSize(15);
		text("Level: " + level, 30, 10);
		if(gameCount == 0){
			moveShip();
			apollo.move();
			apollo.show();
		}
		if(gameOver) {
			fill(255);
			textAlign(CENTER, CENTER);
			textSize(45);
			text("YOU LOST", screenSize/2, screenSize/4);
			textSize(30);
			text("PLAY AGAIN", screenSize/2, screenSize/2);
		}
	} else {
		fill(255);
		textAlign(CENTER, CENTER);
		textSize(45);
		text("BLAST THE ASTEROIDS!", screenSize/2, screenSize/4);
		textSize(30);
		text("PLAY", screenSize/2, (screenSize*3)/4);
		hitCount = 0;
		gameOver = false;
		gameCount = 0;
	}
}

void mousePressed() {
	if(gameOver && mouseX > (screenSize/2) - 50 && mouseX < (screenSize/2) + 50 && mouseY > (screenSize/2) - 15 && mouseY < (screenSize/2) + 15) {
		start = false;
	}
	if(!start && mouseX > (screenSize/2) - 30 && mouseX < (screenSize/2) + 30 && mouseY > ((screenSize*3)/4) - 15 && mouseY < ((screenSize*3)/4) + 15) {
		start = true;
	}
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

class Bullet extends Floater {
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
	public Bullet(SpaceShip theShip) {
			myCenterX = theShip.getX();
			myCenterY = theShip.getY();
			bSize = 4;
			myPointDirection = theShip.getPointDirection();
			dRadians = myPointDirection*(Math.PI/180);
			myDirectionX = (5*Math.cos(dRadians) + theShip.getDirectionX());
			myDirectionY = (5*Math.sin(dRadians) + theShip.getDirectionY());
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
	private int rotSpeed;
	public Asteroid() {
		corners = 8;
		int[] xS = {-10,-8,-4, 3,12,15,  2, -5};
		int[] yS = {  0, 7, 8,10, 2,-8,-20,-17};
		xCorners = xS;
		yCorners = yS;
		myColor = color(139, 69,  19);
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
		spin(rotSpeed);
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
	if (key == 'h') {
		apollo.setDirectionX(0);
		apollo.setDirectionY(0);
		apollo.setPointDirection(0);
		apollo.setX(screenSize/2);
		apollo.setY(screenSize/2);
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
		apollo.spin(3);
	}
	if (goingLeft) {
		apollo.spin(-3);
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
	public void spin (int nDegreesOfRotation) {     
		//spins the floater by a given number of degrees    
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
		int xspindTranslated, yspindTranslated;
		beginShape();
		for(int nI = 0; nI < corners; nI++) {
			//spin and translate the coordinates of the floater using current direction
			xspindTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
			yspindTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
			vertex(xspindTranslated,yspindTranslated);
		}
		endShape(CLOSE);
	}
}
