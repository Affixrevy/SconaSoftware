void pullXML() {
  try {
    scoreSheet = loadXML("Nevco MPC0.xml");
  } 
  catch (RuntimeException e) {
    String test[] = loadStrings("Nevco MPC0.xml");
    for (String s : test) {
      println(s);
    }
    println(e);
  }

  //Get Away Score
  int leftScoreTemp = Integer.parseInt(scoreSheet.getChild("GUEST_SCORE").getContent());
  if (leftScoreTemp != leftScore) {
    leftScoreNew = leftScoreTemp;
  }

  //Get Home Score
  int rightScoreTemp = Integer.parseInt(scoreSheet.getChild("HOME_SCORE").getContent());
  if (rightScoreTemp != rightScore) {
    rightScoreNew = rightScoreTemp;
  }

  int foulLTemp = Integer.parseInt(scoreSheet.getChild("HOME_FOULS").getContent());
  /*if(foulL != foulLTemp) {
   foulL = foulLTemp;
   }*/


  String foulRStr = scoreSheet.getChild("GUEST_FOULS").getContent();
  if (foulRStr != "") {
    int foulRTemp = Integer.parseInt(foulRStr);
  }

  //Get Home Timeouts
  String timeoutLeftHome = scoreSheet.getChild("HOME_TIMEOUTS_LEFT").getContent();
  if (timeoutLeftHome != "") {
    rightTimeouts = Integer.parseInt(timeoutLeftHome);
  }

  //Get Away Timeouts
  String timeoutLeftAway = scoreSheet.getChild("GUEST_TIMEOUTS_LEFT").getContent();
  if (timeoutLeftAway != "") {
    leftTimouts = Integer.parseInt(timeoutLeftAway);
  }

  //Get Shot Clock
  String shotClockStr = scoreSheet.getChild("SHOT_CLOCK_SECONDS").getContent();
  if (shotClockStr != "") {
    shotClockSeconds = Integer.parseInt(shotClockStr);
  }

  //Get Game Quarter
  String quarterStr = scoreSheet.getChild("GLOBAL_DATA_GAME_PERIOD").getContent();
  if (quarterStr != "") {
    quarter = Integer.parseInt(quarterStr);
  }
}


//setTime(scoreSheet.getChild("MAIN_TIME").getContent());

//quarter = Integer.parseInt(sheet[].getContent());
//timeoutsL = Integer.parseInt(sheet[12].getContent());
//timeoutsR = Integer.parseInt(sheet[22].getContent());



boolean isOne(int xmlValue) {
  if (xmlValue == 1) {
    return true;
  } else {
    return false;
  }
}

void setTime(String currentTime) {
  //println(currentTime);
  if (currentTime.contains(".")) {
    tenthsMode = true;
    finalSeconds = currentTime.substring(0, currentTime.indexOf("."));
    finalTenths = currentTime.substring(currentTime.indexOf(".")+1);
  } else {
    tenthsMode = false;
    finalMinutes = currentTime.substring(0, currentTime.indexOf(":"));
    finalSeconds = currentTime.substring(currentTime.indexOf(":")+1);
  }
}
