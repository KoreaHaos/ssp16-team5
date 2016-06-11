#define FRONT_LED_PIN 10
#define REAR_LED_PIN 9
#define DUTY_CYCLE 20 //20ms

int done = false;

void PWM_Write(int pin, int on_time_perc)
{
    int on_time = DUTY_CYCLE*on_time_perc/100.0;
    int off_time = DUTY_CYCLE - on_time;
    digitalWrite(pin, HIGH);
    delay(on_time);
    digitalWrite(pin, LOW);
    delay(off_time);
}

void myAnalogWrite(int pin, int percent, int time)
{
    int num_loops = time/DUTY_CYCLE;
    int i;
    for (i=0; i<num_loops; i++)
    {
        PWM_Write(pin, percent);
    }
}

void setup()
{
    pinMode(REAR_LED_PIN, OUTPUT);
}

void loop()
{
    if (done == false) {
        myAnalogWrite(REAR_LED_PIN, 100, 2000);
        myAnalogWrite(REAR_LED_PIN, 75, 2000);
        myAnalogWrite(REAR_LED_PIN, 50, 2000);
        myAnalogWrite(REAR_LED_PIN, 25, 2000);
        done = true;
    }
    else
    digitalWrite(REAR_LED_PIN, LOW);
}