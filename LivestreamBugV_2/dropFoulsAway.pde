int foulDownTime = 0;
void dropFoulsAndBonusAway() {
  if (messageDropingAway) {
    dropFoulAway();
  } else if (messageRetractingAway) {
    retractFoulAway();
  }

  if(messageDisplayingAway) {
    foulDownTime++; 
   
  }

  if (foulDownTime > 500) {
    foulDownTime = 0;
    retractFoulAway();
  }

  //Set properties for drawing the rectangles
  rectMode(CORNER);
  fill(237, 28, 26);
  textSize(24);
  textAlign(CENTER);

  //Draw the message
  rect(dropFoulAwayX, dropFoulAwayY, 533, 30);
  fill(255);
  text("FOULS: " + foulsAway, dropFoulAwayX + 250, dropFoulAwayY + 20);
}

//Normaly droping the foul message
void dropFoulAway() {
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
void retractFoulAway() {

  messageRetractingAway = true;

  //Set the target y value of the message
  float targetY = 960;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulAwayY;
  dropFoulAwayY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 0.1 && dy > -0.1) {
    messageRetractingAway = false;
    messageDisplayingAway = false;
  }
}

//Drop the foul messaging when bonus is down
void dropFoulAwayBonus() {
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
