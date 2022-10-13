PVector startPos;
FlowerOfLife flowerPoints;
int noOfPoints, noOfParticles;
float noiseScale, circleSize;
Particle[] particles; 
JSONArray flowerDataArray;
JSONObject flowerData;
OpenSimplexNoise openSimplex;
float flowerAttraction, centreAttraction, randomness, particleMaxSpeed;
Particle controller;
float controllerXSpeed, controllerYSpeed, controllerXSize, controllerYSize, controllerXOffset, controllerYOffset;
//float p;

float startFrame, gifLength;

void setup() {
  size(800, 800);
  //frameRate = 60;
  noOfPoints = 50;
  noOfParticles = 5000;
  particles = new Particle[noOfParticles];
  circleSize = 300;
  flowerPoints = new FlowerOfLife(noOfPoints, circleSize);
  
  openSimplex = new OpenSimplexNoise(12345);
  noiseScale = 10;
  
  controller = new Particle(new PVector(0,0), .1);

  startFrame = 106;
  gifLength = 429;
  
  flowerDataArray = loadJSONArray("flowerData.json");
  flowerData = flowerDataArray.getJSONObject(0);
  
  //Fave 1
  controllerXSpeed = flowerData.getFloat("controllerXSpeed");
  controllerYSpeed = flowerData.getFloat("controllerYSpeed");
  controllerXSize = flowerData.getFloat("controllerXSize");
  controllerYSize = flowerData.getFloat("controllerYSize");
  controllerXOffset = flowerData.getFloat("controllerXOffset");
  controllerYOffset = flowerData.getFloat("controllerYOffset");
  randomness = flowerData.getFloat("randomness");
  particleMaxSpeed = flowerData.getFloat("particleMaxSpeed");

  particles = new Particle[noOfParticles];
  
  for (int i = 0; i < particles.length; i++) {
    float angle = random(TWO_PI);
    particles[i] = new Particle(new PVector(
      cos(angle) * random(width/3),
      sin(angle) * random(width/3)
      //random(-(width/2-200), (width/2-200) ), 
      //random(-(width/2-200), (width/2-200) )
    ), particleMaxSpeed);
    
  }
}

void draw() {

  startPos = new PVector(width/2, height/2);

  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();
  translate(startPos.x, startPos.y);
  rotate(TWO_PI/gifLength * frameCount/2);

  float controllerPosX = sin(frameCount * controllerXSpeed) * controllerXSize + controllerXOffset;
  if ( controllerPosX > -10 && controllerPosX < 10 ) println(frameCount);
  float controllerPosY = cos(frameCount * controllerYSpeed) * controllerYSize + controllerYOffset;
  
  //float controllerPointValue = openSimplex.noise2D(1/10,frameCount/10) * 228;
  float controllerPointValue = 228;
  
  controller.pos = new PVector(controllerPosX, controllerPosY);
  //controller.show(controllerPointValue,5);

  flowerAttraction = map(controllerPosY, 0, height, 0, 10);
  centreAttraction = map(controllerPosX, 0, width, -0.0005, 0.2);

  //particles.forEach(p => {
  for (int i = 0; i < particles.length; i++) {
    float particleValue = (float)(openSimplex.eval(i/noiseScale,frameCount/noiseScale) + 0.75) * 128;
    float particleSize = (float)(openSimplex.eval(i/noiseScale,frameCount/noiseScale) + 1.75) * 2;
    //float particleValue = 228;
    //float particleSize = 2;
    
    particles[i].show(particleValue, particleSize);
    particles[i].addForce(new PVector(random(-.1,.1),random(-.1,.1)).mult(randomness));
    particles[i].addForce(getDirectionToNearestFlowerPosition(particles[i].pos).mult(flowerAttraction));
    
    //centreAttraction *= (dist(0,0, particles[i].pos.x, particles[i].pos.y)* 0.001);
    //particles[i].maxSpeed = map(flowerAttraction, 0, 5, 4, 0);
    
    PVector centre = new PVector(0,0);
    particles[i].addForce(centre.sub(particles[i].pos).mult(centreAttraction));
    
    particles[i].update();
    //particles[i].edges();
  }


  //flowerPoints.circles.forEach(circle => {
    //circle.draw(255, 1);
  //});

  if (frameCount > startFrame && frameCount <= startFrame + gifLength) {
    //saveFrame("/gif2/fr###.gif");
  }
  
  
  //noLoop();
}


PVector getDirectionToNearestFlowerPosition(PVector particlePos) {
  
  float currentClosestDist = width * 10;
  PVector currentClosestPoint = null;
  
  for (int c = 0; c < flowerPoints.circles.length; c++) {
    for (int p = 0; p < flowerPoints.circles[c].pointPositions.length; p++) {
      
      float distToPoint = dist(particlePos.x, particlePos.y, flowerPoints.circles[c].pointPositions[p].x, flowerPoints.circles[c].pointPositions[p].y);
      if ( distToPoint < currentClosestDist) {
        currentClosestDist = distToPoint;
        currentClosestPoint = flowerPoints.circles[c].pointPositions[p];
      };
    }
  }

  PVector dir = currentClosestPoint.copy();
  dir.sub(particlePos);

  return dir;
}
