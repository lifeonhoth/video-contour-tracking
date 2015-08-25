import gab.opencv.*;

import processing.video.*;


Movie myMovie;

OpenCV opencv;

PImage src, dst;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

void setup() {
  //size(640, 360);
  size(568, 320);
  //myMovie = new Movie(this, "MARTHA_1974_-_720.mp4");
  myMovie = new Movie(this, "IMG_1460.mov");
 //myMovie = new Camera();  //connect webcam for live contour tracking.
  myMovie.loop();
  
  
  
  src = myMovie;
  
}

void draw() {
 background(0);
 
  ///////////////////////////
  opencv = new OpenCV(this, src);
  
  opencv.gray();
  opencv.threshold(70);
  dst = opencv.getOutput();
  
  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  ///////////////////////////
  
  //image(myMovie, 0, 0);
  image(dst, 640, 0);
  
  noFill();
  strokeWeight(1.5);

  
  for (Contour contour : contours){
    strokeWeight(1);
    //stroke(50, 125, 175);
    stroke(20, 225, 20);
    //stroke(200, 100, 75);
    contour.draw();
 
    stroke(175, 50, 75);
    beginShape();
    for(PVector point : contour.getPolygonApproximation().getPoints()){
      vertex(point.x, point.y);
    }
    endShape();
  }
    
  if (mousePressed){
    image(myMovie, 0, 0);
  }

}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}



