#define echo 13
#define trig 11
int max = 200, min =0;
long distance, pulseTime;

void setup() {
  Serial.begin(9600);
  pinMode(7, INPUT);
  pinMode(8, OUTPUT);
  pinMode(11, OUTPUT);
}

void loop() {
  digitalWrite(trig, LOW);
  delayMicroseconds(2);

  digitalWrite(trig, HIGH);
  delayMicroseconds(10);

  digitalWrite(trig, LOW);
  pulseTime = pulseIn(echo, HIGH);

  distance = pulseTime/58.2;

  if(distance >= max || distance <= min ){
    digitalWrite(11, HIGH);
    Serial.println("oops");
  }else{
    digitalWrite(11, LOW);
    Serial.println(distance);
  }
  
}
