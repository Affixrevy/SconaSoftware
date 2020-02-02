void keyPressed() {
  if (key == 'l') {
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
    if (!messageDisplayingHome) {
      println("hi");
      dropFoulHome();
    } else {
      retractFoulHome();
    }
  }
}

void mousePressed() {
  println(mouseX + " - " + mouseY);
}
