
int previousDetection = 0;
boolean checkDetectionMode = false;
int checkTries = 0;
int selection = 0;

Timer detectTimer;

void setup() {

  detectTimer = new Timer(2000);
  detectTimer.start();
}

void draw() {


  if (detectTimer.isFinished()) {
    detect(readSwitches());
    detectTimer.start();
  }
  
}

int readSwitches() {

  // SIMULATE 4 ON/OFF SWITCHES
  int[] pinState = {floor(random(2)), floor(random(2)), floor(random(2)), floor(random(2))};

  int selection = 0;
  for (int i=0; i < pinState.length; i++) {
    selection += pinState[i] * (pow(2, i)); // selection = digitalRead(pinState[i]);
  }
  println("Selection = " + selection);

  return selection;
}

void detect(int currentDetection) {
  // SYSTEM TO "DEBOUNCE" WHEN PARTICIPANTS INSERT THE FIGURINE INTO THE SLOT
  // => ONLY SET selection IF FIGURINES HAS BEEN DETECTED MORE THAN verifyAfter
  // RESTART DEBOUNCING WHEN DETECTED FIGURINE CHANGES
  int verifyAfter = 3;

  println("---- Detections = " +  previousDetection +  " > " + currentDetection );

  if (currentDetection != previousDetection) {
    checkDetectionMode = true;
    checkTries = 0;
    println("=> CheckMode: ON");
  }

  if (checkDetectionMode) {
    println(" => CheckTry: " + checkTries);

    if (checkTries >= verifyAfter) {
      selection = currentDetection;
      checkDetectionMode = false;
      println("====> Final Selection: " + selection);
    }
    checkTries++;
  }
  previousDetection = currentDetection;
  println("");
}

void keyPressed() {

  if (key == 'd') {
    detect(readSwitches());
  } else if (key == '1') {
    detect(1);
  } else if (key == '2') {
    detect(2);
  } else if (key == '3') {
    detect(3);
  } else if (key == '4') {
    detect(4);
  }
}
