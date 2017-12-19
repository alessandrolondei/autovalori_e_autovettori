int maxS = 2;
PVector v1;
PVector v2;
PVector vp1;
PVector vp2;
PVector a;
PVector a1;
color c1 = color(255, 0, 0);
color c2 = color(0, 0, 255);
color c1l = color(150, 35, 10);
color c2l = color(35, 10, 150);
color ca = color(200, 200, 200);
color ca1 = color(0, 0, 0);
int state = 0;


void setup() {
  size(1080, 720);
  smooth(0);
  reset();
}

void draw() {
  PVector vp, vtemp;
  background(255,255,255);
  pushMatrix();
  translate(width/2, height/2);
  drawAxis();
  draw_line_from_vector(v1, c1l);
  draw_line_from_vector(v2, c2l);
  draw_vector(a, ca, 3);
  draw_vector(a1, ca1, 3);
  vtemp = getProjOnEig(a1, v1, v2);
  vp1.set(v1.x*vtemp.x,v1.y*vtemp.x,0);
  vp2.set(v2.x*vtemp.y,v2.y*vtemp.y,0);
  draw_vector(vp1, c1, 3);
  drawProjLine(a1, vp1, c1);
  draw_vector(vp2, c2, 3);
  drawProjLine(a1, vp2, c2);
  
  writeVecName(a,"a");
  writeVecName(a1,"a'");
  
  popMatrix();
  
  writeText();
  
  if(mousePressed) {
    onMousePressed();
  }
  
}


///// Functions

void writeVecName(PVector v, String s) {
  PVector w;
  PVector w1;
  w = trans_vector(v);
  float mag = w.mag();
  w1 = w.copy();
  w1.setMag(mag+18);
  text(s,w1.x,-w1.y);
}


void writeText() {
  fill(0, 0, 0);
  if (state == 0) {
    text("Eigenvectors: Both",950,100);
  }
  else if (state == 1) {
    text("Eigenvectors: 1",950,100);
  }
  else if (state == 2) {
    text("Eigenvectors: 2",950,100);
  }
  
  int l = 6;
  String ss = str(a.mag());
  if(ss.length()>l)
    ss = ss.substring(0,l);
  text("|a|: "+ss,950,135);
  ss = str(a1.mag());
  if(ss.length()>l)
    ss = ss.substring(0,l);
  text("|a'|: "+ss,950,150);
  if(abs(vp1.x)>0.001) ss = str(vp1.x);
  else ss = str(0.0);
  if(ss.length()>l)
    ss = ss.substring(0,l);
  text("vp1: ["+ss+", ",950,175);
  if(abs(vp1.y)>0.001) ss = str(vp1.y);
  else ss = str(0.0);
  if(ss.length()>l)
    ss = ss.substring(0,l);
  text(ss+"]",980,190);
  if(abs(vp2.x)>0.001) ss = str(vp2.x);
  else ss = str(0.0);
  if(ss.length()>l)
    ss = ss.substring(0,l);
  text("vp2: ["+ss+", ",950,205);
  if(abs(vp2.y)>0.001) ss = str(vp2.y);
  else ss = str(0.0);
  if(ss.length()>l)
    ss = ss.substring(0,l);
  text(ss+"]",980,220);
  
}


void reset() {
  v1 = new PVector(-2, 3, 0);
  v2 = new PVector(1, 1, 0);
  v1.normalize();
  v2.normalize();
  vp1 = new PVector(0, 0, 0);
  vp2 = new PVector(0, 0, 0);
  a = new PVector(-1, 0.5, 0);
  a1 = a.copy();
  state = 0;
}

void reset1() {
  v1 = new PVector(-2, 3, 0);
  v2 = new PVector(3, 2, 0);
  v1.normalize();
  v2.normalize();
  vp1 = new PVector(0, 0, 0);
  vp2 = new PVector(0, 0, 0);
  a = new PVector(-1, 0.5, 0);
  a1 = a.copy();
  state = 0;
}

void reset2() {
  v1 = new PVector(-2, 3, 0);
  v2 = new PVector(0, -1, 0);
  v1.normalize();
  v2.normalize();
  vp1 = new PVector(0, 0, 0);
  vp2 = new PVector(0, 0, 0);
  a = new PVector(-1, 0.5, 0);
  a1 = a.copy();
  state = 0;
}

void drawAxis() {
  stroke(50, 50, 50);
  strokeWeight(1);
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);
}

void draw_vector(PVector v, color c, int tickn) {
  PVector w;
  w = trans_vector(v);
  drawArrow(0, 0, w.mag(), w.heading(), c, tickn);
}

PVector trans_vector(PVector v) {
  PVector x = new PVector(0, 0, 0);
  x.x = (v.x * height/2) / maxS;
  x.y = (v.y * height/2) / maxS;
  return x;
}


void draw_line_from_vector(PVector v, color c) {
  PVector w0 = new PVector(0, 0, 0);
  PVector w1 = new PVector(0, 0, 0);
  stroke(c);
  strokeWeight(1);
  if (v.x==0) {
    line(0, -5*maxS, 0, 5*maxS);
  } else {
    PVector x0 = new PVector(-5*maxS, 0, 0);
    PVector x1 = new PVector(5*maxS, 0, 0);
    x0.y = x0.x * v.y/v.x;
    x1.y = x1.x * v.y/v.x;
    w0 = trans_vector(x0);
    w1 = trans_vector(x1);
    line(w0.x, -w0.y, w1.x, -w1.y);
  }
}


void drawArrow(int cx, int cy, float len, float angle, color c, int thickn) {
  pushMatrix();
  translate(cx, cy);
  rotate(-angle);
  stroke(c);
  strokeWeight(thickn);
  line(0, 0, len, 0);
  line(len, 0, len-8, -6);
  line(len, 0, len-8, 6);
  popMatrix();
}


PVector getProjOnEig(PVector a1, PVector v1, PVector v2) {
  float alfa, beta;
  if(v1.x==0.0) {
    alfa = a1.x;
    beta = 0.0;
  }
  else {
    beta = (a1.x*v1.y/v1.x - a1.y) / (v1.y*v2.x/v1.x - v2.y);
    alfa = (a1.x - beta*v2.x)/v1.x;
  }
  PVector out = new PVector(alfa, beta, 0);
  return out;
}


void drawProjLine(PVector a1, PVector vp, color c) {
  PVector w1, w2;
  PVector wd = new PVector(0, 0, 0);
  float tt = 6;
  boolean dash = true;
  w1 = trans_vector(a1);
  w2 = trans_vector(vp);
  wd.x = w2.x - w1.x;
  wd.y = -w2.y + w1.y;
  pushMatrix();
  translate(w1.x, -w1.y);
  rotate(wd.heading());
  float l = wd.mag();
  int ntt = round(l/tt);
  stroke(c);
  for (int k = 0; k < ntt; k+=1) {
    if (dash) {
      stroke(c);
      strokeWeight(1);
      line(k*tt,0,(k+1)*tt,0);
    }
    else {
      noStroke();
    }
    dash = !dash;
  }
  popMatrix();
}

void keyPressed() {
  // Select eigenvector 1 for rotation
  if(key=='1') state = 1;
  // Select eigenvector 2 for rotation
  else if(key=='2') state = 2;
  // Reset the eigenvectors to the original state
  else if(key=='r') reset();
  // Reset the eigenvectors to the new orthogonal state
  else if(key=='t') reset1();
  // Reset the eigenvectors to a different state
  else if(key=='g') reset2();
  // Make the eigenvectors a orthonormal base
  else if(key=='o') orthog();
  // Select both eigenvectors for rotation
  else state = 0;
}

void onMousePressed() {
  PVector vt1, vt2, vpt1, vpt2;
  float mag1, mag2;
 
  float rot = -((float)mouseX/(width/2)-1)*0.02;
  
  float ang1 = v1.heading()+rot;
  vt1 = PVector.fromAngle(ang1);
  vt1.normalize();
  
  ang1 = vp1.heading()+rot;
  mag1 = vp1.mag();
  vpt1 = PVector.fromAngle(ang1);
  vpt1.mult(mag1);
  
  float ang2 = v2.heading()+rot;
  vt2 = PVector.fromAngle(ang2);
  vt2.normalize();
  
  ang2 = vp2.heading()+rot;
  mag2 = vp2.mag();
  vpt2 = PVector.fromAngle(ang2);
  vpt2.mult(mag2);
  if(state==1) {
    v1 = vt1.copy();
    vp1 = vpt1.copy();
  }
  else if(state==2) {
    v2 = vt2.copy();
    vp2 = vpt2.copy();
  }
  else {
    v1 = vt1.copy();
    v2 = vt2.copy();
    vp1 = vpt1.copy();
    vp2 = vpt2.copy();
  }
  
  a1.set(vp1.x+vp2.x,vp1.y+vp2.y);
}


void orthog() {
  float mv1 = vp1.mag();
  float mv2 = vp2.mag();
  vp1.set(mv1,0,0);
  v1.set(1,0,0);
  vp2.set(0,mv2,0);
  v2.set(0,1,0);
  a1.set(vp1.x + vp2.x,vp1.y + vp2.y);
}