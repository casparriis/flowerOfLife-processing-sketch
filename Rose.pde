class Rose {

    // Generate a rose pattern according to polar coordinates with the formula r = cos(k*theta)

    PVector[] points;
    float k;
    float d;

    Rose (int noOfPoints, float size, float n, float d) {
      this.k = n / d;
      this.d = d;
      this.points = this.createPoints(noOfPoints, size);
    }
    
    PVector[] createPoints(int noOfPoints, float size) {
      
      println(this.k + ", " + this.d);
      PVector[] points = new PVector[noOfPoints];

      for (int i = 0; i < points.length; ++i) {
        float a = TWO_PI * this.d / points.length * i;
        float r = cos(this.k * a) * size;
        //println(a + ", " + r);
        points[i] = new PVector(
          cos(a) * r,
          sin(a) * r
        );
      }

      return points;
    }
  
  }
  
