import java.io.*;
import processing.net.*;

Server bugServer;
PFont din;
PFont sohoscore;
boolean timeStarted = false;
boolean timeRunning = false;
boolean timeStopped = false;
boolean newTransitionR = false;
boolean newTransitionL = false;
boolean newTransitionMessage = false;
boolean transitioningMessage = false;
boolean messageIsShowing = false;
boolean messageIsMoving = false;
boolean leftLightMode = true;
boolean rightLightMode = false;
boolean leftBonus = true;
boolean rightBonus = true;
boolean scoreBoardTransitioning = false;
boolean scoreBoardShowing = false;
boolean tenthsMode = false;
float seconds = 0.00000;
float minutes = 12;
float currentTenths;
float currentSeconds;
float currentMinutes;
float startTime = 0;
float scoreEasing = 0.20;
float yLeftNew = -60;
float yLeftOld = 78;
float yRightNew = -60;
float yRightOld = 78;
float messageY = -40;
float messageEasing = 0.2;
float scoreBoardEasing = 0.2;
float displaceX;
float displaceY;
String finalTenths = "";
String finalSeconds = "";
String finalMinutes = "";
String bottomMessageLive = spacer("2018 basketball strathcona classic  |  final four");
String bottomMessageEdit = spacer("up next: scona vs. ross shepp (sr. women)");
String leftTeam = "Default";
String rightTeam = "Default";
String messageAction = "";
int leftScoreFill = 0;
int rightScoreFill = 0;
int leftScore = 0;
int rightScore = 0;
int leftScoreNew = 0;
int rightScoreNew = 0;
int quarter = 0;
int timeoutsL = 0;
int timeoutsR = 0;
int messageLiveOpacity = 255;
int messageEditOpacity = 0;
int tintL;
int tintR;
int scoreBoardWidth = 1500;
int scoreBoardHeight = 130;
int saveItems = 18;
int scoreBoardYUp = 300;
int scoreBoardYDown = 600;
color leftColor = #000000;
color rightColor = #ffffff;
color keyColor = #FF00F3;
//colorpalette: green:: #2e7d32 (light), teal:: #00695c (light), orange:: #ff6f00 (dark),  yellow/gold:: #fdd835 (dark), blue:: #0d47a1 (light), red:: #c62828 (light)
//keyColor palette green: #00ff00, pink: #FF00F3

void setup() {
  fullScreen(1);
  //size(1500, 130);
  background(255);
  //scoreboard goes till y=90, the remaining 40 pixels are for contextual information
  //surface.setVisible(false);
  noStroke();
  println();
  din = createFont("DIN Alternate Bold.ttf", 100);
  sohoscore = createFont("Soho Std Bold Condensed.otf", 100);
  bugServer = new Server(this, 5555);
  displaceX = (width-scoreBoardWidth)/2;
  displaceY = 300;
  loadData();
  currentSeconds = seconds;
  currentMinutes = minutes;
}

void draw() {
  background (keyColor);
  if (bugServer.available() != null) {
    Client currentClient = bugServer.available();
    String dataReceived = currentClient.readString();
    requestHandler(dataReceived, currentClient);
  }
  placeScoreBoard();
  pushMatrix();
  translate(displaceX,displaceY);
  if (messageIsMoving == true || messageIsShowing == false) {
    //message
    message();
  }
  //leftTeam
  leftTeam();
  //center
  center();
  //rightTeam
  rightTeam();
  //endteams
  if (messageIsShowing == true && messageIsMoving == false) {
    //message
    message();
  }
  //end message
  popMatrix();
  mask();
  saveData();
  //save("test.tiff");
  //println(frameRate);
}

void keyPressed() {
  if (key == ' ') {
    if (!timeRunning) {
      timeStarted = true;
      println("time started");
    } else {
      timeStopped = true;
      println("time stopped");
    }
  } else if (key == '1') {
    if (leftScoreNew == leftScore) {
      leftScoreNew = leftScore + 1;
      newTransitionL = true;
    }
  } else if (key == 'q' || key == 'Q') {
    if (leftScoreNew == leftScore) {
      leftScoreNew = leftScore + 2;
      newTransitionL = true;
    }
  } else if (key == 'a' || key == 'A') {
    if (leftScoreNew == leftScore) {
      leftScoreNew = leftScore + 3;
      newTransitionL = true;
    }
  } else if (key == 'z' || key == 'Z') {
    if (leftScoreNew == leftScore) {
      leftScoreNew--;
      newTransitionL = true;
    }
  } else if (key == '-') {
    if (rightScoreNew == rightScore) {
      rightScoreNew = rightScore + 1;
      newTransitionR = true;
    }
  } else if (key == 'p' || key == 'P') {
    if (rightScoreNew == rightScore) {
      rightScoreNew = rightScore + 2;
      newTransitionR = true;
    }
  } else if (key == 'l' || key == 'L') {
    if (rightScoreNew == rightScore) {
      rightScoreNew = rightScore + 3;
      newTransitionR = true;
    }
  } else if (key == ',') {
    if (rightScoreNew == rightScore) {
      rightScoreNew--;
      newTransitionR = true;
    }
  } else if (key == 't') {
    quarter++;
  } else if  (key == 'g') {
    if (quarter > 0) {
      quarter--;
    }
  } else if (key == 'y') {
    if (timeoutsL < 4) {
      timeoutsL++;
    }
  } else if (key == 'h') {
    if (timeoutsL > 0) {
      timeoutsL--;
    }
  } else if (key == 'u') {
    if (timeoutsR < 4) {
      timeoutsR++;
    }
  } else if (key == 'j') {
    if (timeoutsR > 0) {
      timeoutsR--;
    }
  } else if (key == ENTER) {
    if (!transitioningMessage) {
      newTransitionMessage = true;
      //println("enter pressed");
    }
  } else if (key == 'm') {
    if (messageIsShowing == false) {
      messageAction = "show";
    } else {
      messageAction = "hide";
    }
  } else if (key == 'b') {
    leftBonus = !leftBonus;
  } else if (key == 'f') {
    if (scoreBoardTransitioning == false) {
      scoreBoardTransitioning = true;
    }
  }
}
