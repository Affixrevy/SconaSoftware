void rightTeam() {
  
  textAlign(CENTER);
  textFont(din);
  textSize(100);
  

  if (rightScore < rightScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yRightNew = -60;
    }
    text(rightScoreNew, 340+(770), yRightNew);
    text(rightScore, 340+(770), yRightOld);
    float targetY = 984;
    float dyL = targetY - yRightNew;
    yRightNew += dyL * scoreEasing;
    yRightOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      rightScore = rightScoreNew;
      yRightNew = 934;
      yRightOld = 1034;
      //bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else if (rightScore > rightScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yRightNew = 216;
    }
    text(rightScoreNew, 340+(770), yRightNew);
    text(rightScore, 340+(770), yRightOld);
    float targetY = 984;
    float dyL = targetY - yRightNew;
    yRightNew += dyL * scoreEasing;
    yRightOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      rightScore = rightScoreNew;
      yRightNew = 934;
      yRightOld = 1034;
      //bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else {
    text(rightScore, 340+(770), 984);
  }
}
