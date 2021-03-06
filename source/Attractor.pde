class Attractor extends VerletParticle2D {

  float r;

  Attractor (Vec2D loc) {
    super (loc);
    r = 24;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, width, 0.01));
  }

  void display () {
    fill(0);
    stroke(0,0,255);
    ellipse (x, y, r*2, r*2);
  }
}
