slide 13

This code switches the LED every one seconds
```cpp
#include <Timer2.h>
#define FRONT_LED 10
int LED_state = 0;
void Timer2_ISR() {
    digitalWrite(FRONT_LED, LED_state);
    if (LED_state)
    LED_state = 0;
    else
    LED_state = 1;
}
void setup() {
    pinMode(FRONT_LED, OUTPUT);
    Timer2::set(1000000, Timer2_ISR);
    Timer2::start();
}
void loop() {
}
```

This works but is not a good way to do things...

```cpp

#define FRONT_LED 10
int LED_state = 0;
void setup() {
    pinMode(FRONT_LED, OUTPUT);
}
void loop() {
    digitalWrite(FRONT_LED, LED_state);
    delay(1000);
    if (LED_state)
    LED_state = 0;
    else
    LED_state = 1;
}

```
This is the prefered method.

```cpp

#include <Timer2.h>
#define FRONT_LED 10
int LED_state = 0;
void Timer2_ISR() {
    digitalWrite(FRONT_LED, LED_state);
    if (LED_state)
    LED_state = 0;
    else
    LED_state = 1;
}
void setup() {
    pinMode(FRONT_LED, OUTPUT);
    Timer2::set(1000000, Timer2_ISR);
    Timer2::start();
}
void loop() {
}

```

*slides 17 - 19*

### MIT App Inventor 2!

* Uses visual elements to make app creation possible by non-programers.

[MIT App Inventor 2](http://appinventor.mit.edu/explore/)

[Install App Inventor 2](http://appinventor.mit.edu/explore/ai2/setup.html)

* Uses a cloud IDE and an Android app to make it easy to quickly produce apps.
* Requires GMail and Android device to use fully.
* Has a Android emulator to Prototype.
* 

*slides 20*

* Showcases visualization of app!


*slides 22*

Utilized to teach non-computer-science majors.

*slides 23*

* No syntax...

*slides x*

#define MY_PIN 13


int state = LOW;
void setup(){
    pinMode(MY_PIN, OUTPUT);
    attachInterrupt(0, blink, CHANGE);
}

void loop() {
    digitalWrite(MY_PIN, state);
}
void blink() {
    state = !state;
}


void loop() {
    if
    (Serial.available() > 0)
    {
        int command = Serial.read();
        Serial.print(command, DEC);
        Serial.print(" ");
        switch (command) {
            case 1:
            move_stop();
            delay(500);
            move_forward();
            break;
            case 2:
            move_stop();
            delay(500);
            turn_left();
            break
            ;
            case 3:
            move_stop();
            delay(500);
            turn_right();
            break;
            case 4:
            move_stop();
            delay(500);
            move_backward();
            break;
            case 5:
            move_stop();
            break
            ;
            case 6:
            front_led_control
            (true);
            break
            ;
            case 7:
            front_led_control
            (false);
            break;
            case 8:
            rear_led_control
            (true);
            break;
            case 9:
            rear_led_control
            (false);
            break;
            default
            :
            move_stop();
            front_led_control
            (false);
            rear_led_control
            (false);
        }
    }
}

*slides x*





