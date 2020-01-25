PImage bugCenter;
PImage bugAway;
PImage bugHome;
XML scoreSheet;

PFont din;
PFont sohoscore;

boolean newTransitionR = false;
boolean newTransitionL = false;
boolean leftBonus = false;
boolean rightBonus = false;
boolean tenthsMode;

String finalTenths = "";
String finalSeconds = "";
String finalMinutes = "";

float yLeftNew = 934;
float yLeftOld = 1034;
float yRightNew = 934;
float yRightOld = 1034;
float scoreEasing = 0.2;

int leftScore = 0;
int rightScore = 0;
int leftScoreNew = 0;
int rightScoreNew = 0;
int leftTimouts = 0;
int rightTimeouts = 0;
int leftFoul = 0;
int rightFoul = 0;
int quarter = 1;

void setup() {
  size(1920, 1080);

  din = createFont("DIN Alternate Bold.ttf", 100);
  sohoscore = createFont("soho/Soho Std Bold Condensed.otf", 100);


  bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  bugAway = loadImage("Livestream_Bug_V2_DATA/Away/Away_Test.png");
  bugHome = loadImage("Livestream_Bug_V2_DATA/Home/Home_Test.png");
}

void draw() {
  background(0, 177, 64);
  image(bugCenter, 0, 0);
  image(bugAway, 0, 0);
  image(bugHome, 0, 0);

  leftTeam();
  rightTeam();
}

void keyPressed() {
  if (key == ' ') {
    if(quarter < 4) {
      quarter++;
    } else {
      quarter = 1; 
    }
    bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  } else if (key == 'l') {
    if (leftScoreNew == leftScore) {
      leftScoreNew = leftScore + 1;
      newTransitionL = true;
    }
  } else if (key == 'k') {
    if (rightScoreNew == rightScore) {
      rightScoreNew = rightScore + 1;
      newTransitionR = true;
    }
  }
}

void mousePressed() {
  println(mouseX + " - " + mouseY);
}
