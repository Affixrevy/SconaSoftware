int foulDownTimeHome = 0;
void dropFoulsAndBonusHome() {
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
void dropFoulHome() {
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
void retractFoulHome() {

  messageRetractingHome = true;

  //Set the target y value of the message
  float targetY = 960;

  //Calculate the difference between messages current position and target
  //position and multiply by a constant to change the position
  float dy = targetY - dropFoulHomeY;
  dropFoulHomeY += dy * messageEasing;

  //Stop changing the position when message block is in place
  if (dy < 0.1 && dy > -0.1) {
    messageRetractingHome = false;
    messageDisplayingHome = false;
  }
}

//Drop the foul messaging when bonus is down
void dropFoulHomeBonus() {
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
