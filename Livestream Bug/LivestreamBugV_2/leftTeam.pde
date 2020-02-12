void awayTeam() {
  scoreAway();
  timeOutAway();
  foulsAway();
  
  image(scoreAwayNumber, 0, 0);
}

void scoreAway() {
  
  scoreAwayNumber.beginDraw();
  scoreAwayNumber.background(bugAway.get(530, 910));
  scoreAwayNumber.textAlign(CENTER);
  scoreAwayNumber.textFont(din);
  scoreAwayNumber.textSize(100);
  scoreAwayNumber.fill(255);
  scoreAwayNumber.endDraw();

  if (scoreAway < newScoreAway) {
    if (newTransitionAway) {
      newTransitionAway = false;
      yLeftNew = 934;
    }
    scoreAwayNumber.beginDraw();
    scoreAwayNumber.text(newScoreAway, 340+470, yLeftNew);
    scoreAwayNumber.text(scoreAway, 340+470, yLeftOld);
    scoreAwayNumber.endDraw();
    float targetY = 984;
    float dyR = targetY - yLeftNew;
    yLeftNew += dyR * scoreEasing;
    yLeftOld += dyR * scoreEasing;
    if (dyR < 0.1 && dyR > -0.1) {
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
    scoreAwayNumber.beginDraw();
    scoreAwayNumber.text(newScoreAway, 340+470, yLeftNew);
    scoreAwayNumber.text(scoreAway, 340+470, yLeftOld);
    scoreAwayNumber.endDraw();
    float targetY = 984;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      scoreAway = newScoreAway;
      yLeftNew = 934;
      yLeftOld = 1034;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else {
    scoreAwayNumber.beginDraw();
    scoreAwayNumber.text(scoreAway, 340+470, 984);
    scoreAwayNumber.endDraw();
  }
  scoreAwayNumber.mask(scoreMaskAway);
}

void foulsAway() {
  fill(255);
  textSize(20);
  text(foulsHome, 675, 916);
}


void timeOutAway() {
  fill(200);

  if (timeoutsLeftAway < 1) {
    fill(120);
  } 
  ellipse(748, 929, 10, 10);
  if (timeoutsLeftAway < 2) {
    fill(120);
  } 
  ellipse(748, 944, 10, 10);
  if (timeoutsLeftAway < 3) {
    fill(120);
  } 
  ellipse(748, 959, 10, 10);
  if (timeoutsLeftAway < 4) {
    fill(120);
  } 
  ellipse(748, 974, 10, 10);
  if (timeoutsLeftAway < 5) {
    fill(120);
  }
  ellipse(748, 989, 10, 10);
}
