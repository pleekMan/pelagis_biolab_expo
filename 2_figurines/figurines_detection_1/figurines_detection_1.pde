
int previousDetection = 0;
boolean checkDetectionMode = false;
int checkTries = 0;
int selection = 0;


Timer detectTimer;

//

int animalCount = 3;
PImage[] animalImages;
Page animalPage;
Scanner scanner;

boolean pageMode = false;


void setup() {
  size(1024, 600);

  animalImages = loadPageImages("pages/");
  scanner = new Scanner();
  animalPage = new Page();



  launchAnimal(0);


  detectTimer = new Timer(2000);
  detectTimer.start();
}

void draw() {
  background(0, 0, 30);

  //detectContinuosly();

  scanner.render();
  
  if(scanner.isFinished()){
   launchAnimal(selection); 
  }
  animalPage.render();
}


PImage[] loadPageImages(String path) {

  PImage[] pageImages = new PImage[animalCount];

  for (int i=0; i < animalCount; i++) {
    pageImages[i] = loadImage(path + "figurine_" + i + ".png");
  }

  return pageImages;
}

void loadScanImages() {
}


void detectContinuosly() {
  if (detectTimer.isFinished()) {
    detect(readSwitches());
    detectTimer.start();
  }
}

void launchScanner(int animalId) {
  scanner.startScan();
}

void launchAnimal(int animalId) {

  pageMode = true; // NOT USED

  animalPage.setImage(animalImages[animalId]);
  animalPage.start();
}

int readSwitches() {

  // SIMULATE 4 ON/OFF SWITCHES
  int[] pinState = {floor(random(2)), floor(random(2)), floor(random(2)), floor(random(2))};

  // DEMULTIPLEXING A 4 BIT BINARY TO DECIMAL
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
      launchAnimal(selection);
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
