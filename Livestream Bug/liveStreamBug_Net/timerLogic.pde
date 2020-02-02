  void timer() {

  if (timeStarted) {
    startTime = millis();
    //println(startTime);
    timeStarted = false;
    timeRunning = true;
  }

  if (timeStopped) {
    timeStopped = false;
    timeRunning = false;
    seconds = currentSeconds;
  }
  
  if (timeRunning) {
    currentSeconds = (seconds - ((millis()-startTime)/1000));
    
    
    println(seconds - ((millis()-startTime)/1000));
    
    //println("timeRunning");
    if (currentSeconds < 0) {
      currentSeconds = 59.999;
      seconds = 59.999;
      currentMinutes--;
      timeStarted = true;
    }

    if (currentMinutes < 0) {
      currentMinutes = 0;
      currentSeconds = 0;
      timeStopped = true;
      println("time autostopped");
    }
  }
  
  if (currentMinutes < 1) {
    tenthsMode = true;
  } else {
    tenthsMode = false;
  }
  
  
  //println(currentSeconds);
}
