

import processing.serial.*;

import cc.arduino.*;
Arduino arduino;

void setup() {
  size(250, 100);

  println(Arduino.list());


  //arduino = new Arduino(this, Arduino.list()[9], 57600);
  arduino = new Arduino(this, "/dev/tty.usbmodem2101", 57600);

  for (int i=8; i <= 11; i++) {
    arduino.pinMode(i, Arduino.INPUT);
  }


  fill(0, 100, 200);
  noStroke();
}

void draw() {
  background(0);

  for (int i=0; i < 4; i++) {

    if (arduino.digitalRead(i+8) == Arduino.HIGH) {
      circle(width - (50 * (i+1)), 50, 50);
    }
  }
}
