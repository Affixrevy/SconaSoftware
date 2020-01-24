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

float yLeftNew = -60;
float yLeftOld = 78;
float yRightNew = -60;
float yRightOld = 78;
float scoreEasing = 0.2;

int leftScore = 0;
int rightScore = 0;
int leftScoreNew = 0;
int rightScoreNew = 0;
int leftTimouts = 0;
int rightTimeouts = 0;
int leftFoul = 0;
int rightFoul = 0;
int quarter = 0;

void setup() {
  size(1920, 1080);

  din = createFont("DIN Alternate Bold.ttf", 100);
  sohoscore = createFont("soho/Soho Std Bold Condensed.otf", 100);


  bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter1.png");
  bugAway = loadImage("Livestream_Bug_V2_DATA/Away/Away_Test.png");
  bugHome = loadImage("Livestream_Bug_V2_DATA/Home/Home_Test.png");
  
}

void draw() {
  image(bugCenter, 0, 0);
  image(bugAway, 0, 0);
  image(bugHome, 0, 0);

  leftTeam();
}

void keyPressed() {
  if (key == ' ') {
    bugCenter = loadImage("Artboard 1.png");
  } else if (key == 'l') {
    leftScoreNew ++; 
  }
}

void mousePressed() {
  println(mouseX + " - " + mouseY);
}
