//import ddf.minim.*;

//Minim minim;
//AudioPlayer backgroundPlayer;
//AudioPlayer clashPlayer;

Basket basket;
Fruit[] fruits = new Fruit[7];
int Score= 0;
Timer timer;
String[] imgNames = new String[]{"apple.jpg","banana.jpg","strawberry.jpg","orange.jpg","grape.jpg","watermelon.jpg","redapple.png"};
String gameTitle = "Welcome to Fruit Catching Game";
String gameInstruction = "Use Arrow keys to move fruit basket";
Boolean isGameOver = false;
 
void setup() { 
 size(600,400); 
 smooth();
  
 basket = new Basket("basket.jpg",50,100,1);
  
 for (int i = 0; i < fruits.length; i++ ) { 
   fruits[i] = new Fruit(imgNames[i]); 
  }
 
  //minim = new Minim(this);

  //backgroundPlayer = minim.loadFile("FruitSong.mp3");
  //backgroundPlayer.play(); // play the file
 
  //clashPlayer = minim.loadFile("Clash.mp3");
 
  timer = new Timer(1000); // Create a timer that goes off every 2 seconds 
  timer.start();
   
} 

void draw() { 
  background(255);
  DisplayTitle();
  
  if (isGameOver )
  {
     //println ("Finish Game");
    FinishGame();
    /*if(mousePressed){
      //if(mouseButton == LEFT )  basket.y += 2;
      if(mouseButton == CENTER){
         println ("mouse center");
          isGameOver = false;
          //StartGame();
      }
      //if(mouseButton == RIGHT)  basket.y -= 2;
    }*/
    /*if(keyPressed){
      if(keyCode == 32){
         background(51);
         println ("Key Space" + timer.savedTime);
          isGameOver = false;
          
         
      }
    } */      
  }
  else {
    println ("Start Game");
    StartGame();
  }
  //loop();
} 

void DisplayScore()
{
 String scoreText = "Your Score : " +  (Score);
 fill(255, 0, 0);
 textAlign(RIGHT);
 textSize(15);
 text(scoreText, 400, 10, 150, 100); 
}

void DisplayTitle()
{
 fill(50);
 textAlign(CENTER);
 textSize(20);
 text(gameTitle, 10, 10, 500, 200);
 textSize(12);
 text(gameInstruction, 10, 40, 500, 200);
}

void FinishGame()
{
  textSize(20);
  textAlign(CENTER);
  fill(0, 0, 255);
  text("Game is Over. You have " +  Score + " fruits in your basket. Enjoy!!!", 10, height/2, 500, 200);
   
}

void StartGame()
{
  if(keyPressed ){
    if(keyCode == UP) basket.y -= 2;
    if(keyCode == DOWN) basket.y += 2;
    if(keyCode == LEFT) basket.x -= 2;
    if(keyCode == RIGHT) basket.x += 2;
  }
    
 basket.move(); 
 basket.display();
   
 // Check the timer
  if (timer.isFinished()) {
      // Initialize Fruits
     for (int i = 0; i < fruits.length; i++ ) { 
       fruits[i] = new Fruit(imgNames[i]); 
      }
     timer.start();
  }
  
   // Move and display all fruitcImages
  for (int i = 0; i < fruits.length; i++ ) {
      fruits[i].move();
      fruits[i].display();
   
      if (basket.intersect(fruits[i])) {
        //clashPlayer.play(); // play the file
        fruits[i].caught();
        Score++;
        
      }
   }
   DisplayScore();
   
   /*if (!backgroundPlayer.isPlaying())
   {
     isGameOver = true;
   }*/
}

class Basket { 
 PImage img; 
 float x; 
 float y; 
 float xspeed;
 String imageName; 

 
 Basket(String imageName_, float x_, float y_, float xspeed_) { 
   imageName = imageName_; 
   x = x_; 
   y = y_; 
   xspeed = xspeed_; 
   img = loadImage(imageName);
 } 
 
  void display() { 
    //Draw Basket
    stroke(255); 
    fill(100,50); 
    image(img,x,y);
  } 
 
  void move() { 
   x = x + xspeed; 
   if ((x > width) || (x < 0)) { 
     x = 0; 
   } 
   if ((y > height)  || (y < 0)) { 
    y = 0; 
   } 
 } 
 
 // A function that returns true or false based if the catcher intersects a raindrop 
 boolean intersect(Fruit f) { 
    // Calculate distance
     float distance = dist(x,y,f.x,f.y);
     //println(distance);
     
     // Compare distance to  radii
     if (distance < 80) { 
       return true; 
     } else { 
       return false; 
     } 
   }
 
}

class Fruit { 
 String imageName; // Image Name 
 float x,y; // location 
 float speed; // speed 
 PImage img;

 // Constructor 
 Fruit( String _imageName) { 
  x = random(width); 
  speed = random( 1,5);
  imageName = _imageName;
  img = loadImage(imageName);
 } 

 void move() { 
   y += speed; // Increment y 
    //Check vertical edges 
  if (y > height || y < 0) { 
     y = 0; 
   } 
 } 
 
 // Draw the FruitImage 
 void display() { 
  stroke(255); 
  fill(100,50); 
  image(img,x,y); 
  } 
  
  void caught() {
      speed = 0; // Stop it from moving by setting speed equal to zero
      // Set the location to somewhere way off-screen
      x = -1000;
      y = -1000;
    }
 } 

class Timer { 
  int savedTime; // When Timer started 
  int totalTime; // How long Timer should last
  
  Timer(int tempTotalTime) { 
   totalTime = tempTotalTime; 
  } 

  // Starting the timer 
  void start() { 
    savedTime = millis(); 
   } 
    
   boolean isFinished() { 
    // Check out much time has passed 
    int passedTime = millis()- savedTime; 
    if (passedTime > totalTime) { 
      return true; 
     } else { 
      return false; 
     } 
   } 
 } 
