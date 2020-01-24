void leftTeam() {


  textAlign(CENTER);
  textFont(din);
  textSize(106);

  if (leftScore < leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = -60;
    }
    text(leftScoreNew, 900+(75), yLeftNew);
    text(leftScore, 1500+(75), yLeftOld);
    float targetY = 984;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      leftScore = leftScoreNew;
      yLeftNew = -970;
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
    float targetY = 984;
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
    text(leftScore, 340+(745), 984);
  }
}
