class Scanner {

  int figuId = 0;
  PImage figuImages;
  float scanLinePosY = 0; // screen tilted 90deg (up -> down = right -> left)
  float scanLineVel = -5;

  Scanner() {
  }

  void setFigurineImages(PImage fImages) {
    figuImages = fImages;
  }

  void setFigurineId(int id) {

    figuId = id;
  }
  
  void startScan(){
    scanLinePosY = width;
  }
  
  boolean isFinished(){
   return scanLinePosY < 0;
  }

  void render() {
    scanLinePosY += scanLineVel;
    
    stroke(255,0,0);
    line(scanLinePosY, 0, scanLinePosY, height);
  }

}
