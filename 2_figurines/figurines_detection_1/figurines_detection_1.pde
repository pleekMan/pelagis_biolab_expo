
int previousDetection = 0;
boolean checkDetectionMode = false;
int checkTries = 0;
int selection = 0;


Timer detectTimer;

//

int animalCount = 11; // 10 animaux + 1 standby
PImage[] animalImages;
Page animalPage;
Scanner scanner;
boolean scannerMode = false;
boolean pageMode = false;

PImage pageFrame;


void setup() {
  size(600, 1024, P2D);

  pageFrame = loadImage("screenFrame.png");
  animalImages = loadPageImages("pages/");
  scanner = new Scanner();
  animalPage = new Page();



  launchAnimal(0);


  detectTimer = new Timer(2000);
  detectTimer.start();
}

void draw() {


  if (scannerMode) {

    fill(0, 10);
    rect(0, 0, width, height);
  } else {
    background(0);
  }
  //detectContinuosly();


  if (scannerMode) {
    scanner.render();

    if (scanner.isFinished()) {
      scannerMode = false;
      launchAnimal(selection);
    }
  }

  if (pageMode) {
    //println("=> PAGE MODE");
    animalPage.render();
  }

  image(pageFrame, 0, 0);
}


PImage[] loadPageImages(String path) {

  PImage[] pageImages = new PImage[animalCount];

  for (int i=0; i < animalCount; i++) {
    pageImages[i] = loadImage(path + "figurine_" + i + ".jpg");
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
  scannerMode = true;
  pageMode = false;


  scanner.setFigurineImages(loadImage("animalOutlines/figurine_1_outline.png"));
  scanner.startScan();
}

void launchAnimal(int animalId) {

  pageMode = true; // NOT USED
  scannerMode = false;

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
      launchScanner(selection);
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
  } else if (key == 'p') {
    launchAnimal(1);
  }
}
