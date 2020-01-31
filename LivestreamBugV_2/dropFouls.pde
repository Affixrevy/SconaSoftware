void dropFouls() {


  //Set properties for drawing the rectangles
  rectMode(CORNER);
  fill(237, 28, 26);

  //Draw the message
  rect(dropFoulAwayX, dropFoulAwayY, 533, 35);
}

//Normaly droping the foul message
void dropFoulAway() {
  if (bonusDownAway) {
    dropFoulAwayBonus();
  } else {

    messageDropingAway = true;
    //Set the target y value of the message
    float targetY = 1027;

    //Calculate the difference between messages current position and target
    //position and multiply by a constant to change the position
    float dy = targetY - dropFoulAwayY;
    dropFoulAwayY += dy * messageEasing;

    //Stop changing the position when message block is in place
    if (dy < 0.1 && dy > -0.1) {
      messageDropingAway = false;
      messageDisplayingAway = true;
    }
  }
}

//Retracting the foul messaging
void retractFoulAway() {
  //Set the target y value of the message
  float targetY = 960;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulAwayY;
  dropFoulAwayY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 0.1 && dy > -0.1) {

    messageDisplayingAway = false;
  }
}

//Drop the foul messaging when bonus is down
void dropFoulAwayBonus() {
  messageDropingAway = true;

  //Set the target y value of the message
  float targetY = 1062;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulAwayY;
  dropFoulAwayY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 0.1 && dy > -0.1) {
    messageDropingAway = false;
    messageDisplayingAway = true;
  }
}
