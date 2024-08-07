class Scanner {

  int figuId = 0;
  PImage outlineImage;
  PImage scannerHeader;
  float scanLinePosY = 0; // screen tilted 90deg (up -> down = right -> left)
  float scanLineVel = 3;


  Scanner() {
  }

  void setOutlineImages(PImage fImages) {
    outlineImage = fImages;
  }

  void setScannerHeaderImage(PImage hImage) {
    scannerHeader = hImage;
  }

  void setFigurineId(int id) {

    figuId = id;
  }

  void startScan() {
    scanLinePosY = 150;

    // RESET BACKGROUND BEFORE START OF SCANNING TRAIL EFFECT
    fill(0);
    rect(0, 0, width, height);
  }

  boolean isFinished() {
    return scanLinePosY >= height;
  }

  void render() {

    scanLinePosY += scanLineVel;
    //scanLinePosY = mouseY;

    image(scannerHeader, 0, 0);
    drawMiscellanea();

    pushStyle();

    //blendMode(SCREEN);


    rectMode(CENTER);
    for (int i=0; i < 5; i++) {
      float epaisseur = i * 10;

      color c = color(0, 30, 320, (255 - (i * 30)));

      fill(c);
      noStroke();
      //rect((width * 0.5) - (width * 0.5), scanLinePosY - epaisseur, (width * 0.5) + (width * 0.5),scanLinePosY + epaisseur);
      rect(width * 0.5, scanLinePosY - 20, width, epaisseur);
    }

    stroke(abs(sin(frameCount * 0.1)) * 255);
    line(0, scanLinePosY - 2, width, scanLinePosY - 2);
    line(0, scanLinePosY, width, scanLinePosY);
    line(0, scanLinePosY + 2, width, scanLinePosY + 2);

    if (scanLinePosY % 20 == 0) {
      stroke(255);
      line(0, scanLinePosY - 40, width, scanLinePosY  - 40);
    }

    image(outlineImage, 0, height*0.5);


    popStyle();
  }

  void drawMiscellanea() {

    float scanProgress = map(scanLinePosY, 0, height, 0, 1);

    noStroke();
    // PROGRESS BAR - BEGIN
    fill(255);
    rect(138, 90, (494 - 140) * scanProgress, 103 - 89 );
    // PROGRESS BAR - END

    // BLINKING DOTS - BEGIN
    fill(frameCount % 10 > 5 ? 255 : 0);
    circle(66, 90, 3);
    fill(frameCount % 20 > 10 ? 255 : 0);
    circle(111, 98, 3);
    fill(frameCount % 20 > 5 ? 255 : 0);
    circle(52, 114, 3);
    fill(frameCount % 20 > 17 ? 255 : 0);
    circle(97, 107, 3);
    // BLINKING DOTS - END

  }
}
