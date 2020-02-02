import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.*; 
import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class liveStreamBug_Net extends PApplet {




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
float seconds = 0.00000f;
float minutes = 12;
float currentTenths;
float currentSeconds;
float currentMinutes;
float startTime = 0;
float scoreEasing = 0.20f;
float yLeftNew = -60;
float yLeftOld = 78;
float yRightNew = -60;
float yRightOld = 78;
float messageY = -40;
float messageEasing = 0.2f;
float scoreBoardEasing = 0.2f;
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
int leftColor = 0xff000000;
int rightColor = 0xffffffff;
int keyColor = 0xffFF00F3;
//colorpalette: green:: #2e7d32 (light), teal:: #00695c (light), orange:: #ff6f00 (dark),  yellow/gold:: #fdd835 (dark), blue:: #0d47a1 (light), red:: #c62828 (light)
//keyColor palette green: #00ff00, pink: #FF00F3

public void setup() {
  
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

public void draw() {
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

public void keyPressed() {
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
public void center() {
  rectMode(CORNERS);
  fill(0xff424242);
  rect(650, 0, 850, 90);
  fill(255);
  textFont(din);
  textSize(55);
  textAlign(CENTER);
  timer();
  stringify();
  if (!tenthsMode) {
    text(finalMinutes, (scoreBoardWidth/2)-34, (90/2)+5);
    text(":", scoreBoardWidth/2, (90/2)-5);
    text(finalSeconds, (scoreBoardWidth/2)+34, (90/2)+5);
  } else {
    textAlign(RIGHT);
    text(finalSeconds, (scoreBoardWidth/2)-7, (90/2)+5);
    textAlign(CENTER);
    text(".", (scoreBoardWidth/2)+2, (90/2)+4);
    textAlign(LEFT);
    text(finalTenths, (scoreBoardWidth/2)+11, (90/2)+5);
  }
  textSize(25);
  textAlign(CENTER);
  if (quarter == 0) {
    text("PRE-GAME", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 1) {
    text("1ST", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 2) {
    text("2ND", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 3) {
    text("3RD", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 4) {
    text("4TH", scoreBoardWidth/2, (90)-10);
  } else {
    text("OT " + (quarter-4), scoreBoardWidth/2, (90)-10);
  }
}
public void leftTeam() {
  if (leftLightMode) {
    tintL = 255;
    leftScoreFill = 0;
  } else {
    tintL = 0;
    leftScoreFill = 255;
  }
  rectMode(CORNERS);
  fill(leftColor);
  rect(0, 0, 650, 90);
  fill(tintL, 200);
  rect(500, 0, 650, 90);
  fill(leftScoreFill);
  textAlign(CENTER);
  textFont(sohoscore);
  textSize(92);
  
  if (leftScore < leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = -60;
    }
    text(leftScoreNew, 500+(75), yLeftNew);
    text(leftScore, 500+(75), yLeftOld);
    float targetY = 78;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1f && dyL > -0.1f) {
      leftScore = leftScoreNew;
      yLeftNew = -60;
      yLeftOld = 78;
      bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else if (leftScore > leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = 216;
    }
    text(leftScoreNew, 500+(75), yLeftNew);
    text(leftScore, 500+(75), yLeftOld);
    float targetY = 78;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1f && dyL > -0.1f) {
      leftScore = leftScoreNew;
      yLeftNew = -60;
      yLeftOld = 78;
      bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else {
    text(leftScore, 500+(75), 78);
  }
  
  fill(tintL,230);
  textAlign(RIGHT);
  textFont(sohoscore);
  textSize(59);
  text(leftTeam.toUpperCase(), 483, 59);
  
  // timeouts
  rectMode(CORNERS);
  if (timeoutsL > 0) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(413, 72, 483, 80);
  if (timeoutsL > 1) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(333, 72, 403, 80);
  if (timeoutsL > 2) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(253, 72, 323, 80);
  if (timeoutsL > 3) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(173, 72, 243, 80);
  
  if (leftBonus) {
    fill(tintL, 200);
    rect(0,60,30,90);
    fill(leftScoreFill);
    textAlign(CENTER);
    textFont(sohoscore);
    textSize(28);
    text("B", 15, 85);
  }
  
}
public void loadData() {
  try {
    String[] data = loadStrings("data/savedData.txt");
    leftLightMode = PApplet.parseBoolean(data[0]);
    rightLightMode = PApplet.parseBoolean(data[1]);
    leftBonus = PApplet.parseBoolean(data[2]);
    rightBonus = PApplet.parseBoolean(data[3]);
    seconds = PApplet.parseFloat(data[4]);
    minutes = PApplet.parseFloat(data[5]);
    bottomMessageLive = data[6];
    bottomMessageEdit = data[7];
    leftTeam = data[8];
    rightTeam = data[9];
    leftScore = PApplet.parseInt(data[10]);
    rightScore = PApplet.parseInt(data[11]);
    quarter = PApplet.parseInt(data[12]);
    timeoutsL = PApplet.parseInt(data[13]);
    timeoutsR = PApplet.parseInt(data[14]);
    leftColor = unhex(data[15]);
    rightColor = unhex(data[16]);
    keyColor = unhex(data[17]);
  } catch (NullPointerException rip) {} catch (ArrayIndexOutOfBoundsException rip2) {}
}
public void mask() {
  rectMode(CORNERS);
  fill(keyColor);
  rect(0, 0, width, displaceY);
  rect(0, displaceY+scoreBoardHeight+messageY, width, height);
}
public void message() {
  if (messageAction.toLowerCase().equals("show") && messageIsShowing == false) {
    messageIsMoving = true;
  } else if (messageAction.toLowerCase().equals("hide") && messageIsShowing == true) {
    messageIsMoving = true;
  }
  if (messageIsMoving == true && messageAction.toLowerCase().equals("show")) {
    float targetY = 0;
    float dy = targetY - messageY;
    messageY += dy * messageEasing;
    if (dy < 0.1f && dy > -0.1f) {
      messageIsMoving = false;
      messageAction = "";
      messageIsShowing = true;
    }
  } else if (messageIsMoving == true && messageAction.toLowerCase().equals("hide")) {
    float targetY = -40;
    float dy = targetY - messageY;
    messageY += dy * messageEasing;
    if (dy < 0.1f && dy > -0.1f) {
      messageIsMoving = false;
      messageAction = "";
      messageIsShowing = false;
    }
  }
  pushMatrix();
  translate(0,messageY);
  rectMode(CORNERS);
  fill(0xff263238);
  rect(0, 90, scoreBoardWidth, scoreBoardHeight);
  textAlign(CENTER);
  textFont(din);
  textSize(28);
  if (newTransitionMessage) {
    transitioningMessage = true;
    newTransitionMessage = false;
  }
  if (transitioningMessage) {
    fill(240, messageLiveOpacity);
    text(bottomMessageLive.toUpperCase(), scoreBoardWidth/2, 120);
    fill(240, messageEditOpacity);
    text(bottomMessageEdit.toUpperCase(), scoreBoardWidth/2, 120);
    messageLiveOpacity = messageLiveOpacity - 5;
    messageEditOpacity = messageEditOpacity + 5;
    if (messageLiveOpacity < 0 && messageEditOpacity >= 255) {
      messageLiveOpacity = 255;
      messageEditOpacity = 0;
      transitioningMessage = false;
      String tempHolder = bottomMessageLive;
      bottomMessageLive = bottomMessageEdit;
      bottomMessageEdit = tempHolder;
      bugServer.write("update\n" + "message\n" + bottomMessageEdit + "\n");
      fill(240, messageLiveOpacity);
    text(bottomMessageLive.toUpperCase(), scoreBoardWidth/2, 120);
    }
  } else {
    fill(240, messageLiveOpacity);
    text(bottomMessageLive.toUpperCase(), scoreBoardWidth/2, 120);
  }
  popMatrix();
}
public void requestHandler(String input, Client requester) {
  String data[] = input.split("\n");
  try {
    if (data[0].equalsIgnoreCase("hello.score")) {
      requester.write("welcome.score\n" + leftLightMode + "\n" + leftColor + "\n" + leftTeam + "\n" + leftScore + "\n" + rightLightMode + "\n" + rightColor + "\n" + rightTeam + "\n" + rightScore + "\n");
    } else if (data[0].equalsIgnoreCase("hello.ctrl")) {
      requester.write("welcome.ctrl\n" + leftLightMode + "\n" + leftColor + "\n" + leftTeam + "\n" + leftBonus + "\n" + rightLightMode + "\n" + rightColor + "\n" + rightTeam + "\n" + rightBonus + "\n" + bottomMessageEdit + "\n" + keyColor + "\n");
    } else if (data[0].equalsIgnoreCase("update")) {
      if (data[1].equalsIgnoreCase("score")) {
        if (data[2].equalsIgnoreCase("left")) {
          if (leftScoreNew == leftScore) {
            leftScoreNew = leftScore + PApplet.parseInt(data[3]);
            newTransitionL = true;
          }
        } else if (data[2].equalsIgnoreCase("right")) {
          if (rightScoreNew == rightScore) {
            rightScoreNew = rightScore + PApplet.parseInt(data[3]);
            newTransitionR = true;
          }
        }
      } else if (data[1].equalsIgnoreCase("timeouts")) {
        if (data[2].equalsIgnoreCase("left")) {
          if (data[3].equalsIgnoreCase("+1")) {
            if (timeoutsL < 4) {
              timeoutsL++;
            }
          } else if (data[3].equalsIgnoreCase("-1")) {
            if (timeoutsL > 0) {
              timeoutsL--;
            }
          }
        } else if (data[2].equalsIgnoreCase("right")) {
          if (data[3].equalsIgnoreCase("+1")) {
            if (timeoutsR < 4) {
              timeoutsR++;
            }
          } else if (data[3].equalsIgnoreCase("-1")) {
            if (timeoutsR > 0) {
              timeoutsR--;
            }
          }
        }
      } else if (data[1].equalsIgnoreCase("quarter")) {
        if (data[2].equalsIgnoreCase("-")) {
          if (quarter > 0) {
            quarter--;
          }
        } else if (data[2].equalsIgnoreCase("+")) {
          quarter++;
        }
      }
    } else if (data[0].equalsIgnoreCase("set")) {
      if (data[1].equalsIgnoreCase("score")) {
        if (data[2].equalsIgnoreCase("left")) {
          if (leftScoreNew == leftScore) {
            leftScoreNew = PApplet.parseInt(data[3]);
            newTransitionL = true;
          }
        } else if (data[2].equalsIgnoreCase("right")) {
          if (rightScoreNew == rightScore) {
            rightScoreNew = PApplet.parseInt(data[3]);
            newTransitionR = true;
          }
        }
      } else if (data[1].equalsIgnoreCase("name")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftTeam = data[3];
          bugServer.write("set\n" + "name\n" + "left\n" + leftTeam + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightTeam = data[3];
          bugServer.write("set\n" + "name\n" + "right\n" + rightTeam + "\n");
        }
      } else if (data[1].equalsIgnoreCase("color")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftColor = unhex(data[3]);
          bugServer.write("set\n" + "color\n" + "left\n" + hex(leftColor).toLowerCase() + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightColor = unhex(data[3]);
          bugServer.write("set\n" + "color\n" + "right\n" + hex(rightColor).toLowerCase() + "\n");
        } else if (data[2].equalsIgnoreCase("key")) {
          keyColor = unhex(data[3]);
          bugServer.write("set\n" + "color\n" + "key\n" + hex(keyColor).toLowerCase() + "\n");
        }
      } else if (data[1].equalsIgnoreCase("lightMode")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftLightMode = PApplet.parseBoolean(data[3]);
          bugServer.write("set\n" + "lightMode\n" + "left\n" + str(leftLightMode) + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightLightMode = PApplet.parseBoolean(data[3]);
          bugServer.write("set\n" + "lightMode\n" + "right\n" + str(rightLightMode) + "\n");
        }
      } else if (data[1].equalsIgnoreCase("time")) {
        minutes = PApplet.parseFloat(data[2]);
        seconds = PApplet.parseFloat(data[3]);
        currentSeconds = seconds;
        currentMinutes = minutes;
      } else if (data[1].equalsIgnoreCase("message")) {
        bottomMessageEdit = spacer(data[2]);
      }
    } else if (data[0].equalsIgnoreCase("toggle")) {
      if (data[1].equalsIgnoreCase("time")) {
        if (!timeRunning) {
          timeStarted = true;
        } else {
          timeStopped = true;
        }
      } else if (data[1].equalsIgnoreCase("messageVis")) {
        if (messageIsShowing == false) {
          messageAction = "show";
        } else {
          messageAction = "hide";
        }
      } else if (data[1].equalsIgnoreCase("switchMessage")) {
        if (!transitioningMessage) {
          newTransitionMessage = true;
          //println("enter pressed");
        }
      } else if (data[1].equalsIgnoreCase("bonus")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftBonus = !leftBonus;
          //bugServer.write("set\n" + "bonus\n" + "left\n" + leftBonus + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightBonus = !rightBonus;
          //bugServer.write("set\n" + "bonus\n" + "right\n" + rightBonus + "\n");
        }
      } else if (data[1].equalsIgnoreCase("scoreboard")) {
        if (scoreBoardTransitioning == false) {
          scoreBoardTransitioning = true;
        }
      }
    }
  } catch (NullPointerException rip) {} catch (ArrayIndexOutOfBoundsException rip) {
  }
  
}
public void rightTeam() {
  if (rightLightMode) {
    tintR = 255;
    rightScoreFill = 0;
  } else {
    tintR = 0;
    rightScoreFill = 255;
  }
  rectMode(CORNERS);
  fill(rightColor);
  rect(850, 0, scoreBoardWidth, 90);
  fill(tintR, 200);
  rect(850, 0, 1000, 90);
  fill(rightScoreFill);
  textAlign(CENTER);
  textFont(sohoscore);
  textSize(92);
  
  if (rightScore < rightScoreNew) {
    if (newTransitionR) {
      newTransitionR = false;
      yRightNew = -60;
    }
    text(rightScoreNew, 850+(75), yRightNew);
    text(rightScore, 850+(75), yRightOld);
    float targetY = 78;
    float dyR = targetY - yRightNew;
    yRightNew += dyR * scoreEasing;
    yRightOld += dyR * scoreEasing;
    if (dyR < 0.1f && dyR > -0.1f) {
      rightScore = rightScoreNew;
      yRightNew = -60;
      yRightOld = 78;
      bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else if (rightScore > rightScoreNew) {
    if (newTransitionR) {
      newTransitionR = false;
      yRightNew = 216;
    }
    text(rightScoreNew, 850+(75), yRightNew);
    text(rightScore, 850+(75), yRightOld);
    float targetY = 78;
    float dyR = targetY - yRightNew;
    yRightNew += dyR * scoreEasing;
    yRightOld += dyR * scoreEasing;
    if (dyR < 0.1f && dyR > -0.1f) {
      rightScore = rightScoreNew;
      yRightNew = -60;
      yRightOld = 78;
      bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else {
    text(rightScore, 850+(75), 78);
  }
  
  fill(tintR,230);
  textAlign(LEFT);
  textFont(sohoscore);
  textSize(59);
  text(rightTeam.toUpperCase(), 1017, 59);
  
  rectMode(CORNERS);
  if (timeoutsR > 0) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1017, 72, 1087, 80);
  if (timeoutsR > 1) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1097, 72, 1167, 80);
  if (timeoutsR > 2) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1177, 72, 1247, 80);
  if (timeoutsR > 3) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1257, 72, 1327, 80);
  
  if (rightBonus) {
    fill(tintR, 200);
    rect(scoreBoardWidth, 60, scoreBoardWidth-30, 90);
    fill(rightScoreFill);
    textAlign(CENTER);
    textFont(sohoscore);
    textSize(28);
    text("B", scoreBoardWidth-15, 85);
  }
}
public void saveData() {
  if (frameCount % 3600 == 0) {
    boolean errors = false;
    String[] array = new String[saveItems];
    for (int i = 0; i<array.length; i++) array[i] = "placeholder";
    try {
      array[0] = str(leftLightMode);
      array[1] = str(rightLightMode);
      array[2] = str(leftBonus);
      array[3] = str(rightBonus);
      array[4] = str(currentSeconds);
      array[5] = str(currentMinutes);
      array[6] = bottomMessageLive;
      array[7] = bottomMessageEdit;
      array[8] = leftTeam;
      array[9] = rightTeam;
      array[10] = str(leftScore);
      array[11] = str(rightScore);
      array[12] = str(quarter);
      array[13] = str(timeoutsL);
      array[14] = str(timeoutsR);
      array[15] = hex(leftColor).toLowerCase();
      array[16] = hex(rightColor).toLowerCase();
      array[17] = hex(keyColor).toLowerCase();
    } catch (NullPointerException e) {
      errors = true;
    }
    if (errors) {
      println("Didn't save properly");
    } else {
      saveStrings("data/savedData.txt", array);
    }
  }
}
public void placeScoreBoard() {
  if (scoreBoardShowing && !scoreBoardTransitioning) {
    displaceY = scoreBoardYUp;
  } else if (!scoreBoardShowing && !scoreBoardTransitioning) {
    displaceY = scoreBoardYDown;
  } else if (scoreBoardShowing && scoreBoardTransitioning) {
    //moving down
    float targetY = scoreBoardYDown;
    float dy1 = targetY - displaceY;
    displaceY += dy1 * scoreBoardEasing;
    if (dy1 < 0.01f) {
      //end animation
      scoreBoardShowing = false;
      scoreBoardTransitioning = false;
    }
  } else if (!scoreBoardShowing && scoreBoardTransitioning) {
    //moving up
    float targetY = scoreBoardYUp;
    float dy2 = targetY - displaceY;
    displaceY += dy2 * scoreBoardEasing;
    if (dy2 > -0.01f) {
      //end animation
      scoreBoardShowing = true;
      scoreBoardTransitioning = false;
    }
  }
}
public String spacer(String input) {
  String returnString = "";
  char[] charArray = input.toCharArray();
  for (int i = 0; i<charArray.length; i++) {
    if (charArray[i] != ' ' && i < charArray.length-1) {
      returnString = returnString + charArray[i] + " ";
    } else {
      returnString = returnString + charArray[i];
    }
  }
  return returnString;
}
public void stringify() {
  if (currentSeconds >= 10 || tenthsMode) {
    finalSeconds = str(currentSeconds);
  } else {
    finalSeconds = "0" + str(currentSeconds);
  }
  if (finalSeconds.indexOf(".") != -1) {
    finalTenths = finalSeconds.substring(finalSeconds.indexOf(".") + 1, finalSeconds.indexOf(".") + 2);
    finalSeconds = finalSeconds.substring(0, finalSeconds.indexOf("."));
    
  } else {
    finalTenths = "0";
  }

  if (currentMinutes >= 10) {
    finalMinutes = str(currentMinutes);
  } else {
    finalMinutes = "0" + str(currentMinutes);
  }
  if (finalMinutes.indexOf(".") != -1) {
    finalMinutes = finalMinutes.substring(0, finalMinutes.indexOf("."));
  }
  
  //println(finalMinutes + ":" + finalSeconds);
  
}

  public void timer() {

  if (timeStarted) {
    startTime = millis();
    //println(startTime);
    timeStarted = false;
    timeRunning = true;
  }

  if (timeStopped) {
    timeStopped = false;
    timeRunning = false;
    seconds = currentSeconds;
  }
  
  if (timeRunning) {
    currentSeconds = (seconds - ((millis()-startTime)/1000));
    
    
    println(seconds - ((millis()-startTime)/1000));
    
    //println("timeRunning");
    if (currentSeconds < 0) {
      currentSeconds = 59.999f;
      seconds = 59.999f;
      currentMinutes--;
      timeStarted = true;
    }

    if (currentMinutes < 0) {
      currentMinutes = 0;
      currentSeconds = 0;
      timeStopped = true;
      println("time autostopped");
    }
  }
  
  if (currentMinutes < 1) {
    tenthsMode = true;
  } else {
    tenthsMode = false;
  }
  
  
  //println(currentSeconds);
}
  public void settings() {  fullScreen(1); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "liveStreamBug_Net" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
