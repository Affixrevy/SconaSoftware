void dropFoulsAndBonusHome() {
  if (messageDropingHome) {
    dropFoulHome();
  } else if (messageRetractingHome) {
    retractFoulHome();
  }

  //Set properties for drawing the rectangles
  rectMode(CORNER);
  fill(237, 28, 26);
  textSize(24);
  textAlign(CENTER);

  //Draw the message
  rect(dropFoulHomeX, dropFoulHomeY, 108, 24);
  fill(255);
  text("BONUS" , dropFoulHomeX + 54, dropFoulHomeY + 20);
}

//Normaly droping the foul message
void dropFoulHome() {
  

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
