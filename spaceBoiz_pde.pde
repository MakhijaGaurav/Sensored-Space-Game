int points, i,j, arduinoInputBefore,arduinoInput;
float Pixeldist,Yaxis,Angle;
float FuelX,FuelY;
String arduino;
float[] AsteroidX = new float[6];
float[] AsteroidY = new float[6];

PImage bg, obstruction, shuttle, fuel;

import processing.serial.*;
Serial arduinoPort;

void setup(){
  arduinoPort = new Serial(this, Serial.list()[0], 9600);
  arduinoPort.bufferUntil(10);
  frameRate(30);
  size(800, 600);
  rectMode(CORNERS);
  noCursor();
  Yaxis = 300;
 
  bg = loadImage("background.jpg");
  obstruction = loadImage("asteroid.png");
  shuttle = loadImage("shuttle.png");
  fuel = loadImage("fuel.png");
 
 
 for(int i = 0 ; i<= 5; i++){
   AsteroidX[i] = random(1000);
   AsteroidY[i] = random(400);
   }
 
 
}



void serialEvent(Serial s){
  arduino = s.readString();
  arduinoInputBefore = int(trim(arduino));
  if(arduinoInputBefore >1 && arduinoInputBefore < 100){
    arduinoInput = arduinoInputBefore;
  }  
}

void draw(){
  background(bg);
  Pixeldist = sqrt(pow((400-FuelX),2) + pow((Yaxis - FuelY),2));
  if(Pixeldist < 40){
    points++;
    FuelX = 900;
    FuelY = random(600);
  }
  text("Score => ",200,30);
  text(points , 250 ,30);
  
  //Angle = mouseY-300;
  Angle = (18 - arduinoInput)*4;
  Yaxis += sin(radians(Angle))*10;
  
  if(Yaxis < 0){ Yaxis = 0; }
  if(Yaxis > 600){ Yaxis = 600; }
  
  Manufacture(Yaxis,Angle);
  
  FuelX = FuelX - cos(radians(Angle))*10; 
  
  if(FuelX < -30){
    FuelX = 900;
    FuelY = random(600);
   }
   
  for(int i = 1; i <=5; i++){
    AsteroidX[i] = AsteroidX[i] - cos(radians(Angle))*(10+2*i);
    image(obstruction,AsteroidX[i],AsteroidY[i],300,200);
    if(AsteroidX[i] < -300){
      AsteroidX[i] = 1000;
      AsteroidY[i] = random(400);
    }
  }
  
  image(fuel ,FuelX,FuelY,59,38); 
}

void Manufacture(float y, float ang){
 noStroke();
 pushMatrix();
 translate(400, y);
 rotate(radians(ang));
 scale(0.5);
 image(shuttle, -111, -55,223,110);
 popMatrix();
}
  
 
 