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
    if (newTransitionAway) {
      newTransitionAway = false;
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
}
