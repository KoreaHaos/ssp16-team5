#include "lab11.h"

MPU6050 mpu;

uint8_t mpuIntStatus; // holds actual interrupt status byte from MPU
uint8_t devStatus; // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize; // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount; // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

Quaternion q; // [w, x, y, z] quaternion container
VectorFloat gravity; // [x, y, z] gravity vector
float ypr[3]; // [yaw, pitch, roll] yaw/pitch/roll container and gravity vector

void setup()
{
    Wire.begin();
    
    Serial.begin(115200);
    
    Serial.println("Initializing I2C devices…");
    mpu.initialize();
    
    Serial.println("Testing device connections…");
    Serial.println(mpu.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");
    
    Serial.println("Initializing DMP…");
    devStatus = mpu.dmpInitialize();
    
    if (devStatus == 0) {
        
        Serial.println("Enabling DMP…");
        mpu.setDMPEnabled(true);
        
        packetSize = mpu.dmpGetFIFOPacketSize();
    }
    else
    {
        Serial.print("DMP Initialization failed (code ");
        Serial.print(devStatus);
        Serial.println(")");
    }
}
void loop()
{
}
void gyro_accel_read()
{
    while(1)
    {
        mpu.resetFIFO();
        mpuIntStatus = mpu.getIntStatus();
        fifoCount = mpu.getFIFOCount();
        if(mpuIntStatus & 0x02)
        {
            while(fifoCount < packetSize)
            fifoCount = mpu.getFIFOCount();
            mpu.getFIFOBytes(fifoBuffer, packetSize);
            fifoCount -= packetSize;
            mpu.dmpGetQuaternion(&q, fifoBuffer);
            mpu.dmpGetGravity(&gravity, &q);
            mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
            break;
        }
    }
    Serial.print(" yaw : ");
    Serial.print(180 - (ypr[0] * 180/M_PI)); //yaw
    Serial.print(" pitch : ");
    Serial.print(ypr[1] * 180/M_PI); // pitch
    Serial.print(" roll : ");
    Serial.println(ypr[2] * 180/M_PI); //roll
}

void serialEvent()
{
    int command = Serial.read();
    
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
	       //buzz_signal_recieved();
	       ultrasonic_sensor_read();
	       break;
        case 11:
	       buzz_signal_recieved();
	       //infrared_sensor_read();
	       break;
        case 12:
	       turn_buzzer_on();
	       break;
        case 13:
	       turn_buzzer_off();
	       break;
        case 14:
            gyro_accel_read();
            break;
        default:
			move_stop();
			front_led_control(false);
			rear_led_control(false);
			break;
    }
}