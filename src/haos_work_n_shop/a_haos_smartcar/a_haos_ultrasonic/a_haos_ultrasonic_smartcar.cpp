#include "a_haos_ultrasonic_smartcar.h"

//int infrareds_readings[8];
int ultrasonc_readings[12];

unsigned long millis_since_start;

void setup() {
	
	setup_smart_car_control_logic();
	setup_buzzer_pin();
	setup_led_pins();
	initialize_infrared_sensor_pack();
	setup_ultrasonic();
	startup_movement();
	
	buzz_ready();
}


void loop() {
	 //millis_since_start = millis();
	 //infrareds_readings =
	 ultrasonc_readings =
}




