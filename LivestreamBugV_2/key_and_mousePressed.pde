void keyPressed() {
  if /*(key == ' ') {
    if (quarter < 4) {
      quarter++;
    } else {
      quarter = 1;
    }
    bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
  } else if */(key == 'l') {
    if (newScoreAway == scoreAway) {
      newScoreAway = scoreAway + 1;
      newTransitionAway = true;
    }
  } else if (key == 'k') {
    if (newScoreHome == scoreHome) {
      newScoreHome = scoreHome + 1;
      newTransitionHome = true;
    }
  } else if (key == ' ') {
    if(!messageDisplayingAway){
       dropFoulAway();
    } else {
      retractFoulAway(); 
    }
  }
}

void mousePressed() {
  println(mouseX + " - " + mouseY);
}
