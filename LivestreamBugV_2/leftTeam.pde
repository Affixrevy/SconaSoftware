void awayTeam() {
  
  textAlign(CENTER);
  textFont(din);
  textSize(100);
  
  int leftPos = 470;

  if (scoreAway < newScoreAway) {
    if (newTransitionAway) {
      newTransitionAway = false;
      yLeftNew = 934;
    }
    text(newScoreAway, 340+(leftPos), yLeftNew);
    text(scoreAway, 340+(leftPos), yLeftOld);
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
    text(newScoreAway, 340+(leftPos), yLeftNew);
    text(scoreAway, 340+(leftPos), yLeftOld);
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
    text(scoreAway, 340+(leftPos), 984);
  }
}
