# March 14 2016 14:00 SMART SOFTWARE PROJECT - NOTES

**Lab Assignment #1 - Week 2 Lab Assignment**

### Lab Assignment #1-1

* Program using Arduino IDE
* Flash front and back LED lights for one second on, one second off.
* If front LED is on, back LED is off. If front LED is off, back LED is on.

#### File : ```blink_front_and_back_led.cpp```

```cpp
#define FRONT_LED_PIN  10
#define REAR_LED_PIN  9

void setup()
{
  pinMode(FRONT_LED_PIN, OUTPUT);
  pinMode(REAR_LED_PIN, OUTPUT);
}

void loop()
{
  digitalWrite(FRONT_LED_PIN, HIGH);
  digitalWrite(REAR_LED_PIN, LOW);
  delay(1000);

  digitalWrite(FRONT_LED_PIN, LOW);
  digitalWrite(REAR_LED_PIN, HIGH);
  delay(1000);
}
```
<iframe style="height: 510px; width: 100%; margin: 10px 0 10px;" allowTransparency="true" src="https://codebender.cc/embed/sketch:300131" frameborder="0"></iframe>

### Lab Assignment #1-2

* Using Androx Studio.
* Front LED is initially OFF
* Rear LED is initially ON
* Front LED incrementally brightens for about 3 seconds then incrementally darkens for 3 seconds while rear LED does the opposite.
* ***Hint*** : Use "analogWrite()"

#### File : ```dim_fr_bk.cpp```

```cpp
// Do not remove the include below
#include "lab2.h"

#define FRONT_LED_PIN  10
#define REAR_LED_PIN  9

//The setup function is called once at startup of the sketch
void setup()
{
// Add your initialization code here
	pinMode(FRONT_LED_PIN, OUTPUT);
	  pinMode(REAR_LED_PIN, OUTPUT);
}

// The loop function is called in an endless loop
void loop()
{
//Add your repeated code here

	  int led_val = 0;
	  int led_total_time = 3 * 1000;  // 3 seconds.
	  int led_varience = 255; // max output for led.

	  analogWrite(FRONT_LED_PIN,led_val);
	  analogWrite(REAR_LED_PIN,led_varience - led_val);

	  for (int i = 0; i < led_varience; i++) {
	    led_val = i;
	    analogWrite(FRONT_LED_PIN,led_val);
	    analogWrite(REAR_LED_PIN,led_varience - led_val);
	    delay(led_total_time/led_varience);
	  }

	  for (int i = led_varience; i > 0; i--) {
	    led_val = i;
	    analogWrite(FRONT_LED_PIN,led_val);
	    analogWrite(REAR_LED_PIN,led_varience - led_val);
	    delay(led_total_time/led_varience);
	  }
}
```

<iframe style="height: 510px; width: 100%; margin: 10px 0 10px;" allowTransparency="true" src="https://codebender.cc/embed/sketch:300132" frameborder="0"></iframe>

##### Links to Code:

* [Week 2 Lab 1 Part 1](https://codebender.cc/sketch:300131)
* [Week 2 Lab 1 Part 2](https://codebender.cc/sketch:300132)


***Happy Coding!***

