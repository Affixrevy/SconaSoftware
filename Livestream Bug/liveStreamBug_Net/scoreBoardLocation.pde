void placeScoreBoard() {
  if (scoreBoardShowing && !scoreBoardTransitioning) {
    displaceY = scoreBoardYUp;
  } else if (!scoreBoardShowing && !scoreBoardTransitioning) {
    displaceY = scoreBoardYDown;
  } else if (scoreBoardShowing && scoreBoardTransitioning) {
    //moving down
    float targetY = scoreBoardYDown;
    float dy1 = targetY - displaceY;
    displaceY += dy1 * scoreBoardEasing;
    if (dy1 < 0.01) {
      //end animation
      scoreBoardShowing = false;
      scoreBoardTransitioning = false;
    }
  } else if (!scoreBoardShowing && scoreBoardTransitioning) {
    //moving up
    float targetY = scoreBoardYUp;
    float dy2 = targetY - displaceY;
    displaceY += dy2 * scoreBoardEasing;
    if (dy2 > -0.01) {
      //end animation
      scoreBoardShowing = true;
      scoreBoardTransitioning = false;
    }
  }
}
