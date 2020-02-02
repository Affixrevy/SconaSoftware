import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LivestreamBugV_2 extends PApplet {



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

String finalTenths = "";
String finalSeconds = "";
String finalMinutes = "";

float yLeftNew = 934;
float yLeftOld = 1034;
float yRightNew = 934;
float yRightOld = 1034;
float scoreEasing = 0.2f;
float messageEasing = 0.2f;

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

public void setup() {
  

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

public void draw() {
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
}
public void drawTime() {
  
  //Set font, colour, and alignment varialbes for main time
  textFont(din);
  textSize(82);
  textAlign(CENTER);
  fill(255);
  
  //Variables for the position of the main time
  int minuiteXSpacing = 48;
  int secondXSpacingConstant = 14;
  int YSpacing = 5;
  int scoreX = 960;
  int scoreY = 960;
  
  int shotclockX = 1007;
  int shotclockY = 1013;
  
  //Area to simplify if I have time ********************************************************************************
  
  
  //Draw the clock if it is not displaing the final minuite
  if (!tenthsMode) {
    text(finalMinutes, scoreX - minuiteXSpacing, scoreY+5);
    text(":", scoreX, scoreY - 5);
    text(finalSeconds, scoreX + minuiteXSpacing, scoreY+5);
    shotclockX = 1027;
    
  //Draw the clock if it is displaying the final minuite
  } else {
    textAlign(RIGHT);
    text(finalSeconds, scoreX- 3 + secondXSpacingConstant, scoreY+5);
    textAlign(CENTER);
    text(".", scoreX+6+secondXSpacingConstant, scoreY+4);
    textAlign(LEFT);
    text(finalTenths, scoreX+16+secondXSpacingConstant, scoreY+5);
    
  } 
  
  //Set font, colour, and alignment varialbes for Shot clock time
  textSize(40);
  fill(255, 255, 0);
  
  //Draw shot clock time
  text(shotClockSeconds, shotclockX, shotclockY);
  
}
int foulDownTimeAway = 0;
public void dropFoulsAndBonusAway() {
  if (messageDropingAway) {
    dropFoulAway();
  } else if (messageRetractingAway) {
    retractFoulAway();
  }

  if(messageDisplayingAway) {
    foulDownTimeAway++; 
   
  }

  if (foulDownTimeAway > 400) {
    foulDownTimeAway = 0;
    retractFoulAway();
  }

  //Set properties for drawing the rectangles
  rectMode(CORNER);
  fill(237, 28, 26);
  textSize(24);
  textAlign(CENTER);

  //Draw the message
  rect(dropFoulAwayX, dropFoulAwayY, 530, 24);
  fill(255);
  text("FOULS: " + foulsAway, dropFoulAwayX + 250, dropFoulAwayY + 20);
}

//Normaly droping the foul message
public void dropFoulAway() {
  if (bonusDownAway) {
    dropFoulAwayBonus();
  } else {

    messageDropingAway = true;
    //Set the target y value of the message
    float targetY = 1000;

    //Calculate the difference between messages current position and target
    //position and multiply by a constant to change the position
    float dy = targetY - dropFoulAwayY;
    dropFoulAwayY += dy * messageEasing;

    //Stop changing the position when message block is in place
    if (dy < 5) {
      messageDropingAway = false;
      messageDisplayingAway = true;
    }
  }
}

//Retracting the foul messaging
public void retractFoulAway() {

  messageRetractingAway = true;

  //Set the target y value of the message
  float targetY = 960;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulAwayY;
  dropFoulAwayY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 0.1f && dy > -0.1f) {
    messageRetractingAway = false;
    messageDisplayingAway = false;
  }
}

//Drop the foul messaging when bonus is down
public void dropFoulAwayBonus() {
  messageDropingAway = true;

  //Set the target y value of the message
  float targetY = 1035;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulAwayY;
  dropFoulAwayY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 5) {
    messageDropingAway = false;
    messageDisplayingAway = true;
  }
}
int foulDownTimeHome = 0;
public void dropFoulsAndBonusHome() {
  if (messageDropingHome) {
    dropFoulHome();
  } else if (messageRetractingHome) {
    retractFoulHome();
  }

  if(messageDisplayingHome) {
    foulDownTimeHome++; 
   
  }

  if (foulDownTimeHome > 400) {
    foulDownTimeHome = 0;
    retractFoulHome();
  }

  //Set properties for drawing the rectangles
  rectMode(CORNER);
  fill(41, 78, 155);
  textSize(24);
  textAlign(CENTER);

  //Draw the message
  rect(dropFoulHomeX, dropFoulHomeY, 530, 24);
  fill(255);
  text("FOULS: " + foulsHome, dropFoulHomeX + 250, dropFoulHomeY + 20);
}

//Normaly droping the foul message
public void dropFoulHome() {
  if (bonusDownHome) {
    dropFoulHomeBonus();
  } else {

    messageDropingHome = true;
    //Set the target y value of the message
    float targetY = 1000;

    //Calculate the difference between messages current position and target
    //position and multiply by a constant to change the position
    float dy = targetY - dropFoulHomeY;
    dropFoulHomeY += dy * messageEasing;

    //Stop changing the position when message block is in place
    if (dy < 5) {
      messageDropingHome = false;
      messageDisplayingHome = true;
    }
  }
}

//Retracting the foul messaging
public void retractFoulHome() {

  messageRetractingHome = true;

  //Set the target y value of the message
  float targetY = 960;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulHomeY;
  dropFoulHomeY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 0.1f && dy > -0.1f) {
    messageRetractingHome = false;
    messageDisplayingHome = false;
  }
}

//Drop the foul messaging when bonus is down
public void dropFoulHomeBonus() {
  messageDropingHome = true;

  //Set the target y value of the message
  float targetY = 1035;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulHomeY;
  dropFoulHomeY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 5) {
    messageDropingHome = false;
    messageDisplayingHome = true;
  }
}
public void keyPressed() {
  if (key == 'l') {
    if (newScoreAway == scoreAway) {
      newScoreAway = scoreAway + 1;
      newTransitionAway = true;
    }
  } else if (key == 'k') {
    if (newScoreHome == scoreHome) {
      newScoreHome = scoreHome + 1;
      newTransitionHome = true;
    }
  } else if (key == ' ') {
    if (!messageDisplayingHome) {
      println("hi");
      dropFoulHome();
    } else {
      retractFoulHome();
    }
  }
}

public void mousePressed() {
  println(mouseX + " - " + mouseY);
}
public void awayTeam() {
  
  textAlign(CENTER);
  textFont(din);
  textSize(100);
  fill(255);
  
  int leftPos = 470;

  if (scoreAway < newScoreAway) {
    if (newTransitionAway) {
      newTransitionAway = false;
      yLeftNew = 934;
    }
    text(newScoreAway, 340+(leftPos), yLeftNew);
    text(scoreAway, 340+(leftPos), yLeftOld);
    float targetY = 984;
    float dyR = targetY - yLeftNew;
    yLeftNew += dyR * scoreEasing;
    yLeftOld += dyR * scoreEasing;
    if (dyR < 0.1f && dyR > -0.1f) {
      scoreAway = newScoreAway;
      yLeftNew = 934;
      yLeftOld = 1034;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else if (scoreAway > newScoreAway) {
    if (newTransitionAway) {
      newTransitionAway = false;
      yLeftNew = 216;
    }
    text(newScoreAway, 340+(leftPos), yLeftNew);
    text(scoreAway, 340+(leftPos), yLeftOld);
    float targetY = 984;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1f && dyL > -0.1f) {
      scoreAway = newScoreAway;
      yLeftNew = 934;
      yLeftOld = 1034;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else {
    text(scoreAway, 340+(leftPos), 984);
  }
  timeOutAway();
  
}

public void timeOutAway() {
  fill(200);
  
  if(timeoutsLeftAway < 1) {fill(120);} 
  ellipse(650, 909, 13, 13);
  if(timeoutsLeftAway < 2) {fill(120);} 
  ellipse(610, 909, 13, 13);
  if(timeoutsLeftAway < 3) {fill(120);} 
  ellipse(570, 909, 13, 13);
  if(timeoutsLeftAway < 4) {fill(120);} 
  ellipse(530, 909, 13, 13);
  if(timeoutsLeftAway < 5) {fill(120);}
  ellipse(490, 909, 13, 13);
}
public void pullXML() {
  try {
    scoreSheet = loadXML("Nevco MPC0.xml");
  } 
  catch (RuntimeException e) {
    String test[] = loadStrings("Nevco MPC0.xml");
    for (String s : test) {
      println(s);
    }
    println(e);
  }
  
  //Get Current Time and Call setTime Method
  String currentTimeStr = scoreSheet.getChild("MAIN_TIME").getContent();
  if (currentTimeStr != "") {
     setTime(currentTimeStr); 
  }


  //Get Away Score - Check if XML value is null, if not parse the score to int so scoreboard can be set to the value
  String leftScoreStr = scoreSheet.getChild("GUEST_SCORE").getContent();
  if (leftScoreStr != str(scoreAway) && leftScoreStr != "") {
    newScoreAway = Integer.parseInt(leftScoreStr);
  }

  //Get Home Score - Check if XML value is null, if not parse the score to int so scoreboard can be set to the value
  String rightScoreStr = scoreSheet.getChild("HOME_SCORE").getContent();
  if (rightScoreStr != str(scoreHome) && rightScoreStr != "") {
    newScoreHome = Integer.parseInt(rightScoreStr);
  }

  //Get Home Fouls - Check if XML value is null, if not parse the score to int and call a method to drop down fouls tab
  String foulHomeStr = scoreSheet.getChild("HOME_FOULS").getContent();
  if (foulHomeStr != "" && !foulHomeStr.equals(str(foulsHome))) {
    foulsHome = Integer.parseInt(foulHomeStr);
    dropFoulHome();
  }

  //Get Away Fouls - Check if XML value is null, if not parse the score to int and call a method to drop down fouls tab
  String foulAwayStr = scoreSheet.getChild("GUEST_FOULS").getContent();
  if (foulAwayStr != "" && !foulAwayStr.equals(str(foulsAway))) {
    foulsAway = Integer.parseInt(foulAwayStr);
    dropFoulAway();
  }

  //Get Home Timeouts - Check if XML value is null, if not parse the score to int so correct number of circles show
  String timeoutLeftHomeStr = scoreSheet.getChild("HOME_TIMEOUTS_LEFT").getContent();
  if (timeoutLeftHomeStr != "") {
    timeoutsLeftHome = Integer.parseInt(timeoutLeftHomeStr);
  }

  //Get Away Timeouts - Check if XML value is null, if not parse the score to int so correct number of circles show
  String timeoutLeftAwayStr = scoreSheet.getChild("GUEST_TIMEOUTS_LEFT").getContent();
  if (timeoutLeftAwayStr != "") {
    timeoutsLeftAway = Integer.parseInt(timeoutLeftAwayStr);
  }



  //Get Shot Clock -  Check if XML value is null, if not parse the score to int so scoreboard can be set to the value
  String shotClockTemp = scoreSheet.getChild("SHOT_CLOCK_SECONDS").getContent();
  if (shotClockTemp != "") {
    
    if(shotClockTemp.charAt(0) != '7'){
      shotClockSeconds = shotClockTemp;
    } else {
      shotClockSeconds = shotClockTemp.substring(1);
    }
  }

  //Get Game Quarter - Check if XML value is null, if not parse the score to int and call function when the quarter changes
  String quarterTemp = scoreSheet.getChild("GLOBAL_DATA_GAME_PERIOD").getContent();
  if (!quarterTemp.equals(quarter)) {
    quarter = quarterTemp;
    bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  }
}

public boolean isOne(int xmlValue) {
  if (xmlValue == 1) {
    return true;
  } else {
    return false;
  }
}

public void setTime(String currentTime) {
  //println(currentTime);
  if (currentTime.contains(".")) {
    tenthsMode = true;
    finalSeconds = currentTime.substring(0, currentTime.indexOf("."));
    finalTenths = currentTime.substring(currentTime.indexOf(".")+1);
  } else {
    tenthsMode = false;
    finalMinutes = "0"+currentTime.substring(1, currentTime.indexOf(":"));
    finalSeconds = currentTime.substring(currentTime.indexOf(":")+1);
  }
}
public void homeTeam() {
  
  textAlign(CENTER);
  textFont(din);
  textSize(100);
  fill(255);

  if (scoreHome < newScoreHome) {
    if (newTransitionHome) {
      newTransitionHome = false;
      yRightNew = 934;
    }
    text(newScoreHome, 340+(770), yRightNew);
    text(scoreHome, 340+(770), yRightOld);
    float targetY = 984;
    float dyL = targetY - yRightNew;
    yRightNew += dyL * scoreEasing;
    yRightOld += dyL * scoreEasing;
    if (dyL < 0.1f && dyL > -0.1f) {
      scoreHome = newScoreHome;
      yRightNew = 934;
      yRightOld = 1034;
      //bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else if (scoreHome > newScoreHome) {
    if (newTransitionHome) {
      newTransitionHome = false;
      yRightNew = 216;
    }
    text(newScoreHome, 340+(770), yRightNew);
    text(scoreHome, 340+(770), yRightOld);
    float targetY = 984;
    float dyL = targetY - yRightNew;
    yRightNew += dyL * scoreEasing;
    yRightOld += dyL * scoreEasing;
    if (dyL < 0.1f && dyL > -0.1f) {
      scoreHome = newScoreHome;
      yRightNew = 934;
      yRightOld = 1034;
      //bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else {
    text(scoreHome, 340+(770), 984);
  }
  timeOutHome();
}

public void timeOutHome() {
  fill(200);
  
  /*if(timeoutsLeftHome >= 1) {ellipse(1260, 909, 13, 13);} 
  if(timeoutsLeftHome >= 2) {ellipse(1300, 909, 13, 13);} 
  if(timeoutsLeftHome >= 3) {ellipse(1340, 909, 13, 13);} 
  if(timeoutsLeftHome >= 4) {ellipse(1380, 909, 13, 13);} 
  if(timeoutsLeftHome >= 5) {ellipse(1420, 909, 13, 13);}*/
  
  if(timeoutsLeftHome < 1) {fill(120);} 
  ellipse(1260, 909, 13, 13);
  if(timeoutsLeftHome < 2) {fill(120);} 
  ellipse(1300, 909, 13, 13);
  if(timeoutsLeftHome < 3) {fill(120);} 
  ellipse(1340, 909, 13, 13);
  if(timeoutsLeftHome < 4) {fill(120);} 
  ellipse(1380, 909, 13, 13);
  if(timeoutsLeftHome < 5) {fill(120);}
  ellipse(1420, 909, 13, 13);
}
  public void settings() {  size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "LivestreamBugV_2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
