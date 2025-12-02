BufferedReader reader;
String line;
int dial = 50;
int dialCount = 0;
int dialCount2 = 0;

void setup() {
  reader = createReader("input.txt");
  size(600, 600);
  frameRate(500);
}

void draw() {
  try {
    line = reader.readLine();
  }
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {// || dialCount == 100) {
    noLoop();
  } else {
    String[] pieces = split(line, 'L');
    int sign = 1;
    int amount = 0;
    if (pieces.length > 1) {
      sign = -1;
      amount = Integer.parseInt(pieces[1]);
    }
    pieces = split(line, 'R');
    if (pieces.length > 1) {
      amount = Integer.parseInt(pieces[1]);
    }
    
    int loopCount = amount;
    while (loopCount > 0) {
      if ((dial + sign * loopCount)%100 == 0) {
        dialCount2++;
      }
      loopCount--;
    }
    dial = (dial + sign * amount) % 100;
    if (dial < 0) {
       dial += 100; 
    }
    
    translate(300, 300);
    pushMatrix();
    strokeWeight(2);
    fill(200);
    circle(0, 0, 320);
    strokeWeight(3);
    fill(50);
    if (dial == 0) {
      fill(255, 70, 0);
      dialCount++;
    }    
    rotate(PI + 2 * PI * dial / 100);
    line(0, 0, 0, 150);    
    textSize(13);
    textAlign(CENTER);
    text(String.valueOf(dial), 0, 250 + 2 * (dial % 10));
    popMatrix();
    textSize(50);
    text(String.valueOf(dialCount), 0, 50);
    text(String.valueOf(dialCount2), 0, 100);
    
    //saveFrame("output/frames####.png");
  }
}
