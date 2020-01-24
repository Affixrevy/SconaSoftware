void pullXML() {
  try{
    scoreSheet = loadXML("Nevco MPC0.xml");
  } catch (RuntimeException e) {
    String test[] = loadStrings("Nevco MPC0.xml");
    for(String s: test) {
      println(s); 
    }
    println(e);
    
  }
  //XML[] sheet = scoreSheet.getChildren("SCOREBOARD_DATA");
  //println(scoreSheet.listChildren());
  
  //for(int i = 0; i < sheet.length; i++){
    //println(sheet[i]);
  //}
  
    //leftBonus = isOne(sheet[13].getInt("HOME_BONUS_INDICATOR"));
    //rightBonus = isOne(sheet[23].getInt("GUEST_BONUS_INDICATOR"));
    
    
    int leftScoreTemp = Integer.parseInt(scoreSheet.getChild("GUEST_SCORE").getContent());
    if(leftScoreTemp != leftScore){
      leftScoreNew = leftScoreTemp;
    }
    
    int rightScoreTemp = Integer.parseInt(scoreSheet.getChild("HOME_SCORE").getContent());
    if(rightScoreTemp != rightScore){
      rightScoreNew = rightScoreTemp;
    }
    
    int foulLTemp = Integer.parseInt(scoreSheet.getChild("HOME_FOULS").getContent());
    if(foulL != foulLTemp) {
      foulL = foulLTemp;
    }
    
    String foulRStr = scoreSheet.getChild("GUEST_FOULS").getContent();
    if(foulRStr != ""){
      int foulRTemp = Integer.parseInt(foulRStr);
    if(foulR != foulRTemp) {
      foulR = foulRTemp;
    }
  
}
    
    
    setTime(scoreSheet.getChild("MAIN_TIME").getContent());
    
    //quarter = Integer.parseInt(sheet[].getContent());
    //timeoutsL = Integer.parseInt(sheet[12].getContent());
    //timeoutsR = Integer.parseInt(sheet[22].getContent());
    
}

boolean isOne(int xmlValue) {
  if(xmlValue == 1) {
    return true;
  } else {
    return false;
  }
}

void setTime(String currentTime) {
  //println(currentTime);
  if(currentTime.contains(".")){
    tenthsMode = true;
    finalSeconds = currentTime.substring(0, currentTime.indexOf("."));
    finalTenths = currentTime.substring(currentTime.indexOf(".")+1);
  } else {
    tenthsMode = false;
    finalMinutes = currentTime.substring(0, currentTime.indexOf(":"));
    finalSeconds = currentTime.substring(currentTime.indexOf(":")+1);
  }
}
