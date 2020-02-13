//Initiate three main parts of the scoreboard
PImage bugCenter;
PImage bugAway;
PImage bugHome;

//Initiate variables for properly masking the score
PImage scoreMaskHome;
PImage scoreMaskAway;
PGraphics scoreHomeNumber;
PGraphics scoreAwayNumber;

//Initiate variable for the Nevco XML sheet
XML scoreSheet;

//Initiate variables for the font
PFont din;
PFont sohoscore;

//Initiate variables for drop down bonus
boolean newTransitionHome = false;
boolean newTransitionAway = false;
boolean bonusAway = false;
boolean bonusHome = false;
boolean tenthsMode;

boolean messageDisplayingHome = false;
boolean messageDisplayingAway = false;
boolean messageDropingHome = false;
boolean messageDropingAway = false;
boolean messageRetractingHome = false;
boolean messageRetractingAway = false;

boolean bonusDownAway = false;
boolean bonusDownHome = false;

boolean changesMade = true;

String finalTenths = "";
String finalSeconds = "";
String finalMinutes = "";

float yLeftNew = 934;
float yLeftOld = 1034;
float yRightNew = 934;
float yRightOld = 1034;
float scoreChange = 0.25;
float messageEasing = 0.2;

int scoreAway = 0;
int scoreHome = 0;
int newScoreAway = 0;
int newScoreHome = 0;
int timeoutsLeftAway = 0;
int timeoutsLeftHome = 0;
int foulsAway = 0;
int foulsHome = 0;

int dropFoulHomeX = 1057;
int dropFoulHomeY = 960;
int dropFoulAwayrX = 760;
int dropFoulAwayY = 960;

String quarter = "1";
String shotClockSeconds = "24";

void setup() {
  size(1920, 1080);

  din = createFont("DIN Alternate Bold.ttf", 100);
  sohoscore = createFont("soho/Soho Std Bold Condensed.otf", 100);

  pullXML();

  bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  bugAway = loadImage("Livestream_Bug_V2_DATA/Away/Away_Test_2.png");
  bugHome = loadImage("Livestream_Bug_V2_DATA/Home/Home_Test_2.png");

  scoreMaskHome = loadImage("Livestream_Bug_V2_DATA/Mask_Home.png");
  scoreMaskAway = loadImage("Livestream_Bug_V2_DATA/Mask_Away.png");
  scoreHomeNumber = createGraphics(1920, 1080);
  scoreAwayNumber = createGraphics(1920, 1080);

  noStroke();

}

void draw() {
  pullXML();

  background(0, 177, 64);

  dropFoulsAndBonusAway();
  dropFoulsAndBonusHome();

  image(bugAway, 0, 0);
  image(bugHome, 0, 0);
  image(bugCenter, 0, 0);

  awayTeam();
  homeTeam();
  drawTime();
  changesMade = false;

}
