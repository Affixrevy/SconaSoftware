void leftTeam() {
  
  textAlign(CENTER);
  textFont(din);
  textSize(100);
  
  int leftPos = 470;

  if (leftScore < leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = 934;
    }
    text(leftScoreNew, 340+(leftPos), yLeftNew);
    text(leftScore, 340+(leftPos), yLeftOld);
    float targetY = 984;
    float dyR = targetY - yLeftNew;
    yLeftNew += dyR * scoreEasing;
    yLeftOld += dyR * scoreEasing;
    if (dyR < 0.1 && dyR > -0.1) {
      leftScore = leftScoreNew;
      yLeftNew = 934;
      yLeftOld = 1034;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else if (leftScore > leftScoreNew) {
    if (newTransitionL) {
      newTransitionL = false;
      yLeftNew = 216;
    }
    text(leftScoreNew, 340+(leftPos), yLeftNew);
    text(leftScore, 340+(leftPos), yLeftOld);
    float targetY = 984;
    float dyL = targetY - yLeftNew;
    yLeftNew += dyL * scoreEasing;
    yLeftOld += dyL * scoreEasing;
    if (dyL < 0.1 && dyL > -0.1) {
      leftScore = leftScoreNew;
      yLeftNew = 934;
      yLeftOld = 1034;
      //bugServer.write("set\n" + "score\n" + "left\n" + leftScore + "\n");
    }
  } else {
    text(leftScore, 340+(leftPos), 984);
  }
}
