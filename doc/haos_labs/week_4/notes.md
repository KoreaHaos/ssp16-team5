# March 28 2016 14:00 SMART SOFTWARE PROJECT - NOTES

**Lab Assignment #3 - Week 4 Lab Assignment**

### The Task!

* Move forward for 2 seconds.
* Stop for 0.5s.
* Turn right for 1.5s.
* Stop for 0.5s.
* Turn left for 1.5s.
* Stop for 0.5s.
* Move backward for 2 seconds.
* Stop forever!

    * Upload ```lab3.h``` and ```lab3.cpp``` file to Cyber Campus

### The Code!

#### File ```lab3.h```

```cpp

```

#### File ```lab3.cpp```

```cpp

#define LEFT_MD_A 22
#define LEFT_MD_B 23

#define RIGHT_MD_A 24
#define RIGHT_MD_B 25

#define LEFT_MOTOR_EN 4
#define RIGHT_MOTOR_EN 5

int init_done = false;

//The setup function is called once at startup of the sketch

void setup()
{
    // Initialization code.
    pinMode(LEFT_MD_A, OUTPUT);
    pinMode(LEFT_MD_B, OUTPUT);
    pinMode(RIGHT_MD_A, OUTPUT);
    pinMode(RIGHT_MD_B, OUTPUT);
    pinMode(LEFT_MOTOR_EN, OUTPUT);
    pinMode(RIGHT_MOTOR_EN, OUTPUT);
    
    digitalWrite(LEFT_MD_A, LOW);
    digitalWrite(LEFT_MD_B, LOW);
    digitalWrite(RIGHT_MD_A, LOW);
    digitalWrite(RIGHT_MD_B, LOW);
    digitalWrite(LEFT_MOTOR_EN, LOW);
    digitalWrite(RIGHT_MOTOR_EN, LOW);
}

void move_forward()
{
    //Rotate counterclockwise for left motor
    digitalWrite(LEFT_MD_A, HIGH);
    digitalWrite(LEFT_MD_B, LOW);
    
    //Rotate clockwise for right motor
    digitalWrite(RIGHT_MD_A, LOW);
    digitalWrite(RIGHT_MD_B, HIGH);
    
    //Now turn left and right motors ON!
    analogWrite(LEFT_MOTOR_EN, 100);
    analogWrite(RIGHT_MOTOR_EN, 100);
}

void move_backward()
{
    //Rotate clockwise for left motor
    digitalWrite(LEFT_MD_A, LOW);
    digitalWrite(LEFT_MD_B, HIGH);
    
    //Rotate counterclockwise for right motor
    digitalWrite(RIGHT_MD_A, HIGH);
    digitalWrite(RIGHT_MD_B, LOW);
    
    //Now turn left and right motors ON!
    analogWrite(LEFT_MOTOR_EN, 100);
    analogWrite(RIGHT_MOTOR_EN, 100);
}

void turn_left() { //Rotate clockwise for right motor
    
    digitalWrite(RIGHT_MD_A, LOW);
    digitalWrite(RIGHT_MD_B, HIGH);
    
    analogWrite(LEFT_MOTOR_EN, 0);
    analogWrite(RIGHT_MOTOR_EN, 150);
}

void turn_right() { //Rotate counterclockwise for left motor
    
    digitalWrite(LEFT_MD_A, HIGH);
    digitalWrite(LEFT_MD_B, LOW);
    
    analogWrite(LEFT_MOTOR_EN, 150);
    analogWrite(RIGHT_MOTOR_EN, 0);
}

void move_stop() {
    analogWrite(LEFT_MOTOR_EN, 0);
    analogWrite(RIGHT_MOTOR_EN, 0);
}

void loop() {
    
    if (init_done == false)
    {
        move_forward();
        delay(2000);
        
        move_stop();
        delay(500);
        
        turn_right();
        delay(1500);
        
        move_stop();
        delay(500);
        
        turn_left();
        delay(1500);
        
        move_stop();
        delay(500);
        
        move_backward();
        delay(2000);
        
        init_done = true;
    }
    else
    {
        move_stop();
    }
}
```

