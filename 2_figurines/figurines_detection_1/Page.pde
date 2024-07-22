class Page {

  PImage pageImage;
  float time = 0;
  float vel = 0.01;

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

    pushStyle();
    tint(255,time * 255);
    image(pageImage, 0, 0);
    popStyle();

  }
}
