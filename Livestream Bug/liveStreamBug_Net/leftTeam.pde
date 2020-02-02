void leftTeam() {
  if (leftLightMode) {
    tintL = 255;
    leftScoreFill = 0;
  } else {
    tintL = 0;
    leftScoreFill = 255;
  }
  rectMode(CORNERS);
  fill(leftColor);
  rect(0, 0, 650, 90);
  fill(tintL, 200);
  rect(500, 0, 650, 90);
  fill(leftScoreFill);
  textAlign(CENTER);
  textFont(sohoscore);
  textSize(92);
  
  if (leftScore < leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = -60;
    }
    text(leftScoreNew, 500+(75), yLeftNew);
    text(leftScore, 500+(75), yLeftOld);
    float targetY = 78;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      leftScore = leftScoreNew;
      yLeftNew = -60;
      yLeftOld = 78;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else if (leftScore > leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = 216;
    }
    text(leftScoreNew, 500+(75), yLeftNew);
    text(leftScore, 500+(75), yLeftOld);
    float targetY = 78;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      leftScore = leftScoreNew;
      yLeftNew = -60;
      yLeftOld = 78;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else {
    text(leftScore, 500+(75), 78);
  }
  
  fill(tintL,230);
  textAlign(RIGHT);
  textFont(sohoscore);
  textSize(59);
  text(leftTeam.toUpperCase(), 483, 59);
  
  // timeouts
  rectMode(CORNERS);
  if (timeoutsL > 0) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(413, 72, 483, 80);
  if (timeoutsL > 1) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(333, 72, 403, 80);
  if (timeoutsL > 2) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(253, 72, 323, 80);
  if (timeoutsL > 3) {
    fill(tintL, 230);
  } else {
    fill(tintL, 100);
  }
  rect(173, 72, 243, 80);
  
  if (leftBonus) {
    fill(tintL, 200);
    rect(0,60,30,90);
    fill(leftScoreFill);
    textAlign(CENTER);
    textFont(sohoscore);
    textSize(28);
    text("B", 15, 85);
  }
  
}
