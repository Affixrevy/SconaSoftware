void mask() {
  rectMode(CORNERS);
  fill(keyColor);
  rect(0, 0, width, displaceY);
  rect(0, displaceY+scoreBoardHeight+messageY, width, height);
}
