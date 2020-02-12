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

  //Get Current Time and Call setTime Method
  String currentTimeStr = scoreSheet.getChild("MAIN_TIME").getContent();
  if (currentTimeStr != "") {
    setTime(currentTimeStr);
  }


  //Get Away Score - Check if XML value is null, if not parse the score to int so scoreboard can be set to the value
  String leftScoreStr = scoreSheet.getChild("GUEST_SCORE").getContent();
  if (!leftScoreStr.equals(str(scoreAway)) && leftScoreStr != "") {
    newScoreAway = Integer.parseInt(leftScoreStr);
    changesMade = true;
  }

  //Get Home Score - Check if XML value is null, if not parse the score to int so scoreboard can be set to the value
  String rightScoreStr = scoreSheet.getChild("HOME_SCORE").getContent();
  if (!rightScoreStr.equals(str(scoreHome)) && rightScoreStr != "") {
    newScoreHome = Integer.parseInt(rightScoreStr);
    changesMade = true;
  }

  //Get Home Fouls - Check if XML value is null, if not parse the score to int and call a method to drop down fouls tab
  String foulHomeStr = scoreSheet.getChild("HOME_FOULS").getContent();
  if (!foulHomeStr.equals("") && !foulHomeStr.equals(str(foulsHome))) {
    foulsHome = Integer.parseInt(foulHomeStr);
    println(foulsHome);
    //dropFoulHome();
    changesMade = true;
  }

  //Get Away Fouls - Check if XML value is null, if not parse the score to int and call a method to drop down fouls tab
  String foulAwayStr = scoreSheet.getChild("GUEST_FOULS").getContent();
  if (foulAwayStr != "" && !foulAwayStr.equals(str(foulsAway))) {
    foulsAway = Integer.parseInt(foulAwayStr);
    //dropFoulAway();
    changesMade = true;
  }

  //Get Home Timeouts - Check if XML value is null, if not parse the score to int so correct number of circles show
  String timeoutLeftHomeStr = scoreSheet.getChild("HOME_TIMEOUTS_LEFT").getContent();
  if (timeoutLeftHomeStr != "") {
    timeoutsLeftHome = Integer.parseInt(timeoutLeftHomeStr);
    changesMade = true;
  }

  //Get Away Timeouts - Check if XML value is null, if not parse the score to int so correct number of circles show
  String timeoutLeftAwayStr = scoreSheet.getChild("GUEST_TIMEOUTS_LEFT").getContent();
  if (timeoutLeftAwayStr != "") {
    timeoutsLeftAway = Integer.parseInt(timeoutLeftAwayStr);
    changesMade = true;
  }

  String homeBonusStr = scoreSheet.getChild("HOME_BONUS_INDICATOR").getContent();
  if (!homeBonusStr.equals("") && homeBonusStr.equals("1")) {
    if (!bonusHome) {
      bonusHome = true;
      dropFoulHome();
    }
  } else {
    if (bonusHome) {
      bonusHome = false;
      retractFoulHome();
    }
  }

  String awayBonusStr = scoreSheet.getChild("GUEST_BONUS_INDICATOR").getContent();
  if (!awayBonusStr.equals("") && awayBonusStr.equals("1")) {
    if (!bonusAway) {
      bonusAway = true;
      dropFoulAway();
    }
  } else {
    if (bonusAway) {
      bonusAway = false;
      retractFoulAway();
    }
  }

  //Get Shot Clock -  Check if XML value is null, if not parse the score to int so scoreboard can be set to the value
  String shotClockTemp = scoreSheet.getChild("SHOT_CLOCK_SECONDS").getContent();
  if (shotClockTemp != "") {

    if (shotClockTemp.charAt(0) != '7') {
      shotClockSeconds = shotClockTemp;
    } else {
      shotClockSeconds = shotClockTemp.substring(1);
    }
    changesMade = true;
  }

  //Get Game Quarter - Check if XML value is null, if not parse the score to int and call function when the quarter changes
  String quarterTemp = scoreSheet.getChild("GLOBAL_DATA_GAME_PERIOD").getContent();
  if (!quarterTemp.equals(quarter)) {
    quarter = quarterTemp;
    bugCenter = loadImage("Livestream_Bug_V2_DATA/center/Quarter"+quarter+".png");
    changesMade = true;
  }
}

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
    finalMinutes = "0"+currentTime.substring(1, currentTime.indexOf(":"));
    finalSeconds = currentTime.substring(currentTime.indexOf(":")+1);
  }
}
