class Scanner {

  int figuId = 0;
  PImage outlineImage;
  float scanLinePosY = 0; // screen tilted 90deg (up -> down = right -> left)
  float scanLineVel = 3;


  Scanner() {
  }

  void setFigurineImages(PImage fImages) {
    outlineImage = fImages;
  }

  void setFigurineId(int id) {

    figuId = id;
  }

  void startScan() {
    scanLinePosY = 0;

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

    image(outlineImage, 0, height*0.5);



    popStyle();
  }
}
