class Particle {
    PVector pos;
    PVector vel;
    PVector acc;
    float maxSpeed;
    
  
    Particle () {
        this.pos = new PVector(0,0);
        this.vel = new PVector(0,0);
        this.acc = new PVector(0,0);
        this.maxSpeed = 2;
    }

    void update() {
        this.vel.add(this.acc);
        this.vel.limit(this.maxSpeed);
        this.pos.add(this.vel);
        this.acc.mult(0);
    }

    void addForce(PVector force) {
        this.acc.add(force);
    }

    void show(float value, float size) {
        strokeWeight(size);
        stroke(value);
        point(this.pos.x, this.pos.y);
    }

    void edges() {
        if (this.pos.x > width/2 -100) this.pos.x = -width/2 + 100;
        if (this.pos.x < -width/2 + 100) this.pos.x = width/2 - 100;
        if (this.pos.y > height/2 -100) this.pos.y = -height/2 + 100;
        if (this.pos.y < -height/2 +100) this.pos.y = height/2 - 100;
    }

    
}
