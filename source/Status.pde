class Status {
  boolean s1, s2, s3, s4;  //  four states
  float p=50f;  // blocking probability
  boolean result[]=new boolean[4];

  Status(boolean b1, boolean b2, boolean b3, boolean b4) {
    // 16=2^4
    if (b1==true && b2==false && b3==false && b4==false) { 
      s1=false;
      s2=b2;
      s3=true;
      s4=b4;
    } else if (b1==false && b2==true && b3==false && b4==false) {  
      s1=b1;
      s2=false;
      s3=b3;
      s4=true;
    } else if (b1==true && b2==true && b3==false && b4==false) {  
      float odd=random(100);
      if (odd<p) {
        s1=b1;
        s2=b2;
        s3=b3;
        s4=b4;
      } else {
        s1=false;
        s2=false;
        s3=true;
        s4=true;
      }
    } else if (b1==true && b2==false && b3==true && b4==false) {  
      s1=false;
      s2=b2;
      s3=b3;
      s4=true;
    } else if (b1==false && b2==true && b3==true && b4==false) {  
      s1=b1;
      s2=false;
      s3=b3;
      s4=true;
    } else if (b1==true && b2==true && b3==true && b4==false) {   
      s1=b1;
      s2=false;
      s3=b3;
      s4=true;
    } else if (b1==true && b2==false && b3==false && b4==true) {  
      s1=false;
      s2=b2;
      s3=true;
      s4=b4;
    } else if (b1==false && b2==true && b3==false && b4==true) {  
      s1=b1;
      s2=false;
      s3=true;
      s4=b4;
    } else if (b1==true && b2==true && b3==false && b4==true) {  
      s1=false;
      s2=b2;
      s3=true;
      s4=b4;
    } else {  
      s1=b1;
      s2=b2;
      s3=b3;
      s4=b4;
    }
  }

  // update and new list
  boolean[] output() {
    boolean[] result={s1, s2, s3, s4};
    return result;
  }
}
