class Particle extends VerletParticle2D {

  float r;
  color color1;
  Particle(Vec2D loc,color c) {
    super(loc);
    r = 5;
    color1=c;
    physics.addParticle(this);
    //physics.addBehavior(new AttractionBehavior(this, 0, -1));
  }

  void display () {
    fill (color1);
    stroke (color1);
    strokeWeight(2);
    ellipse (x, y, r*2, r*2);
  }
}
