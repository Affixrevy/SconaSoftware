void homeTeam() {
  
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
    if (dyL < 0.1 && dyL > -0.1) {
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
    if (dyL < 0.1 && dyL > -0.1) {
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

void timeOutHome() {
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
