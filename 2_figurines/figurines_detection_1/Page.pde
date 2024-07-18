class Page {

  PImage pageImage;
  float opacity = 255;

  Page() {
  }

  void setImage(PImage p) {
    pageImage = p;
  }

  void start() {
  }

  void end() {
  }

  void render() {
    tint(255, opacity);
    image(pageImage, 0, 0);
  }
}
