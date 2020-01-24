void stringify() {
  if (currentSeconds >= 10 || tenthsMode) {
    finalSeconds = str(currentSeconds);
  } else {
    finalSeconds = "0" + str(currentSeconds);
  }
  if (finalSeconds.indexOf(".") != -1) {
    finalTenths = finalSeconds.substring(finalSeconds.indexOf(".") + 1, finalSeconds.indexOf(".") + 2);
    finalSeconds = finalSeconds.substring(0, finalSeconds.indexOf("."));
    
  } else {
    finalTenths = "0";
  }

  if (currentMinutes >= 10) {
    finalMinutes = str(currentMinutes);
  } else {
    finalMinutes = "0" + str(currentMinutes);
  }
  if (finalMinutes.indexOf(".") != -1) {
    finalMinutes = finalMinutes.substring(0, finalMinutes.indexOf("."));
  }
  
  //println(finalMinutes + ":" + finalSeconds);
  
}
