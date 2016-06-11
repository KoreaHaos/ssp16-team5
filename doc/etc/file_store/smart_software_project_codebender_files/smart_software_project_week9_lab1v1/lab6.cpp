#include  "lab6.h"

unsigned char text[] = "\n Welcome! Arduino Mega\n Ultrasonic Sensors Test Program.\n";

void serialEvent()
{
    int command = Serial.read();
    
    //buzz_signal_recieved();

    switch (command)
    {
        case 1:
	        move_stop();
	        delay(500);
	        move_forward();
	        break;
        case 2:
	        move_stop();
	        delay(500);
	        turn_left();
	        break;
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
	        break;
        case 6:
	        front_led_control(true);
        	break;
        case 7:
	        front_led_control(false);
	        break;
        case 8:
	        rear_led_control(true);
	        break;
        case 9:
	       rear_led_control(false);
	       break;
        case 10:
	       //ultrasonic_sensor_read();
	       //buzz_signal_recieved();
	       //buzz_a_test();
	       //buzz_a_test();
	       break;
        case 11:
	       //infrared_sensor_read();
	       //buzz_signal_recieved();
	       break;
        case 12:
	       turn_buzzer_on();
	       break;
        case 13:
	       turn_buzzer_off();
	       break;
	       
        default:
			move_stop();
			front_led_control(false);
			rear_led_control(false);
			break;
    }
}


//#define NUM_TX_BYTES 5
//#define NUM_RX_BYTES 17

//unsigned char TX_buf[NUM_TX_BYTES] = {0x76, 0x00, 0xF0, 0x00, 0xF0};
//unsigned char TX_stop_buf[NUM_TX_BYTES] = {0x76, 0x00, 0x0F, 0x00, 0x0F};
//unsigned char RX_buf[NUM_RX_BYTES];


//#define  FRONT_LED_PIN 10
//#define REAR_LED_PIN  9

//#define S_DIN 42
//#define S_SCLK 43
//#define S_SYNCN 44
//#define IN_SEN_EN 26

//int SensorA[8] = {A0,A1,A2,A3,A4,A5,A6,A7};
//int SensorD[8] = {30,31,32,33,34,35,36,37};



// boolean ultrasonic_result = false;

/*
void ultrasonic_sensor_read()
{
	ultrasonic_result = false;
	Serial1.write(TX_buf, NUM_TX_BYTES);
}
*/

/*
void infrared_sensor_read()
{
	int z;
	
	for(z = 7; z >= 0; z--)
	{
		unsigned int val = analogRead(SensorA[z]);
		Serial.print(val);
		Serial.print(" ");
	}
	
	*/
	/*
	for(z=7;z>=0;z--)
	{
		unsigned int val = digitalRead(SensorD[z]);
		Serial.print(val);
		Serial.print(" ");
	}
	
	Serial.println("");
}
*/

void setup()
{
	setup_buzzer_pin();
	setup_ports_for_movement();
	setup_led_pins();
	
	Serial.begin(115200);
	
	int i = 0;
	while (text[i] != '\0')
		Serial.write(text[i++]);
	
	Serial.write("Received cmds: ");
	buzz_ready();
	
	//int z;
	
	//int dac_val_min[8] = {59,94,81,79,166,104,108,77};
	//int dac_val_max[8] = {443,627,678,603,957,761,797,559};
	
	//Serial1.begin(115200);
	
	
	//pinMode(IN_SEN_EN,OUTPUT);
	//pinMode(S_DIN,OUTPUT);
	//pinMode(S_SCLK,OUTPUT);
	//pinMode(S_SYNCN,OUTPUT);
	
	//pinMode(45, OUTPUT);
	
	//digitalWrite(S_SCLK,LOW);
	//digitalWrite(S_SYNCN,HIGH);
	//digitalWrite(IN_SEN_EN,HIGH);

	/*
	for (z=0; z<8; z++)
		pinMode(SensorD[z], INPUT);
	
	DAC_setting(0x9000); //for Write-Through Mode
	
	for (z=0; z<8; z++)
	{
		int mean_val = (dac_val_min[z]+dac_val_max[z])/2; //10-bit
		DAC_CH_Write(z, mean_val >> 2); //should be 8-bit
	}
	*/
	
}

void loop()
{
}

/*

void serialEvent1()
{
	unsigned char z, tmp = 0;
	
	Serial1.readBytes((char *)RX_buf, NUM_RX_BYTES);
	
	if ( (RX_buf[0] == 0x76) && (RX_buf[1] == 0x00) && (ultrasonic_result == false) )
	{
		for (z = 2; z < NUM_RX_BYTES-1; z++)
			tmp += RX_buf[z];
		
		tmp = tmp & 0xFF;
		
		if (RX_buf[NUM_RX_BYTES-1] == tmp)
		{
			Serial.println("FRONT");
			
			for (z=4; z < 11; z++)
			{
				Serial.print(" F");
				Serial.print(z-4);
				Serial.print(": ");
				Serial.print(RX_buf[z]);
			}
			
			Serial.println("\nBACK");
	
			for (z=11; z < NUM_RX_BYTES-1; z++)
			{
				Serial.print(" B");
				Serial.print(z-11);
				Serial.print(": ");
				Serial.print(RX_buf[z]);
			}
		}
		
		ultrasonic_result = true;
		
		Serial1.write(TX_stop_buf, NUM_TX_BYTES);
	}
}

*/