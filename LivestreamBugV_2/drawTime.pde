void drawTime() {
  textFont(din);
  textSize(82);
  textAlign(CENTER);
  
  /****************************************************ARTHUR CHANGE******************************************************************/
  //timer();
  //stringify();
  //End Arthur Change
  
  int scoreX = 960;
  int scoreY = 960;
  if (!tenthsMode) {
    text(finalMinutes, scoreX - 34, scoreY+5);
    text(":", scoreX, scoreY - 5);
    text(finalSeconds, scoreX + 34, scoreY+5);
  } else {
    textAlign(RIGHT);
    text(finalSeconds, scoreX-7, scoreY+5);
    textAlign(CENTER);
    text(".", scoreX+2, scoreY+4);
    textAlign(LEFT);
    text(finalTenths, scoreX+11, scoreY+5);
  } 
}
