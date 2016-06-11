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
2
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
3
June 13 
Today
• Review from the last lecture
– Infrared sensors
– Line tracing
• SmartCAR Gyro + Accelerometer sensors
• SmartCAR Compass sensor
• Announcement
4
Line Tracer
5
• Line tracing in SmartCAR
– Infrared sensor data depending on SmartCAR’s position
(a) Forward (b) Smooth Right-turn (c) Smooth Left-turn
(d) Pivot Right-turn (e) Pivot Left-turn
Sensor Data
6
SensorD[0] SensorD[7]
SensorD[7] SensorD[6] SensorD[5] SensorD[4] SensorD[3] SensorD[2] SensorD[1] SensorD[0]
…
…
unsigned char sensor_data = 0;
int z;
for(z=0;z<8;z++)
{
unsigned int val = digitalRead(SensorD[z]);
sensor_data |= (val << z);
}
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
8
3 axes Accelerometer + 3 axes Gyro
9
• 6 axes
– 1) from 3 axes accelerometer
• Measure proper acceleration in three axes
– 2) from 3 axes gyroscope
• Measure orientation, based on the principles of
angular momentum
6 Axes Sensors in SmartCAR
10
• InvenSense MPU-6050: Gyro 3 axis + Accelerometer 3 axis
sensors
– Data transmission type to Atmega MCU
• I
2C(Inter-Integrated Circuit) interface
– MPU-6050 Block diagram
Sensor Sensitivity
11
• Accelerometer
– Sensitivity
• Gyroscope
– Sensitivity
• Basic setting: ±2g for accelerometer, ±250 º/sec for gyroscope
Full-Scale Range AFS_FEL Sensitivity Scale Factor Etc
±2 g 0 16384 LSB/g
±4 g 1 8192 LSB/g
±8 g 2 4096 LSB/g
±16 g 3 2048 LSB/g
Full-Scale Range FS_FEL Sensitivity Scale Factor Etc
±250 º/sec 0 131 LSB/(º/sec)
±500 º/sec 1 65.5 LSB/(º/sec)
±1000 º/sec 2 32.8 LSB/(º/sec)
±2000 º/sec 3 16.4 LSB/(º/sec)
Port Configuration for 6 axes Sensor
12
Chip Name Port / Number Etc
MPU-6050
SDA PD1 / 20
SCL PD0 / 21
Sample Program










• Accelgyro_sensor.h

001: #ifndef Accelgyro_sensor_H_
002: #define Accelgyro_sensor_H_
003: #include "Arduino.h"
004:
005: #include "Wire.h"
006: #include "I2Cdev.h"
007: #include "MPU6050.h"
008:
009: #ifdef __cplusplus
010: extern "C" {
011: #endif
012: void loop();
013: void setup();
014: #ifdef __cplusplus
015: }
016: #endif
017:
018: #endif


• Accelgyro_sensor.cpp – (1)


001: #include "Accelgyro_sensor.h"
002:
003: MPU6050 accelgyro;
004:
005: int16_t ax, ay, az;
006: int16_t gx, gy, gz;
007:
008: void setup()
009: {
010: Wire.begin();
011: Serial.begin(115200);
012: Serial.println("Initializing I2C devices...\r");
013: accelgyro.initialize();
014:
015: Serial.println("Testing device connections...\r");
016: Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful\r" : "MPU6050 connection failed\r");
017: }
018:
019: void loop()
020: {
021:
022: accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
023:
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
036: delay(200);
037: }





Code Explanation
16
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
005: #include "Wire.h"
006: #include "I2Cdev.h"
007: #include "MPU6050.h"
005: int16_t ax, ay, az;
006: int16_t gx, gy, gz;
010: Wire.begin();
Code Explanation
17
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
18
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
19
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
• Let’s have the followings from 6 axes
measurements
– Yaw: rotation in z-axis
– Pitch: rotation in y-axis
– Roll: rotation in x-axis
20
Sample Program
21
• Accelgyro_angle.h
001: #ifndef Accelgyro_angle_H_
002: #define Accelgyro_angle_H_
003: #include "Arduino.h"
004:
005: #include "Wire.h"
006: #include "I2Cdev.h"
007: #include "MPU6050_6Axis_MotionApps20.h"
008:
009: #ifdef __cplusplus
010: extern "C" {
011: #endif
012: void loop();
013: void setup();
014: #ifdef __cplusplus
015: }
016: #endif
017:
018: #endif
Sample Program
22
– Accelgyro_angle.cpp – (1)
001: #include "Accelgyro_angle.h"
002:
003: MPU6050 mpu;
004:
005: uint8_t mpuIntStatus; // holds actual interrupt status byte from MPU
006: uint8_t devStatus; // return status after each device operation (0
= success, !0 = error)
007: uint16_t packetSize; // expected DMP packet size (default is 42
bytes)
008: uint16_t fifoCount; // count of all bytes currently in FIFO
009: uint8_t fifoBuffer[64]; // FIFO storage buffer
010:
011: Quaternion q; // [w, x, y, z] quaternion container
012: VectorFloat gravity; // [x, y, z] gravity vector
013: float ypr[3]; // [yaw, pitch, roll] yaw/pitch/roll
container and gravity vector
014:
015: void setup()
016: {
017: Wire.begin();
018:
019: Serial.begin(115200);
020:
021: Serial.println(F("Initializing I2C devices..."));
022: mpu.initialize();
Sample Program
23
– Accelgyro_angle.cpp – (2)
023:
024: Serial.println(F("Testing device connections..."));
025: Serial.println(mpu.testConnection() ? F("MPU6050 connection
successful") : F("MPU6050 connection failed"));
026:
027: Serial.println(F("Initializing DMP..."));
028: devStatus = mpu.dmpInitialize();
029:
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
043: }
044:
045: void loop()
046: {
Sample Program
24
– Accelgyro_angle.cpp – (3)
047: while(1)
048: {
049: mpu.resetFIFO();
050: mpuIntStatus = mpu.getIntStatus();
051: fifoCount = mpu.getFIFOCount();
052: if(mpuIntStatus & 0x02)
053: {
054: while(fifoCount < packetSize)
055: fifoCount = mpu.getFIFOCount();
056: mpu.getFIFOBytes(fifoBuffer, packetSize);
057: fifoCount -= packetSize;
058: mpu.dmpGetQuaternion(&q, fifoBuffer);
059: mpu.dmpGetGravity(&gravity, &q);
060: mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
061: break;
062: }
063: }
064: Serial.print(" yaw : ");
065: Serial.print(180 - (ypr[0] * 180/M_PI)); //yaw
066: Serial.print(" pitch : ");
067: Serial.print(ypr[1] * 180/M_PI); // pitch
068: Serial.print(" roll : ");
069: Serial.println(ypr[2] * 180/M_PI); //roll
070: delay(200);
071: }
Code Explanation
25
• Header file
– Include a header file
• Use DMP(Digital Motion Processor) functionality
with MPU6050 sensor
• MPU6050_6Axis_MotionApps20.h
007: #include "MPU6050_6Axis_MotionApps20.h"
Code Explanation
26
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
Code Explanation
27
– dmpInitialize() function
• Initialize DMP
• After a successful DMP initialization,
– Enable DMP: setDMPEnabled(true);
– Store FIFO packet size (=42)
028: devStatus = mpu.dmpInitialize();
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
– loop() function
• resetFIFO(): reset FIFO buffer
• getIntStatus(): read the current interrupt status (store it at mpuIntStatus)
• getFIFOCount(): read the current # of data in FIFO buffer (store it at fifoCount)
• If mpuIntStatus & 0x02 is equal to 0x02, then do the following procedures:
– Until fifoCount >= packetSize, fifoCount stores getFIFOCount() value
– fifoBuffer[]: to store data from DMP FIFO
– fifoCount is updated to fifoCount – packetSize
– Obtain the quaternion value by calling dmpGetQuaternion() from fifoBuffer
– Calculate the gravity value from the quaternion, and then calculate ypr[] values
049: mpu.resetFIFO();
050: mpuIntStatus = mpu.getIntStatus();
051: fifoCount = mpu.getFIFOCount();
052: if(mpuIntStatus & 0x02)
053: {
054: while(fifoCount < packetSize)
055: fifoCount = mpu.getFIFOCount();
056: mpu.getFIFOBytes(fifoBuffer, packetSize);
057: fifoCount -= packetSize;
058: mpu.dmpGetQuaternion(&q, fifoBuffer);
059: mpu.dmpGetGravity(&gravity, &q);
060: mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
061: break;
062: }
Code Explanation
29
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
064: Serial.print(" yaw : ");
065: Serial.print(180 - (ypr[0] * 180/M_PI));
066: Serial.print(" pitch : ");
067: Serial.print(ypr[1] * 180/M_PI);
068: Serial.print(" roll : ");
069: Serial.println(ypr[2] * 180/M_PI);
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
001: #ifndef Compass_sensor_H_
002: #define Compass_sensor_H_
003: #include "Arduino.h"
004:
005: #include "Wire.h"
006: #include "I2Cdev.h"
007: #include "MPU6050.h"
008: #include "AK8975.h"
009:
010: #ifdef __cplusplus
011: extern "C" {
012: #endif
013: void loop();
014: void setup();
015: #ifdef __cplusplus
016: }
017: #endif
018:
019: #endif
Sample Program
35
– Compass_sensor.cpp – (1)
001: #include "Compass_sensor.h"
002:
003: AK8975 Compass(0x0C);
004: MPU6050 accelgyro;
005:
006: int16_t mx, my, mz;
007:
008: void setup()
009: {
010: Wire.begin();
011:
012: Serial.begin(115200);
013:
014: Serial.println("Initializing I2C devices...");
015:
016: accelgyro.initialize();
017: accelgyro.setI2CBypassEnabled(true);
018: Compass.initialize();
019:
020: Serial.println("Testing device connections...");
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