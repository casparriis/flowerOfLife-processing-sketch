class Circle {

    float centreX, centreY, circleSize; 
    int noOfPoints;
    color colour;
    PVector[] pointPositions = new PVector[0];

  Circle(float centreX, float centreY, int noOfPoints, float circleSize) {
    this.centreX = centreX;
    this.centreY = centreY;
    this.noOfPoints = noOfPoints;

    this.pointPositions = this.createPoints(circleSize);
    //this.draw();
  }

  PVector[] createPoints(float circleSize) {
    PVector[] points = new PVector[this.noOfPoints];

    for (int i = 0; i < points.length; i++) {
      points[i] = new PVector(
        cos(TWO_PI / points.length * (i + 1)) * circleSize / 2 + this.centreX,
        sin(TWO_PI / points.length * (i + 1)) * circleSize / 2 + this.centreY
      );
    }

    return points;
  }

  void draw(float value, float size) {
    push();
    //translate(this.centreX, this.centreY);
    //fill(255);
    //fill(this.color);
    stroke(255);
    strokeWeight(size);

    for (int i = 0; i < this.pointPositions.length; ++i) {
      PVector p = this.pointPositions[i];
      point(p.x, p.y, 0);
    }

    pop();
  }

}
