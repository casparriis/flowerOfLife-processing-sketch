class FlowerOfLife {

    Circle[] circles;

    FlowerOfLife (int noOfPoints, float circleSize) {
      this.circles = this.createCircles(noOfPoints, circleSize);
  
    }
  
    Circle[] createCircles(int noOfPoints, float circleSize) {
      Circle[] circles = new Circle[0];
      Circle circle1 = new Circle(0, 0, noOfPoints, circleSize);
      circles = (Circle[])append(circles, circle1);
  
      //Add circles for the first row
      for (int i = 1; i < 7; i++) {
        float x1 = cos((PI / 3) * (i + 5)) * circleSize / 2;
        float y1 = sin((PI / 3) * (i + 5)) * circleSize / 2;
        circles = (Circle[])append(circles, new Circle(x1, y1, noOfPoints, circleSize));
  
        //Second row
        //for (int j = 1; j < 3; j++) {
        //float x2 = cos((PI / 3) * (j + 4 + i)) * circleSize / 2 + x1;
        //float y2 = sin((PI / 3) * (j + 4 + i)) * circleSize / 2 + y1;
        //circles = (Circle[])append(circles, new Circle(x2, y2, noOfPoints, circleSize));
  
        // //   // //Third row
        // //   // for (let k = 1; k < 2; k++) {
  
        // //   //   let x3 = cos((PI / 3) * (k + 4 + i)) * circleSize / 2 + x2;
  
        // //   //   let y3 = sin((PI / 3) * (k + 4 + i)) * circleSize / 2 + y2;
  
        // //   //   circles.push(new Circle(x3, y3, noOfPoints, circleSize, color(255, 255, 255)));
  
        // //   //   if (j == 2) {
        // //   //     let x3a = cos((PI / 3) * (k + 5 + i)) * circleSize / 2 + x2;
  
        // //   //     let y3a = sin((PI / 3) * (k + 5 + i)) * circleSize / 2 + y2;
        // //   //     circles.push(new Circle(x3a, y3a, noOfPoints, circleSize, color(255, 255, 0)));
        // //   //   }
  
        // //   // }
        //}
      }
  
      return circles;
    }
  
  }
  
