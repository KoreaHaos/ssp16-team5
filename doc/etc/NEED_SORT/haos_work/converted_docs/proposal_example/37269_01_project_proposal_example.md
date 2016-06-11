## <Smart Software Project Report #1>

Ewha Univ. Computer Eng.1115082 JinHee Yoo, 1215071 YeunJin Woo

### 1.  Project Name

**Cartender**
* *Car + Bartender*

### 2. Project Statement

The  main  goal  of  our  project  is  tracking  the  lines  automatically  by  certainrequirement.   SmartCAR goes along with line. The line has various brightness; 100% dark,75% dark, 50% dark and 25% dark. If a SmartCAR stands at a crossroads, then it judgeswhere to go by line brightness. Satisfying all requirements, The SmartCAR comes back inorigin place.

We applied these movements to an exciting show, cocktail order. Suppose that you wantto  order  some  drink  in  bar.  In  classic  bar,  a  waiter  may  take  an  order  and  give  youordered  drink.  However,  can  you  imagine  that  a  a  mini  car  bring  out  your  drink?  Whatyou do is just ordering the drink with the mobile menu, and then the SmartCAR will solveeverything.

### 3.  Project description

* 1. **Taking an order by mobile device**

There is a smart device near the table, it can order into touch screen. In smart device,you can choose any cocktail. Below is UI of application.

![Image25](images/Image25)

![Image27](images/Image27)

* 2. Send the order to SmartCAR

After selecting the order in smart device menu, this passes value to SmartCAR. In thistime, smart device can Bluetooth communicate with SmartCAR.

* 3. Processing the order

The SmartCAR checks where to go by value of No.2 If SmartCAR can access 4 places,A,B,C or D, It can choose A-D, A-B-C, or A-C-D as the path. Selecting cocktail, placesis  chosen  as  type  of  drinks.  If  there  have  3  dispenser,  all  of  probability  are  7.(A,B,C,A-B,A-C,B-C,A-B-C)  Because  the  order  of  dispenser  is  fixed,  SmartCAR  cannotmove B-A, but A-B.

<table align="center">
	<tr align="center">
		<td></td>
		<td></td>
		<td>Probability</td>
		<td>Order of Drink</td>
	</tr>
	<tr align="center">
		<td>1</td>
		<td>A</td>
		<td>A</td>
		<td>A</td>
	</tr>
	<tr align="center">
		<td>1</td>
		<td>B</td>
		<td>B</td>
		<td>B</td>
	</tr>
	<tr align="center">
		<td>1</td>
		<td>C</td>
		<td>C</td>
		<td>C</td>
	</tr>
	<tr align="center">
		<td>2</td>
		<td>A,B</td>
		<td>A-B / B-A</td>
		<td>A-B</td>
	</tr>
	<tr align="center">
		<td>2</td>
		<td>B,C</td>
		<td>B-C / C-B</td>
		<td>B-C</td>
	</tr>
	<tr align="center">
		<td>2</td>
		<td>A,C</td>
		<td>A-C / C-A</td>
		<td>A-C</td>
	</tr>
	<tr align="center">
		<td>3</td>
		<td>A,B,C</td>
		<td>A-B-C / A-C-B / B-A-C / B-C-A / C-A-B / C-B-A</td>
		<td>A-B-C</td>
	</tr>
</table>

* 4. Moving along lines & Coming back along lines

SmartCAR moves lines by result of No.3.

* 5. Choosing where to go in a crossroads depending on brightness.

Brightness  of  line  consists  of  100%,75%,50%,25%.  100%  brightness  line  means  thisline  is  linear.  The  other  brightness  of  75%,50%,25%  is  a  path  for  dispenser.  In  3,  wealready  know  whether  go  or  not  in  crossroads.  Therefore,  if  brightness  of  line  ischanged,  checks  the  drink  list  and  decides  whether  ignore  or  not.  After  going  forcrossroads, SmartCAR should come back.

* 6. Deciding the stay time. (It depends on quantity of drinks).

![Image31](images/Image31)

The Dispenser  is  similar to water purifier cork. When pushing the cork, drink comesout. A Cup attached SmartCAR push the cork, so It can get the drinks. The more timegoes on pushing, the more cup gets the drinks.

* 7. SmartCAR comes back, and notify the smart device.

After line tracking and coming back the  SmartCAR, it sends the message that cup isfilled  with  drinks.  Then  smart  device  receives  the  message,  prints  out  that.  BetweenSmartCAR and mobile device, they communicate Bluetooth communication.

* 8. Mixing the drink after putting a lid on cup.

After  putting  a  lid  on  cup,  Smart  device  sends  message  to  SmartCAR.  Then,SmartCAR moves back and forth short.ly. It helps mix the drinks of cup.

* 9. Turning LED on/off when driving.

Giving  an  interest  and  joyfulness,  SmartCAR  can  control  front  and  rear  LED.Initially, front LED sets up HIGH, and rear LED sets up LOW. In driving, both LEDblinks  turn  and  turn..  Interval  time  is  1000ms.  In  special  time,  blink  time  canchange diversely. For example, the time of mixing the drinks can blink rapidly.![Image39](images/Image39)

![Image41](images/Image41)

![Image45](images/Image45)

Above  picture  is  overview  of  our  project..  The  SmartCAR  can  distinguish  brightness  ofline. There are 3 dispenser, each dispenser has drinks bottle (In cocktail, it can be Vodka,peach juice and orange juice) . We’ll print the line on paper.. The map is bigger than A4paper, so we divide line by pieces, then glue pieces. SmartCAR is just car, so we combinecar and cup. (This is very important part in view of secure of SmartCAR  )

### 4.  Contribution of our work to industry

* 1. Attraction

The  important  part  of  cocktail  industry  is  attraction  for  it.  So,  many  cocktail  bars  usevarious ways to catch customer’s eye. It can be another succession case for attraction. In fact,there is a similar case in sushi restaurant using mini cars and rails for serving. These picturesshow the details of it.

* Examples:

A) Customer can choose menu using touch menu device.

![Image50](images/Image50)

B) Cook makes the right menu and then lay the dish on mini car for serving.

C) Mini car deliver the dish to the customer.

D) This unusual serving system makes the restaurant famous.)

### 5.  Related work

①  line tracking

Two  infrared  sensors  were  mounted  to  the  front  of  the  robot,  enabling  it  to  see  astrip of black tape on the tabletop. It detects black line on white surface. Principle issimple. Left sensor will be controlling left motor, when the sensor is on white surface![Image51](images/Image51)

![Image52](images/Image52)

![Image53](images/Image53)

motor  will  be  switched  on  else  switched  off.  Similarly  right  motor  is  controlled  byright sensor. To sense the line properly sensor must be placed on he robot is such a waythat they are every close the ground.    Same thing is tracking the line, but different is thatwe distinguish diverse bright line.

②  arduino cocktail machine

That  is  based  on  arduino.  Machine  has  some  drink.  Pushing  the  button,  cup  movesautomatically and get the drinks. In machine, there are 9 bottles. In this bottles, it canmake the cocktail more than 100.

Same thing is for making cocktail. However implementation is very different.

③  Minicar serving sushi.

In  japan,  there  is  special  sushi  shop.,  ordered  menu  come  using  minicar.  Minicar  islocated above table. And, it has fixed rail. It is similar to conveyor belt.. Minicar movesjust one direction, and it has go or stop.

![Image58](images/Image58)

![Image59](images/Image59)

Same thing is serving thought CAR. However difference is directional nation.

### 6.

System overview & Architecture

6.  Development environment

   * Arduino Mega 2560-based SmartCAR
   * Android device

3 Drink Suspenser

-  Android Studio IDE

-

Sensor : infrared sensor

![Image64](images/Image64)

![Image65](images/Image65)

-  Android app development – APP Invent

### 7.  .Verification procedure

①  Data Transmission Using Bluetooth

- Send the message from mobile to CPU (Can the SmartCAR select right way?)- Send the message from CPU to mobile (Can the mobile shows right message?)②  Line Tracking

(Does the SmartCAR get out of the line with various type, brightness and direction?)

* Criteria = 1/2*(width of SmartCAR)

a) Forward

b) Backward

③  Distinguishing Brightness

(Can the SmartCARrecognize the different brightness between two lines?)

(SmartCAR has to send the check message to mobile)

* Comparison standard = 100% brightness

④  Minimum distance between crossroads

(Can the SmartCAR track the right line without interrupt of other lines?)

<table align="center">
	<tr align="center">
		<td></td>
		<td>Straight line</td>
		<td>Curve</td>
	</tr>
	<tr align="center">
		<td>100%</td>
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>75%</td>
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>50%</td>
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>25%</td>
		<td></td>
		<td></td>
	</tr>
</table>

<table align="center">
	<tr align="center">
		<td></td>
		<td>Straight line</td>
		<td>Curve</td>
	</tr>
	<tr align="center">
		<td>100%</td>
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>75%</td>
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>50%</td>
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>25%</td>
		<td></td>
		<td></td>
	</tr>
</table>

<table align="center">
	<tr align="center">
		<td>75%</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>50%</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>25%</td>
		<td></td>
	</tr>
</table>

<table align="center">
	<tr align="center">
		<td>30cm</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>60cm</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>90cm</td>
		<td></td>
	</tr>
</table>

⑤  Minimum Shaking times

(How many times the SmartCAR shouldmove(=shake) to mix the drink?)

(Is there any layer in the drink?)

* 1 time = 1 back and forth

* Distance = 1m , Speed = standard speed*2

(Standard speed would be determined at the time to start the project)

<table align="center">
	<tr align="center">
		<td>1 time</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>2 times</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>3 times</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>4 times</td>
		<td></td>
	</tr>
	<tr align="center">
		<td>5 times</td>
		<td></td>
	</tr>
</table>

### 9. What do you anticipate will be the easiest part of your project?

- :  The  easiest  part  of  our  project  is  controlling  of  SmartCAR  LED.  As  for  function,  it  is  not

- necessary.  But,  in  this  project,  attraction  is  a  considerable  part.  That’s  why  we  decided  to  using

- LED additionally. We will use LED when the car performs the last mission, shaking the drink and

- then delivering it to customer. It can make the car showy. We plan to conduct it using PWM. As

- we already learned for managing SmartCAR LED in the class, it can be relatively easy.

### 10.  What do you anticipate will be the most difficult part of your project? :

- The most difficult part of our project is making SmartCARdistinguish the line using  difference of

- brightness. Also, it is the most important part of ours. That’s because we use intensity difference

- to separateways to particular drinks. We have to make SmartCAR select the right road matching

- the order. Furthermore we have to use 4  different lines  at least. Probably it would be better  for

- starting from specifying the SmartCar’s  capacity for recognizing  light and shade.  Of course,  it  is

- not easy, but to our knowledge, it can be implemented.

### 11.Detatiled time plan

<table align="center">
	<tr align="center">
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td>3주차</td>
		<td>:  모바일  통신관련  함수  구현</td>
	</tr>
	<tr align="center">
		<td>4주차</td>
		<td>line tracking using infrared sensor –  함수구현</td>
	</tr>
	<tr align="center">
		<td>5주차</td>
		<td>line tracking using infrared sensor –  함수구현</td>
	</tr>
	<tr align="center">
		<td>6주차</td>
		<td>line tracking using infrared sensor –  함수구현</td>
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
	</tr>
</table>

### 12. Refernce

- Line tracking : http://www.machinescience.org/line-tracking-rc-car/

- Cocktail machine : http://www.theinebriator.com/

- sushi minicar : http://noas.tistory.com/1225

