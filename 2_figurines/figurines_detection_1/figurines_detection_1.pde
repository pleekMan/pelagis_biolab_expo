
int previousDetection = 0;
boolean checkDetectionMode = false;
int checkTries = 0;
int selection = 0;


Timer detectTimer;
Timer standByTimer;

//

int animalCount = 11; // 10 animaux + 1 standby
PImage[] animalImages;
PImage[] animalOutlines;
Page animalPage;
Scanner scanner;
boolean scannerMode = false;
boolean pageMode = false;

PImage pageFrame;


void setup() {
  size(600, 1024, P2D);
  frameRate(60);

  pageFrame = loadImage("screenFrame.png");
  animalImages = loadPageImages("pages/");
  animalPage = new Page();

  animalOutlines = loadAnimalOutlines("animalOutlines/");
  scanner = new Scanner();
  scanner.setScannerHeaderImage(animalOutlines[0]);

  detectTimer = new Timer(2000);
  detectTimer.start();

  standByTimer = new Timer(20000);
  standByTimer.start();


  launchAnimal(0);
}

void draw() {

  //detectContinuosly();

  if (scannerMode) {

    fill(0, 10);
    rect(0, 0, width, height);
  } else {
    background(0);
  }



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

    if (standByTimer.isFinished() && selection != 0) {
      selection = 0;
      launchAnimal(selection); // animalPage 0 is the standBy Page
      standByTimer.start();
    }
  }

  image(pageFrame, 0, 0);

  drawMiscellanea();

  pushStyle();
  fill(255, 0, 0);
  text(mouseX + " | " + mouseY, 30, 15);
  popStyle();
}


PImage[] loadPageImages(String path) {

  PImage[] pageImages = new PImage[animalCount];

  for (int i=0; i < animalCount; i++) {
    pageImages[i] = loadImage(path + "figurine_" + i + ".jpg");
  }

  return pageImages;
}

PImage[] loadAnimalOutlines(String path) {

  PImage[] aOutlines = new PImage[animalCount];

  for (int i=0; i < animalCount; i++) {
    aOutlines[i] = loadImage(path + "figurine_" + i + "_outline.png");
  }

  return aOutlines;
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


  scanner.setOutlineImages(animalOutlines[animalId]);
  scanner.startScan();
}

void launchAnimal(int animalId) {

  pageMode = true; // NOT USED
  scannerMode = false;

  animalPage.setImage(animalImages[animalId]);
  animalPage.start();

  standByTimer.start();
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

void drawMiscellanea() {

  // DISCRETE PROGRESS BAR TOP RIGHT - BEGIN
  int left = 544;
  int top = 97;
  int w = 7;
  int h = 13;

  noStroke();
  fill(frameCount % 200 > 40 ? 255 : 0);
  rect(left, top, w, h);
  fill(frameCount % 200 > 60 ? 255 : 0);
  rect(left, top + (h + 2), w, h);
  fill(frameCount % 200 > 70 ? 255 : 0);
  rect(left, top + ((h+2)*2), w, h);
  
  // DISCRETE PROGRESS BAR TOP RIGHT - END
  
  // LITTLE ELEVATORS LEFT CENTER - BEGIN
  fill(255);
  float motionS = sin(frameCount * 0.01);
  ellipse(28,map(motionS,-1,1,490,770),10,3);
  float motionC = cos(frameCount * 0.01);
  ellipse(38,map(motionC,-1,1,490,770),10,3);
  // LITTLE ELEVATORS LEFT CENTER - END
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
