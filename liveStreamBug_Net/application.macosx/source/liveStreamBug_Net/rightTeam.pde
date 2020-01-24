void rightTeam() {
  if (rightLightMode) {
    tintR = 255;
    rightScoreFill = 0;
  } else {
    tintR = 0;
    rightScoreFill = 255;
  }
  rectMode(CORNERS);
  fill(rightColor);
  rect(850, 0, scoreBoardWidth, 90);
  fill(tintR, 200);
  rect(850, 0, 1000, 90);
  fill(rightScoreFill);
  textAlign(CENTER);
  textFont(sohoscore);
  textSize(92);
  
  if (rightScore < rightScoreNew) {
    if (newTransitionR) {
      newTransitionR = false;
      yRightNew = -60;
    }
    text(rightScoreNew, 850+(75), yRightNew);
    text(rightScore, 850+(75), yRightOld);
    float targetY = 78;
    float dyR = targetY - yRightNew;
    yRightNew += dyR * scoreEasing;
    yRightOld += dyR * scoreEasing;
    if (dyR < 0.1 && dyR > -0.1) {
      rightScore = rightScoreNew;
      yRightNew = -60;
      yRightOld = 78;
      bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else if (rightScore > rightScoreNew) {
    if (newTransitionR) {
      newTransitionR = false;
      yRightNew = 216;
    }
    text(rightScoreNew, 850+(75), yRightNew);
    text(rightScore, 850+(75), yRightOld);
    float targetY = 78;
    float dyR = targetY - yRightNew;
    yRightNew += dyR * scoreEasing;
    yRightOld += dyR * scoreEasing;
    if (dyR < 0.1 && dyR > -0.1) {
      rightScore = rightScoreNew;
      yRightNew = -60;
      yRightOld = 78;
      bugServer.write("set\n" + "score\n" + "right\n" + rightScore + "\n");
    }
  } else {
    text(rightScore, 850+(75), 78);
  }
  
  fill(tintR,230);
  textAlign(LEFT);
  textFont(sohoscore);
  textSize(59);
  text(rightTeam.toUpperCase(), 1017, 59);
  
  rectMode(CORNERS);
  if (timeoutsR > 0) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1017, 72, 1087, 80);
  if (timeoutsR > 1) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1097, 72, 1167, 80);
  if (timeoutsR > 2) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1177, 72, 1247, 80);
  if (timeoutsR > 3) {
    fill(tintR, 230);
  } else {
    fill(tintR, 100);
  }
  rect(1257, 72, 1327, 80);
  
  if (rightBonus) {
    fill(tintR, 200);
    rect(scoreBoardWidth, 60, scoreBoardWidth-30, 90);
    fill(rightScoreFill);
    textAlign(CENTER);
    textFont(sohoscore);
    textSize(28);
    text("B", scoreBoardWidth-15, 85);
  }
}
