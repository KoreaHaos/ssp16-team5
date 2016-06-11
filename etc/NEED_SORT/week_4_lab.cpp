/*
 * This is code for Week 4 of Smart Software Project.
 *
 * It was thought up while riding the subway and untested.
 * It uses a single function to move the smart car forward, backward, or turning.
 * The turning aspect of the algorythm needs work if it going to do anything
 * useful but as is, it is expected to meet the requirements for the lab.
 * 
 * The code will move the smart car forward for two seconds. spin for one and a 
 * hald seconds, spin the other way for the same amount of time, and finally 
 * move backwards for two seconds again.
 * There is a delay of half a second in between each motion event.
 *
 * UN-TESTED! Run at your own risk!
 *
 * -BEn C.Haos
 *
 */

#define LEFT_MD_A 22
#define LEFT_MD_B 23
#define RIGHT_MD_A 24
#define RIGHT_MD_B 25
#define LEFT_MOTOR_EN 4
#define RIGHT_MOTOR_EN 5
int init_done = false;

//The setup function is called once at startup of the sketch
void setup()
{
    // Add your initialization code here
    pinMode(LEFT_MD_A, OUTPUT);
    pinMode(LEFT_MD_B, OUTPUT);
    pinMode(RIGHT_MD_A, OUTPUT);
    pinMode(RIGHT_MD_B, OUTPUT);
    pinMode(LEFT_MOTOR_EN, OUTPUT);
    pinMode(RIGHT_MOTOR_EN, OUTPUT);

    digitalWrite(LEFT_MD_A, LOW);
    digitalWrite(LEFT_MD_B, LOW);
    digitalWrite(RIGHT_MD_A, LOW);
    digitalWrite(RIGHT_MD_B, LOW);
    digitalWrite(LEFT_MOTOR_EN, LOW);
    digitalWrite(RIGHT_MOTOR_EN, LOW);
}

/*
Function to moves smart car.
Wheels turn by milliseconds counting towards zero until zero is reached.
*/

void move_smart_car(int left_ms, int right_ms) {
    
    while (left_ms != 0 || right_ms != 0) {
        
        if (left_ms != 0) {
            if (left_ms > 0){
                digitalWrite(LEFT_MD_A, HIGH);
                digitalWrite(LEFT_MD_B, LOW);
                left_ms = left_ms - 1;
            } else {
                digitalWrite(LEFT_MD_A, LOW);
                digitalWrite(LEFT_MD_B, HIGH);
                left_ms = left_ms + 1;
            }
            analogWrite(LEFT_MOTOR_EN, 100);
        } else {
            analogWrite(LEFT_MOTOR_EN, 0);
        }
    
        if (right_ms != 0) {
            if (right_ms > 0){
                digitalWrite(RIGHT_MD_A, LOW);
                digitalWrite(RIGHT_MD_B, HIGH);
                left_ms = left_ms - 1;
            } else {
                digitalWrite(RIGHT_MD_A, HIGH);
                digitalWrite(RIGHT_MD_B, LOW);
                left_ms = left_ms + 1;
            }
            analogWrite(RIGHT_MOTOR_EN, 100);
        } else {
            analogWrite(RIGHT_MOTOR_EN, 0);
        }
    }
    
    delay(1);
}

void loop()
{
    //Add your repeated code here
    if (init_done == false)
    {
        move_smart_car(2000, 2000);
        delay(500);
        move_smart_car(1500, -1500);
        delay(500);
        move_smart_car(-1500, 1500);
        delay(500);
        move_smart_car(-2000, -2000);
    }
    else
    move_stop();
}
