void message() {
  if (messageAction.toLowerCase().equals("show") && messageIsShowing == false) {
    messageIsMoving = true;
  } else if (messageAction.toLowerCase().equals("hide") && messageIsShowing == true) {
    messageIsMoving = true;
  }
  if (messageIsMoving == true && messageAction.toLowerCase().equals("show")) {
    float targetY = 0;
    float dy = targetY - messageY;
    messageY += dy * messageEasing;
    if (dy < 0.1 && dy > -0.1) {
      messageIsMoving = false;
      messageAction = "";
      messageIsShowing = true;
    }
  } else if (messageIsMoving == true && messageAction.toLowerCase().equals("hide")) {
    float targetY = -40;
    float dy = targetY - messageY;
    messageY += dy * messageEasing;
    if (dy < 0.1 && dy > -0.1) {
      messageIsMoving = false;
      messageAction = "";
      messageIsShowing = false;
    }
  }
  pushMatrix();
  translate(0,messageY);
  rectMode(CORNERS);
  fill(#263238);
  rect(0, 90, scoreBoardWidth, scoreBoardHeight);
  textAlign(CENTER);
  textFont(din);
  textSize(28);
  if (newTransitionMessage) {
    transitioningMessage = true;
    newTransitionMessage = false;
  }
  if (transitioningMessage) {
    fill(240, messageLiveOpacity);
    text(bottomMessageLive.toUpperCase(), scoreBoardWidth/2, 120);
    fill(240, messageEditOpacity);
    text(bottomMessageEdit.toUpperCase(), scoreBoardWidth/2, 120);
    messageLiveOpacity = messageLiveOpacity - 5;
    messageEditOpacity = messageEditOpacity + 5;
    if (messageLiveOpacity < 0 && messageEditOpacity >= 255) {
      messageLiveOpacity = 255;
      messageEditOpacity = 0;
      transitioningMessage = false;
      String tempHolder = bottomMessageLive;
      bottomMessageLive = bottomMessageEdit;
      bottomMessageEdit = tempHolder;
      bugServer.write("update\n" + "message\n" + bottomMessageEdit + "\n");
      fill(240, messageLiveOpacity);
    text(bottomMessageLive.toUpperCase(), scoreBoardWidth/2, 120);
    }
  } else {
    fill(240, messageLiveOpacity);
    text(bottomMessageLive.toUpperCase(), scoreBoardWidth/2, 120);
  }
  popMatrix();
}
