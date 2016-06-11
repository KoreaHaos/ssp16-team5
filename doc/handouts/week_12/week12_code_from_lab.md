
```cpp
#ifndef lab11_H_
#define lab11_H_
#include "Arduino.h"

#include "Wire.h"
#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps20.h"

#ifdef __cplusplus
extern "C" {
    #endif
    void loop();
    void setup();
    #ifdef __cplusplus
}
#endif

#endif
```

```cpp
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
        //...
        //...
        case 14:
        gyro_accel_read();
        break;
        
        default:
    }
}
```

