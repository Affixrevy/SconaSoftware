void center() {
  rectMode(CORNERS);
  fill(#424242);
  rect(650, 0, 850, 90);
  fill(255);
  textFont(din);
  textSize(55);
  textAlign(CENTER);
  timer();
  stringify();
  if (!tenthsMode) {
    text(finalMinutes, (scoreBoardWidth/2)-34, (90/2)+5);
    text(":", scoreBoardWidth/2, (90/2)-5);
    text(finalSeconds, (scoreBoardWidth/2)+34, (90/2)+5);
  } else {
    textAlign(RIGHT);
    text(finalSeconds, (scoreBoardWidth/2)-7, (90/2)+5);
    textAlign(CENTER);
    text(".", (scoreBoardWidth/2)+2, (90/2)+4);
    textAlign(LEFT);
    text(finalTenths, (scoreBoardWidth/2)+11, (90/2)+5);
  }
  textSize(25);
  textAlign(CENTER);
  if (quarter == 0) {
    text("PRE-GAME", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 1) {
    text("1ST", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 2) {
    text("2ND", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 3) {
    text("3RD", scoreBoardWidth/2, (90)-10);
  } else if (quarter == 4) {
    text("4TH", scoreBoardWidth/2, (90)-10);
  } else {
    text("OT " + (quarter-4), scoreBoardWidth/2, (90)-10);
  }
}
