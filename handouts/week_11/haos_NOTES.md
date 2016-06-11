CODE FROM LECTURE  SLIDES

Slide 11

```cpp

void DAC_CH_Write(unsigned int ch, unsigned int da)
{
    unsigned int data = ((ch << 12) & 0x7000) |
    ((da << 4) & 0x0FF0);
    DAC_setting(data);
}

void DAC_setting(unsigned int data)
{
    int z;
    digitalWrite(S_SCLK,HIGH);
    delayMicroseconds(1);
    digitalWrite(S_SCLK,LOW);
    delayMicroseconds(1);
    digitalWrite(S_SYNCN,LOW);
    delayMicroseconds(1);
    for(z=15;z>=0;z--)
    {
        digitalWrite(S_DIN,(data>>z)&0x1);
        digitalWrite(S_SCLK,HIGH);
        delayMicroseconds(1);
        digitalWrite(S_SCLK,LOW);
        delayMicroseconds(1);
    }
    digitalWrite(S_SYNCN,HIGH);
}
```


slide 13

```
#define S_DIN 42
#define S_SCLK 43
#define S_SYNCN 44
#define IN_SEN_EN 26
int SensorA[8] = {A0,A1,A2,A3,A4,A5,A6,A7};
int SensorD[8] = {30,31,32,33,34,35,36,37};
void setup()
{
    int z;
    int dac_val_min[8] =
    {59,94,81,79,166,104,108,77};
    int dac_val_max[8] =
    {443,627,678,603,957,761,797,559};
    Serial.begin(115200);
    pinMode(IN_SEN_EN,OUTPUT);
    pinMode(S_DIN,OUTPUT);
    pinMode(S_SCLK,OUTPUT);
    pinMode(S_SYNCN,OUTPUT);
    digitalWrite(S_SCLK,LOW);
    digitalWrite(S_SYNCN,HIGH);
    digitalWrite(IN_SEN_EN,HIGH);
    Mode DB[15:12] DB[11:0] Etc
    WRM 1000 XXXX XXXX XXXX 0x8000
    WTM 1001 XXXX XXXX XXXX 0x9000
    for (z=0; z<8; z++)
    pinMode(SensorD[z], INPUT);
    DAC_setting(0x9000); //for Write-Through Mode
    for (z=0; z<8; z++)
    {
        int mean_val =
        (dac_val_min[z]+dac_val_max[z])/2; //10-bit
        DAC_CH_Write(z, mean_val >> 2);
        //should be 8-bit
    }
}
```


slide 15
```cpp
void infrared_sensor_read()
{
    int z;
    for(z=7;z>=0;z--)
    {
        unsigned int val = analogRead(SensorA[z]);
        Serial.print(val);
        Serial.print(" ");
    }
    Serial.println("");
    for(z=7;z>=0;z--)
    {
        unsigned int val = digitalRead(SensorD[z]);
        Serial.print(val);
        Serial.print(" ");
    }
}
void serialEvent()
{
    int command = Serial.read();
    switch (command)
    {
        ...
        ...
        case 11:
        infrared_sensor_read();
        break;
        default:
    }
```

slide 19

```cpp
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


slide 22

```cpp
boolean line_tracing = false;
//…
void line_tracing_enable()
{
    line_tracing = true;
    Serial.write("Line tracing is enabled..");
}

void line_tracing_disable()
{
    line_tracing = false;
    move_stop();
    Serial.write("Line tracing is disabled..");
}

void serialEvent()
{
    int command = Serial.read();
    switch (command)
    {
        //...
        case 12:
        line_tracing_enable();
        break;
        case 13:
        line_tracing_disable();
        break;
        default:
    }
}
```

slide 23

```cpp
void loop()
{
    if (line_tracing == true)
    {
        unsigned char sensor_data = 0;
        int z;
        for(z=0;z<8;z++)
        {
            unsigned int val = digitalRead(SensorD[z]);
            sensor_data |= (val << z);
        }
        sensor_data = ~sensor_data;
        Serial.print(sensor_data, HEX);
        Serial.write(" ");
        
        switch (sensor_data)
        {
            case 0x18:
            case 0x10:
            case 0x08:
            case 0x38:
            case 0x1c:
            case 0x3c:
                move_forward_speed(140, 140);
                break;
            case 0x0c:
            case 0x04:
            case 0x06:
            case 0x0e:
            case 0x1e:
            case 0x0f:
                turn_right_speed(200, 0);
                break;
            case 0x30:
            case 0x20:
            case 0x60:
            case 0x70:
            case 0x78:
            case 0xf0:
                turn_left_speed(0, 200);
                break;
            case 0x07:
            case 0x03:
            case 0x02:
            case 0x01:
                turn_pivot_right_speed(200, 80);
                break;
```



slide 24

```cpp

            case 0xc0:
            case 0x40:
            case 0x80:
            case 0xe0:
                turn_pivot_left_speed(80, 200);
                break;
            case 0x00:
            case 0xff:
                move_stop();
                break;
            default:
                move_stop();
                break;
        }
        delay(5);
    }
}

void move_forward_speed(int left, int right)
{
}

void turn_left_speed(int left, int right)
{
}

void turn_right_speed(int left, int right)
{
}

void turn_pivot_left_speed(int left, int right)
{
}

void turn_pivot_right_speed(int left, int right)
{
}
```

slides 23 & 24 combined

```cpp

void loop()
{
    if (line_tracing == true)
    {
        unsigned char sensor_data = 0;
        
        int z;
        
        for(z=0;z<8;z++)
        {
            unsigned int val = digitalRead(SensorD[z]);
            sensor_data |= (val << z);
        }
        
        sensor_data = ~sensor_data;
        
        Serial.print(sensor_data, HEX);
        Serial.write(" ");
        
        switch (sensor_data)
        {
            case 0x18:
            case 0x10:
            case 0x08:
            case 0x38:
            case 0x1c:
            case 0x3c:
                move_forward_speed(140, 140);
                break;
            case 0x0c:
            case 0x04:
            case 0x06:
            case 0x0e:
            case 0x1e:
            case 0x0f:
                turn_right_speed(200, 0);
                break;
            case 0x30:
            case 0x20:
            case 0x60:
            case 0x70:
            case 0x78:
            case 0xf0:
                turn_left_speed(0, 200);
                break;
            case 0x07:
            case 0x03:
            case 0x02:
            case 0x01:
                turn_pivot_right_speed(200, 80);
                break;
            case 0xc0:
            case 0x40:
            case 0x80:
            case 0xe0:
                turn_pivot_left_speed(80, 200);
                break;
            case 0x00:
            case 0xff:
                move_stop();
                break;
            default:
                move_stop();
                break;
        }
        delay(5);
    }
}
void move_forward_speed(int left, int right)
{
}
void turn_left_speed(int left, int right)
{
}
void turn_right_speed(int left, int right)
{
}
void turn_pivot_left_speed(int left, int right)
{
}
void turn_pivot_right_speed(int left, int right)
{
}
```


CODE FROM LAB SLIDES

Slide 10

```cpp
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

Slide 13

```cpp

boolean line_tracing = false;
//…

void line_tracing_enable()
{
    line_tracing = true;
    Serial.write("Line tracing is enabled..");
}

void line_tracing_disable()
{
    line_tracing = false;
    move_stop();
    Serial.write("Line tracing is disabled..");
}

void serialEvent()
{
    int command = Serial.read();
    switch (command)
    {
        //...
        case 12:
        line_tracing_enable();
        break;
        case 13:
        line_tracing_disable();
        break;
        default:
    }
}
```

Slides 15 & 16

```cpp
void loop()
{
    if (line_tracing == true)
    {
        unsigned char sensor_data = 0;
        int z;
        for(z=0;z<8;z++)
        {
            unsigned int val = digitalRead(SensorD[z]);
            sensor_data |= (val << z);
        }
        sensor_data = ~sensor_data;
        Serial.print(sensor_data, HEX);
        Serial.write(" ");
        switch (sensor_data)
        {
            case 0x18:
            case 0x10:
            case 0x08:
            case 0x38:
            case 0x1c:
            case 0x3c:
            move_forward_speed(140, 140);
            break;
            case 0x0c:
            case 0x04:
            case 0x06:
            case 0x0e:
            case 0x1e:
            case 0x0f:
            turn_right_speed(200, 0);
            break;
            case 0x30:
            case 0x20:
            case 0x60:
            case 0x70:
            case 0x78:
            case 0xf0:
            turn_left_speed(0, 200);
            break;
            case 0x07:
            case 0x03:
            case 0x02:
            case 0x01:
            turn_pivot_right_speed(200, 80);
            break;
            
            case 0xc0:
            case 0x40:
            case 0x80:
            case 0xe0:
            turn_pivot_left_speed(80, 200);
            break;
            case 0x00:
            case 0xff:
            move_stop();
            break;
            default:
            move_stop();
            break;
        }
        delay(5);
    }
}
void move_forward_speed(int left, int right)
{
}
void turn_left_speed(int left, int right)
{
}
void turn_right_speed(int left, int right)
{
}
void turn_pivot_left_speed(int left, int right)
{
}
void turn_pivot_right_speed(int left, int right)
{
}
```


