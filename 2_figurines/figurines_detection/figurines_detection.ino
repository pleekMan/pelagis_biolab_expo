
unsigned int switchPins[] = { 8, 9, 10, 11 };
unsigned int switchState[] = { 0, 0, 0, 0 };

int previousDetection = 0;
int selection = 0;

// DETECT TWICE THEE SAME OBJECT TO SET selection
// DETECTION IS DONE EVERY detectDelay DELAY
// (A SORT OF DEBOUNCING FOR WHEN PEOPLE HAVE A HARD TIME WITH THE INTERFACE)
int detectionTries = 0;
bool tryMode = false;
int detectionDelay = 2000;

void setup() {

  pinMode(switchPins[0], INPUT);
  pinMode(switchPins[1], INPUT);
  pinMode(switchPins[2], INPUT);
  pinMode(switchPins[3], INPUT);

  Serial.begin(9600);
}

void loop() {

  int currentDetection = 0;
  //selection = 0;

  // THIS DOES NOT WORK: ADDS INCORRECTLY FROM THE 3rd BIT (4) ONWARDS... I HAVE NO FUCKING IDEA WHY..!!
  // for (int i = 0; i < 4; i++) {
  //   switchState[i] = digitalRead(switchPins[i]);

  //   Serial.print(i);
  //   Serial.print(':');
  //   Serial.print(switchState[i]);
  //   Serial.print(':');
  //   Serial.print(switchState[i] * (pow(2, i)));

  //   selection += switchState[i] * (pow(2, i));

  //   Serial.print('=');
  //   Serial.println(selection);
  // }

  // THIS WORKS FINE
  for (int i = 0; i < 4; i++) {
    switchState[i] = digitalRead(switchPins[i]);
    Serial.print(i);
    Serial.print(':');
    Serial.println(switchState[i]);
  }
  currentDetection = (switchState[0] * (pow(2, 0))) + (switchState[1] * (pow(2, 1))) + (switchState[2] * (pow(2, 2))) + (switchState[3] * (pow(2, 3)));
  // Serial.print('=');
  // Serial.println(selection);
  //---

  // SYSTEM FOR NEEDING 3 TRIES TO ACCEPT THE OBJECT DETECT (A SORT OF DEBOUNCING FOR WHEN PEOPLE HAVE A HARD TIME WITH THE INTERFACE)
  /*
  Serial.print("DETECT: ");
  Serial.println(currentDetection);

  if (currentDetection != previousDetection && !tryMode) {
    tryMode = true;
  } { 
    tryMode = false;
  }


  if (tryMode) {
    if (currentDetection == previousDetection) {
      Serial.print("TRY: ");
      Serial.println(detectionTries);
      detectionTries++;
    } else {
      detectionTries = 0;
    }

    if (detectionTries >= 2) {
      selection = currentDetection;
      Serial.print("SELECT: ");
      Serial.println(selection);
      detectionTries = 0;
      tryMode = false;
    }
  }

  // if (currentDetection == previousDetection) {
  //   Serial.print("TRY: ");
  //   Serial.println(detectionTries);
  //   detectionTries++;
  //   if (detectionTries >= 2) {
  //     selection = currentDetection;
  //     detectionTries = 0;
  //     Serial.print("SELECT: ");
  //     Serial.println(selection);
  //   }
  // } else {
  //   //detectionTries = 0;
  // }
  previousDetection = currentDetection;
 */

  Serial.println("==============");
  delay(detectionDelay);
}
