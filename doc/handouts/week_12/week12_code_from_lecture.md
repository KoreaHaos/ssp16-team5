Accelgyro_sensor.h

```cpp
#ifndef Accelgyro_sensor_H_
#define Accelgyro_sensor_H_
#include "Arduino.h"

#include "Wire.h"
#include "I2Cdev.h"
#include "MPU6050.h"

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

Accelgyro_sensor.cpp

```cpp
#include "Accelgyro_sensor.h"

MPU6050 accelgyro;

int16_t ax, ay, az;
int16_t gx, gy, gz;

void setup()
{
    Wire.begin();
    Serial.begin(115200);
    Serial.println("Initializing I2C devices...r");
    accelgyro.initialize();
    
    Serial.println("Testing device connections...r");
    Serial.println(accelgyro.testConnection() ? "MPU6050 connection successfulr" : "MPU6050 connection failedr");
}

void loop()
{
    
    accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
    
    Serial.print("Accel : ");
    Serial.print(ax);
    Serial.print(" ");
    Serial.print(ay);
    Serial.print(" ");
    Serial.print(az);
    Serial.print(" Gyro : ");
    Serial.print(gx);
    Serial.print(" ");
    Serial.print(gy);
    Serial.print(" ");
    Serial.println(gz);
    delay(200);
}
```

Accelgyro_angle.h
```cpp
#ifndef Accelgyro_angle_H_
#define Accelgyro_angle_H_
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

Accelgyro_angle.cpp
```cpp
#include "Accelgyro_angle.h"

MPU6050 mpu;

uint8_t mpuIntStatus; // holds actual interrupt status byte from MPU
uint8_t devStatus; // return status after each device operation (0
= success, !0 = error)
uint16_t packetSize; // expected DMP packet size (default is 42
bytes)
uint16_t fifoCount; // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

Quaternion q; // [w, x, y, z] quaternion container
VectorFloat gravity; // [x, y, z] gravity vector
float ypr[3]; // [yaw, pitch, roll] yaw/pitch/roll
container and gravity vector

void setup()
{
    Wire.begin();
    
    Serial.begin(115200);
    
    Serial.println(F("Initializing I2C devices..."));
    mpu.initialize();
    
    Serial.println(F("Testing device connections..."));
    Serial.println(mpu.testConnection() ? F("MPU6050 connection
    successful") : F("MPU6050 connection failed"));
    
    Serial.println(F("Initializing DMP..."));
    devStatus = mpu.dmpInitialize();
    
    if (devStatus == 0) {
        
        Serial.println(F("Enabling DMP..."));
        mpu.setDMPEnabled(true);
        
        packetSize = mpu.dmpGetFIFOPacketSize();
    }
    else
    {
        Serial.print(F("DMP Initialization failed (code "));
        Serial.print(devStatus);
        Serial.println(F(")"));
    }
}

void loop()
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
    delay(200);
}
```

– Compass_sensor.h

```cpp
#ifndef Compass_sensor_H_
#define Compass_sensor_H_
#include "Arduino.h"

#include "Wire.h"
#include "I2Cdev.h"
#include "MPU6050.h"
#include "AK8975.h"

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

– Compass_sensor.cpp

```cpp
#include "Compass_sensor.h"

AK8975 Compass(0x0C);
MPU6050 accelgyro;

int16_t mx, my, mz;

void setup()
{
    Wire.begin();
    
    Serial.begin(115200);
    
    Serial.println("Initializing I2C devices...");
    
    accelgyro.initialize();
    accelgyro.setI2CBypassEnabled(true);
    Compass.initialize();
    
    Serial.println("Testing device connections...");
    Serial.println(Compass.testConnection() ? "AK8975 connection
    successful" : "AK8975 connection failed");
}

void loop()
{
    Compass.getHeading(&mx, &my, &mz);
    Serial.print(" Compass : ");
    Serial.print(mx);
    Serial.print(" ");
    Serial.print(my);
    Serial.print(" ");
    Serial.println(mz);
    delay(200);
}
```
