

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

boolean messageDisplayingAway = false;
boolean messageDisplayingHome = false;
boolean messageDropingAway = false;
boolean messageDropingHome = false;
boolean messageRetractingAway = false;
boolean messageRetractingHome = false;

boolean bonusDownAway = false;
boolean bonusDownHome = false;

boolean changesMade = false;

String finalTenths = "";
String finalSeconds = "";
String finalMinutes = "";

float yLeftNew = 934;
float yLeftOld = 1034;
float yRightNew = 934;
float yRightOld = 1034;
float scoreEasing = 0.2;
float messageEasing = 0.2;

int scoreAway = 0;
int scoreHome = 0;
int newScoreAway = 0;
int newScoreHome = 0;
int timeoutsLeftAway = 0;
int timeoutsLeftHome = 0;
int foulsAway = 0;
int foulsHome = 0;

int dropFoulAwayX = 1056;
int dropFoulAwayY = 960;
int dropFoulHomeX = 340;
int dropFoulHomeY = 960;

String quarter = "1";
String shotClockSeconds = "24";

void setup() {
  size(1920, 1080);

  din = createFont("DIN Alternate Bold.ttf", 100);
  sohoscore = createFont("soho/Soho Std Bold Condensed.otf", 100);

  pullXML();

  bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  pushMatrix();
  bugAway = loadImage("Livestream_Bug_V2_DATA/Away/Away_Test.png");
  bugHome = loadImage("Livestream_Bug_V2_DATA/Home/Home_Test.png");
  popMatrix();
  //mask();

  noStroke();
}

void draw() {
  pullXML();

  if (changesMade) {
    background(0, 177, 64);

    dropFoulsAndBonusAway();
    dropFoulsAndBonusHome();

    image(bugAway, 0, 0);
    image(bugHome, 0, 0);
    image(bugCenter, 0, 0);

    awayTeam();
    homeTeam();
    drawTime();
  }
}
