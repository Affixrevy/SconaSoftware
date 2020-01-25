void drawTime() {
  
  //Set font, colour, and alignment varialbes for main time
  textFont(din);
  textSize(82);
  textAlign(CENTER);
  fill(255);
  
  //Variables for the position of the main time
  int minuiteXSpacing = 48;
  int secondXSpacingConstant = 14;
  int YSpacing = 5;
  int scoreX = 960;
  int scoreY = 960;
  
  
  //Area to simplify if I have time ********************************************************************************
  
  //Draw the clock if it is not displaing the final minuite
  if (!tenthsMode) {
    text(finalMinutes, scoreX - minuiteXSpacing, scoreY+5);
    text(":", scoreX, scoreY - 5);
    text(finalSeconds, scoreX + minuiteXSpacing, scoreY+5);
    
  //Draw the clock if it is displaying the final minuite
  } else {
    textAlign(RIGHT);
    text(finalSeconds, scoreX- 3 + secondXSpacingConstant, scoreY+5);
    textAlign(CENTER);
    text(".", scoreX+6+secondXSpacingConstant, scoreY+4);
    textAlign(LEFT);
    text(finalTenths, scoreX+16+secondXSpacingConstant, scoreY+5);
  } 
  
  //Set font, colour, and alignment varialbes for Shot clock time
  textSize(40);
  fill(255, 255, 0);
  
  //Variables for the position of the main time
  int shotclockX = 1007;
  int shotclockY = 1013;
  
  //Draw shot clock time
  text(shotClockSeconds, shotclockX, shotclockY);
  
}
