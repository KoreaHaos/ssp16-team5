```
.____     ___________________________________ ________________________
|    |    \_   _____/\_   ___ \__    ___/    |   \______   \_   _____/
|    |     |    __)_ /    \  \/ |    |  |    |   /|       _/|    __)_ 
|    |___  |        \\     \____|    |  |    |  / |    |   \|        \
|_______ \/_______  / \______  /|____|  |______/  |____|_  /_______  /
        \/        \/         \/                          \/        \/ 
```

Smart Software Project
Lecture: Week 12
Gyro, Accelerometer
& Compass Sensors
Prof. HyungJune Lee
hyungjune.lee@ewha.ac.kr
Today
• Review from the last lecture
– Infrared sensors
– Line tracing
• SmartCAR Gyro + Accelerometer sensors
• SmartCAR Compass sensor
• Announcement

*SLIDE 2*

• iPad will sometimes be used to provide students with dynamic education environments.
• This course will be offered in English.
7 Tentative Class Schedule
Week Lecture Contents Lab Contents
Week 1 Course introduction Arduino introduction: platform &
programming environment
Week 2 Embedded system overview & source management in
collaborative repository (using GitHub)
Lab 1: Arduino Mega 2560 board &
SmartCAR platform
Week 3 ATmega2560 Micro-controller (MCU): architecture & I/O
ports, Analog vs. Digital, Pulse Width Modulation
Lab 2: SmartCAR LED control
Week 4 Analog vs. Digital & Pulse Width Modulation Lab 3: SmartCAR motor control
(Due: HW on creating project repository
using GitHub)
Week 5 ATmega2560 MCU: memory, I/O ports, UART Lab 4: SmartCAR control via Android
Bluetooth
Week 6 ATmega2560 UART control & Bluetooth communication
between Arduino platform and Android device
Lab 5: SmartCAR control through your
own customized Android app
(Due: Project proposal)
Week 7 Midterm exam
Week 8 ATmega2560 Timer, Interrupts & Ultrasonic sensors Lab 6: SmartCAR ultrasonic sensing
Week 9 Infrared sensors & Buzzer Lab 7: SmartCAR infrared sensing
Week 10 Acquiring location information from Android device & line
tracing
Lab 8: Implementation of line tracer
Week 11 Gyroscope, accelerometer, and compass sensors Lab 9: Using gyroscope,
accelerometer, and compass sensors
Week 12 Project Team meeting (for progress check)
Week 13 Project Team meeting (for progress check)
Week 14 Course wrap-up & next steps
Week 15 Project presentation & demo I
(Due: source code, presentation slides, & poster slide)
Project presentation & demo II
Week 16 Final week (no final exam)
3
Class Schedule

*Slide 3*

June 13 
Today
• Review from the last lecture
– Infrared sensors
– Line tracing
• SmartCAR Gyro + Accelerometer sensors
• SmartCAR Compass sensor
• Announcement

*Slide 4*

Line Tracer
*Slide 5
• Line tracing in SmartCAR
– Infrared sensor data depending on SmartCAR’s position
(a) Forward (b) Smooth Right-turn (c) Smooth Left-turn
(d) Pivot Right-turn (e) Pivot Left-turn
Sensor Data

*Slide 6*

```cpp
SensorD[0] SensorD[7]
SensorD[7] SensorD[6] SensorD[5] SensorD[4] SensorD[3] SensorD[2] SensorD[1] SensorD[0]
//…
//…
unsigned char sensor_data = 0;
int z;
for(z=0;z<8;z++)
{
unsigned int val = digitalRead(SensorD[z]);
sensor_data |= (val << z);
}
```

To track black line in white background,
- we should complement the sensor_data (‘1’ to ‘0’, ‘0’ to ‘1’)
sensor_data = ~sensor_data;
Control Motors w.r.t. Infrared Sensor
7
• How to control motors w.r.t. sensor_data
Sensor_data Direction Speed_data_L Speed_data_R Etc
0x18
FORWARD 140 140 Forward
0x10
0x08
0x38
0x1C
0x3C
0x0C
RIGHT 200 0 Smooth Right Turn
0x04
0x06
0x0E
0x1E
0x0F
0x30
LEFT 0 200 Smooth Left Turn
0x20
0x60
0x70
0x78
0xF0
0x07
PIVOT_RIGHT 200 80 Pivot Right Turn 0x03
0x02
0x01
0xC0
PIVOT_LEFT 80 200 Pivot Left Turn 0x40
0x80
0xE0
0x00 STOP 0 0 Stop
Today
• Review from the last lecture
– Infrared sensors
– Line tracing
• SmartCAR Gyro + Accelerometer
• SmartCAR Compass sensor
• Announcement
*SLIDE 8*
3 axes Accelerometer + 3 axes Gyro



*SLIDE 9*

* 6 axes
    * from 3 axes accelerometer
        * Measure proper acceleration in three axes
    * from 3 axes gyroscope
        * Measure orientation, based on the principles of angular momentum

*SLIDE 10*

* InvenSense MPU-6050:
    * Gyro 3 axis
    * Accelerometer 3 axis sensors
* Data transmission type to Atmega MCU
• I^2C(Inter-Integrated Circuit) interface

– MPU-6050 Block diagram
Sensor Sensitivity

*SLIDE 11*

*  Accelerometer
    * Sensitivity

*Gyroscope
    * Sensitivity

* Basic setting:
    * ±2g for accelerometer
    * ±250 º/sec for gyroscope

|--|--|--|--|
| Full-Scale Range | AFS_FEL | Sensitivity Scale Factor | Etc |
| ±2 g | 0 | 16384 LSB/g | | 
| ±4 g | 1 | 8192 | LSB/g | |
| ±8 g | 2 | 4096 | LSB/g | |
| ±16 g | 3 | 2048 | LSB/g | |

Full-Scale Range FS_FEL Sensitivity Scale Factor Etc
±250 º/sec 0 131 LSB/(º/sec)
±500 º/sec 1 65.5 LSB/(º/sec)
±1000 º/sec 2 32.8 LSB/(º/sec)
±2000 º/sec 3 16.4 LSB/(º/sec)

*SLIDE 12*

Port Configuration for 6 axes Sensor

Chip Name Port / Number Etc
MPU-6050
SDA PD1 / 20
SCL PD0 / 21
Sample Program

*SLIDE 13*

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



*Slide 16*

Code Explanation

• Header file
– Include several header files
• Include Wire.h and I2Cdev.h to use I2C hardware interface
• Include MPU6050.h to use MPU6050
• Main program
– Global variable declaration
• ax, ay, az: variables for accelerometer values
• gx, gy, gz: variables for gyroscope values
– I2C interface initialization
• Set up to 50KHz and enable it

```cpp
005: #include "Wire.h"
006: #include "I2Cdev.h"
007: #include "MPU6050.h"
005: int16_t ax, ay, az;
006: int16_t gx, gy, gz;
010: Wire.begin();
```

*Slide 17*

Code Explanation

– Sensor initialization
• Clock: call setClockSource()
• Gyro sensitivity: call setFullScaleGyroRange()
• Accelerometer sensitivity: call
setFullScaleAccelRange()
• Sleep mode off: call setSleepEnabled()
013: accelgyro.initialize();
setClockSource(MPU6050_CLOCK_PLL_XGYRO);
setFullScaleGyroRange(MPU6050_GYRO_FS_250);
setFullScaleAccelRange(MPU6050_ACCEL_FS_2);
setSleepEnabled(false);
Code Explanation

*Slide 18*

– Serial.println() function
• Check whether the MPU 6050 connection is successful
– Accelgyro.getMotion6() function
• Read 6 values from accelerometer and gyroscope via I2C interface
• I2Cdev::readBytes(devAddr, MPU6050_RA_ACCEL_XOUT_H, 14, buffer)

016: Serial.println(accelgyro.testConnection() ? "MPU6050 connection
successful\r" : "MPU6050 connection failed\r");
return getDeviceID() == 0x34;
022: accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
void MPU6050::getMotion6(int16_t* ax, int16_t* ay, int16_t* az, int16_t* gx,
int16_t* gy, int16_t* gz) {
I2Cdev::readBytes(devAddr, MPU6050_RA_ACCEL_XOUT_H, 14, buffer);
*ax = (((int16_t)buffer[0]) << 8) | buffer[1];
*ay = (((int16_t)buffer[2]) << 8) | buffer[3];
*az = (((int16_t)buffer[4]) << 8) | buffer[5];
*gx = (((int16_t)buffer[8]) << 8) | buffer[9];
*gy = (((int16_t)buffer[10]) << 8) | buffer[11];
*gz = (((int16_t)buffer[12]) << 8) | buffer[13];
}
Code Explanation

*Slide 19*

– Read data values and send them to
bluetooth
024: Serial.print("Accel : ");
025: Serial.print(ax);
026: Serial.print(" ");
027: Serial.print(ay);
028: Serial.print(" ");
029: Serial.print(az);
030: Serial.print(" Gyro : ");
031: Serial.print(gx);
032: Serial.print(" ");
033: Serial.print(gy);
034: Serial.print(" ");
035: Serial.println(gz);

Yaw, pitch, and roll calculation

• Let’s have the followings from 6 axes measurements

– Yaw: rotation in z-axis
– Pitch: rotation in y-axis
– Roll: rotation in x-axis

*Slide 20*

Sample Program

*Slide 21*

### Sample Program

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
*Slide 22-24*

### Sample Program

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

Code Explanation

*Slide 25*

• Header file
– Include a header file
• Use DMP(Digital Motion Processor) functionality
with MPU6050 sensor
• MPU6050_6Axis_MotionApps20.h
007: #include "MPU6050_6Axis_MotionApps20.h"
Code Explanation

*Slide 26*

• Main program
– Variable declaration
• mpuIntStatus: current interrupt status
• devStatus: current device status
• packetSize: data packet size
• fifoCount: # of data stored in FIFO
• fifioBuffer[]: buffer for reading data from FIFO
• Quaternion q: four dimensions
– [q.w, q.x, q.y, q.z] from DMP
• VectorFloat gravity: gravity vector
– [gravity.x, gravity.y, gravity.z] derived from Quaternion
• ypr[]: to store yaw, pitch, roll values – Calculated from Quaternion and gravity values


005: uint8_t mpuIntStatus;
006: uint8_t devStatus;
007: uint16_t packetSize;
008: uint16_t fifoCount;
009: uint8_t fifoBuffer[64];



011: Quaternion q;
012: VectorFloat gravity;
013: float ypr[3];

*Slide 27*

Code Explanation

– dmpInitialize() function
• Initialize DMP

028: devStatus = mpu.dmpInitialize();

• After a successful DMP initialization,
– Enable DMP: setDMPEnabled(true);
– Store FIFO packet size (=42)

030: if (devStatus == 0) {
031:
032: Serial.println(F("Enabling DMP..."));
033: mpu.setDMPEnabled(true);
034:
035: packetSize = mpu.dmpGetFIFOPacketSize();
036: }
037: else
038: {
039: Serial.print(F("DMP Initialization failed (code "));
040: Serial.print(devStatus);
041: Serial.println(F(")"));
042: }
Code Explanation
28
* loop() function
    * resetFIFO(): reset FIFO buffer
    * getIntStatus(): read the current interrupt status (store it at mpuIntStatus)
    * getFIFOCount(): read the current # of data in FIFO buffer (store it at fifoCount)
    * If mpuIntStatus & 0x02 is equal to 0x02, then do the following procedures:
        * Until fifoCount >= packetSize, fifoCount stores getFIFOCount() value
        * fifoBuffer[]: to store data from DMP FIFO
        * fifoCount is updated to fifoCount – packetSize
        * Obtain the quaternion value by calling dmpGetQuaternion() from fifoBuffer
        * Calculate the gravity value from the quaternion, and then calculate ypr[] values

```
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
```

*Slide 29*

Code Explanation

• fifobuffer data format
• dmpGetGravity() function
uint8_t MPU6050::dmpGetGravity(VectorFloat *v, Quaternion *q) {
v -> x = 2 * (q -> x*q -> z - q -> w*q -> y);
v -> y = 2 * (q -> w*q -> x + q -> y*q -> z);
v -> z = q -> w*q -> w - q -> x*q -> x - q -> y*q -> y + q -> z*q -> z;
}
0 1 2 3 4 5
QUAT W - QUAT X
6 7 8 9 10 11
- QUAT Y -
12 13 14 15 16 17
QUAT Z - GYRO X
18 19 20 21 22 23
- GYRO Y -
24 25 26 27 28 29
GYRO Z - ACC X
30 31 32 33 34 35
- ACC Y -
36 37 38 39 40 41
ACC Z - -
Code Explanation
30
• dmpGetYawPitchRoll() function
• We convert the measured values in radian to degree
• Then, send them to bluetooth
uint8_t MPU6050::dmpGetYawPitchRoll(float *data, Quaternion *q, VectorFloat
*gravity) {
data[0] = atan2(2*q -> x*q -> y - 2*q -> w*q -> z, 2*q -> w*q -> w +
2*q -> x*q -> x - 1);
data[1] = atan(gravity -> x / sqrt(gravity -> y*gravity -> y + gravity
-> z*gravity -> z));
data[2] = atan(gravity -> y / sqrt(gravity -> x*gravity -> x + gravity
-> z*gravity -> z));
}
Serial.print(" yaw : ");
Serial.print(180 - (ypr[0] * 180/M_PI));
Serial.print(" pitch : ");
Serial.print(ypr[1] * 180/M_PI);
Serial.print(" roll : ");
Serial.println(ypr[2] * 180/M_PI);
Today
• Review from the last lecture
– Infrared sensors
– Line tracing
• SmartCAR Gyro + Accelerometer sensors
• SmartCAR Compass sensor
• Announcement
31
Compass Sensor Direction
32
• Compass Sensor Direction
– Value will be the maximum when it points to
magnetic north
Compass Sensor in SmartCAR
33
• Compass sensor is connected to extension
board
Sample Program
34
– Compass_sensor.h
#ifndef Compass_sensor_H_
#define Compass_sensor_H_
#include "Arduino.h"
004:
#include "Wire.h"
#include "I2Cdev.h"
#include "MPU6050.h"
#include "AK8975.h"
009:
#ifdef __cplusplus
extern "C" {
#endif
void loop();
void setup();
#ifdef __cplusplus
}
#endif
018:
#endif
Sample Program
35
– Compass_sensor.cpp – (1)
#include "Compass_sensor.h"
002:
AK8975 Compass(0x0C);
MPU6050 accelgyro;
005:
int16_t mx, my, mz;
007:
void setup()
{
Wire.begin();
011:
Serial.begin(115200);
013:
Serial.println("Initializing I2C devices...");
015:
accelgyro.initialize();
accelgyro.setI2CBypassEnabled(true);
Compass.initialize();
019:
Serial.println("Testing device connections...");
021: Serial.println(Compass.testConnection() ? "AK8975 connection
successful" : "AK8975 connection failed");
022: }
023: 
Sample Program
36
– Compass_sensor.cpp – (2)
024: void loop()
025: {
026: Compass.getHeading(&mx, &my, &mz);
027: Serial.print(" Compass : ");
028: Serial.print(mx);
029: Serial.print(" ");
030: Serial.print(my);
031: Serial.print(" ");
032: Serial.println(mz);
033: delay(200);
034: }
Code Explanation
37
• Header file
– Include AK8975.h to use compass sensor
in AK8975
• Main program
– Global variable declaration
• Create an object named “Compass” in AK8975 class
• Initialize a member variable to 0x0C (as compass sensor
address)
• mx,my,mz : store data from Compass sensor
003: AK8975 Compass(0x0C);
004: MPU6050 accelgyro;
006: int16_t mx, my, mz;
008: #include "AK8975.h"
Code Explanation
38
– Setup() function
• Initialize 6 axes sensors, and enable I2CBypass mode
– To directly control Compass sensor
– loop() function
• Read data by calling getHeading() and store them at mx, my, mz
• Send them to bluetooth
016: accelgyro.initialize();
017: accelgyro.setI2CBypassEnabled(true);
018: Compass.initialize();
019:
020: Serial.println("Testing device connections...");
021: Serial.println(Compass.testConnection() ? "AK8975 connection
successful" : "AK8975 connection failed");
026: Compass.getHeading(&mx, &my, &mz);
027: Serial.print(" Compass : ");
028: Serial.print(mx);
029: Serial.print(" ");
030: Serial.print(my);
031: Serial.print(" ");
032: Serial.println(mz);
Course Announcement
• For lab session, we will cover
– Using gyro, accelerometer, and compass sensors
• Next Week
– Project discussion meetings: 10 – 15 minutes per
team
– Team 1 ~ 5
39







```
.____       _____ __________                                          
|    |     /  _  \\______   \                                         
|    |    /  /_\  \|    |  _/                                         
|    |___/    |    \    |   \                                         
|_______ \____|__  /______  /                                         
        \/       \/       \/       
```

*Slide 1*
Smart Software Project
Lab: Week 12
Gyro, Accelerometer
& Compass Sensors
Prof. HyungJune Lee
hyungjune.lee@ewha.ac.kr
Today
• Lab announcement
• SmartCAR Gyro + Accelerometer sensors
• Lab assignment #9
• Course announcement



*Slide 2*

• iPad will sometimes be used to provide students with dynamic education environments.
• This course will be offered in English.
7 Tentative Class Schedule
Week Lecture Contents Lab Contents
Week 1 Course introduction Arduino introduction: platform &
programming environment
Week 2 Embedded system overview & source management in
collaborative repository (using GitHub)
Lab 1: Arduino Mega 2560 board &
SmartCAR platform
Week 3 ATmega2560 Micro-controller (MCU): architecture & I/O
ports, Analog vs. Digital, Pulse Width Modulation
Lab 2: SmartCAR LED control
Week 4 Analog vs. Digital & Pulse Width Modulation Lab 3: SmartCAR motor control
(Due: HW on creating project repository
using GitHub)
Week 5 ATmega2560 MCU: memory, I/O ports, UART Lab 4: SmartCAR control via Android
Bluetooth
Week 6 ATmega2560 UART control & Bluetooth communication
between Arduino platform and Android device
Lab 5: SmartCAR control through your
own customized Android app
(Due: Project proposal)
Week 7 Midterm exam
Week 8 ATmega2560 Timer, Interrupts & Ultrasonic sensors Lab 6: SmartCAR ultrasonic sensing
Week 9 Infrared sensors & Buzzer Lab 7: SmartCAR infrared sensing
Week 10 Acquiring location information from Android device & line
tracing
Lab 8: Implementation of line tracer
Week 11 Gyroscope, accelerometer, and compass sensors Lab 9: Using gyroscope,
accelerometer, and compass sensors
Week 12 Project Team meeting (for progress check)
Week 13 Project Team meeting (for progress check)
Week 14 Course wrap-up & next steps
Week 15 Project presentation & demo I
(Due: source code, presentation slides, & poster slide)
Project presentation & demo II
Week 16 Final week (no final exam)

*Slide 3*

Class Schedule

Lab Session
• Practice in-lab programming exercises based on the lecture materials
• Upload source codes for lab assignments in Ewha
Cyber Campus after the lab session
– Due: 11:59pm on the lab day
• Once you are done, you can leave the session
after checking with me or TA
• Or, continue to work on programming
for other homework assignments

*Slide 4*

Lab Policy
• 1) Please check out your SmartCAR (& Nexus 7 tablet)
as soon as you arrive at the classroom
• 2) Please complete lab assignments
• 3) Upload required files to Ewha Cyber Campus
• 4) Check with me or TA
• 5) Please upload a null firmware to SmartCAR
before you return it!!!
– This will be a part of your lab score
• 6) Please remove files that you created or downloaded in your computer after you are done
– Remove your project completely
• 7) Please shut down your computer before you leave
• 8) Return the checked-out SmartCAR
(& Nexus 7 tablet) to TA

*Slide 5*

NOTE: How to run SmartCAR in Lab
• Power OFF
– Compile your code
– Lift up your SmartCAR with your hand
– Upload your code
• Disconnect the USB cable
• Go to find a spacious area
• Put it down there
• Power ON
• It will run your firmware
• After test, turn power OFF

*Slide 6*

Lab Announcement
• Bluetooth pairing “headache”
– Because there are so many Bluetooth devices
in the classroom with the same name
•
155v2.1.7_hb <- SmartCAR
– So please go outside with your SmartCAR and
your Android device, and then pair them
– Please do not pair with other students’ devices

*Slide 7*

Today
• Lab announcement
• SmartCAR Gyro + Accelerometer
• Lab assignment #11
• Course announcement

*Slide 8*

3 axes Accelerometer + 3 axes Gyro
*Slide 9
• 6 axes
– 1) from 3 axes accelerometer
• Measure proper acceleration in three axes
– 2) from 3 axes gyroscope
• Measure orientation, based on the principles of
angular momentum
6 Axes Sensors in SmartCAR

*Slide 10*

• InvenSense MPU-6050: Gyro 3 axis + Accelerometer 3 axis
sensors
– Data transmission type to Atmega MCU
• I
2C(Inter-Integrated Circuit) interface
– MPU-6050 Block diagram
Yaw, pitch, and roll calculation
• Let’s have the followings from 6 axes
measurements
– Yaw: rotation in z-axis
– Pitch: rotation in y-axis
– Roll: rotation in x-axis

*Slide 11*

Part I: SmartCAR Firmware

*Slide 12*



• Lab11.h

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



• lab11.cpp



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




• If the SmartCAR receives a byte of 14,
read gyroscope + accelerometer sensors
Part II: SmartCAR Gyro App
• http://ai2.appinventor.mit.edu
• Click on “New Project”
• Enter “SmartCAR_Gyro” in
Project Name
(One word, no space)
• Under “User Interface”
– Drag-and-drop “Button”
component
• To send command
– Drag-and-drop “CheckBox”
component
• Enable the line tracing, or
• Disable the line tracing
*Slide 17
BTOutput (Label)
SmartCAR Rotation Check
• Read measurements from Gyro and
Accelerometer
and print out in a label
(command byte: 14)
– Send “14” in number using
“BluetoothClient.Send1ByteNumber”
*Slide 18*
Lab Assignment #9
• Submit three following files to Cyber Campus
– 1) lab9.cpp (Arduino firmware code)
– 2) lab9.h (Arduino firmware code)
– 3) SmartCAR_Gyro.apk (Android app package)
• You should set the app icon image to “SmartCAR.png”
• In App Inventor,
“Build” è “App (save .apk to my computer)”
– 4) lab9_comment.txt
• Explain what is going on these measurements while rotating
• Show your result to TA or instructor
*Slide 19*
Lab Assignment #9:
lab9_comment.txt
• Please answer why the measurement is changing
in that way… found out any rule?
– When you rotate in x-axis
• Clockwise
• Counter clockwise
– When you rotate in y-axis
• Clockwise
• Counter clockwise
– When you rotate in z-axis
• Clockwise
• Counter clockwise
• Create lab9_comment.txt file
to explain this

*Slide 20*
+
x
+
y
+
z
Course Announcement
• Next Week
– Project discussion meetings: 10 – 15 minutes
per team
– Team 1 ~ 5

*Slide 21*