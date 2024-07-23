class Page {

  PImage pageImage;
  float time = 0;
  float vel = 0.04;

  Page() {
  }

  void setImage(PImage p) {
    pageImage = p;
  }

  void start() {
    time = 0;

    println("=> PAGE MODE : START");
  }

  void end() {
  }

  void render() {
    time += vel;
    time = constrain(time,0,1);

    pushStyle();
    tint(255,time * 255);
    image(pageImage, 0, 0);
    popStyle();

  }
}
