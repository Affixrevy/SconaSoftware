void homeTeam() {
  scoreHome();
  timeOutHome();
  foulsHome();
  
  image(scoreHomeNumber, 0, 0);
}

void scoreHome() {

  scoreHomeNumber.beginDraw();
  scoreHomeNumber.background(bugHome.get(1441, 920));
  scoreHomeNumber.textAlign(CENTER);
  scoreHomeNumber.textFont(din);
  scoreHomeNumber.textSize(100);
  scoreHomeNumber.fill(255);
  scoreHomeNumber.endDraw();

  if (scoreHome < newScoreHome) {
    if (newTransitionHome) {
      newTransitionHome = false;
      yRightNew = 934;
    }
    scoreHomeNumber.beginDraw();
    scoreHomeNumber.text(newScoreHome, 340+(770), yRightNew);
    scoreHomeNumber.text(scoreHome, 340+(770), yRightOld);
    scoreHomeNumber.endDraw();
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
    scoreHomeNumber.beginDraw();
    scoreHomeNumber.text(newScoreHome, 340+(770), yRightNew);
    scoreHomeNumber.text(scoreHome, 340+(770), yRightOld);
    scoreHomeNumber.endDraw();
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
    scoreHomeNumber.beginDraw();
    scoreHomeNumber.text(scoreHome, 340+(770), 984);
    scoreHomeNumber.endDraw();
  }
  scoreHomeNumber.mask(scoreMask);
}

void foulsHome() {
  fill(255);
  textSize(20);
  text(foulsHome, 1245, 916);
}

void timeOutHome() {
  fill(200);

  if (timeoutsLeftHome < 1) {
    fill(120);
  } 
  ellipse(1175, 930, 10, 10);
  if (timeoutsLeftHome < 2) {
    fill(120);
  } 
  ellipse(1175, 945, 10, 10);
  if (timeoutsLeftHome < 3) {
    fill(120);
  } 
  ellipse(1175, 960, 10, 10);
  if (timeoutsLeftHome < 4) {
    fill(120);
  } 
  ellipse(1175, 975, 10, 10);
  if (timeoutsLeftHome < 5) {
    fill(120);
  }
  ellipse(1175, 990, 10, 10);
}
