PImage bugCenter;
PImage bugAway;
PImage bugHome;
XML scoreSheet;

PFont din;
PFont sohoscore;

boolean newTransitionHome = false;
boolean newTransitionAway = false;
boolean bonusAway = false;
boolean bonusHome = false;
boolean tenthsMode;

String finalTenths = "";
String finalSeconds = "";
String finalMinutes = "";

float yLeftNew = 934;
float yLeftOld = 1034;
float yRightNew = 934;
float yRightOld = 1034;
float scoreEasing = 0.2;

int scoreAway = 0;
int scoreHome = 0;
int newScoreAway = 0;
int newScoreHome = 0;
int timeoutsLeftAway = 0;
int timeoutsLeftHome = 0;
int foulsAway = 0;
int foulsHome = 0;
int quarter = 1;
int shotClockSeconds = 24;

void setup() {
  size(1920, 1080);

  din = createFont("DIN Alternate Bold.ttf", 100);
  sohoscore = createFont("soho/Soho Std Bold Condensed.otf", 100);


  bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  pushMatrix();
  bugAway = loadImage("Livestream_Bug_V2_DATA/Away/Away_Test.png");
  bugHome = loadImage("Livestream_Bug_V2_DATA/Home/Home_Test.png");
  popMatrix();
  //mask();
}

void draw() {
  pullXML();

  background(0, 177, 64);
  image(bugCenter, 0, 0);
  image(bugAway, 0, 0);
  image(bugHome, 0, 0);

  awayTeam();
  homeTeam();
  drawTime();
}

void keyPressed() {
  if (key == ' ') {
    if (quarter < 4) {
      quarter++;
    } else {
      quarter = 1;
    }
    bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  } else if (key == 'l') {
    if (newScoreAway == scoreAway) {
      newScoreAway = scoreAway + 1;
      newTransitionAway = true;
    }
  } else if (key == 'k') {
    if (newScoreHome == scoreHome) {
      newScoreHome = scoreHome + 1;
      newTransitionHome = true;
    }
  }

  
}

void mousePressed() {
  println(mouseX + " - " + mouseY);
}
