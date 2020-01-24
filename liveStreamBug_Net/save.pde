void saveData() {
  if (frameCount % 3600 == 0) {
    boolean errors = false;
    String[] array = new String[saveItems];
    for (int i = 0; i<array.length; i++) array[i] = "placeholder";
    try {
      array[0] = str(leftLightMode);
      array[1] = str(rightLightMode);
      array[2] = str(leftBonus);
      array[3] = str(rightBonus);
      array[4] = str(currentSeconds);
      array[5] = str(currentMinutes);
      array[6] = bottomMessageLive;
      array[7] = bottomMessageEdit;
      array[8] = leftTeam;
      array[9] = rightTeam;
      array[10] = str(leftScore);
      array[11] = str(rightScore);
      array[12] = str(quarter);
      array[13] = str(timeoutsL);
      array[14] = str(timeoutsR);
      array[15] = hex(leftColor).toLowerCase();
      array[16] = hex(rightColor).toLowerCase();
      array[17] = hex(keyColor).toLowerCase();
    } catch (NullPointerException e) {
      errors = true;
    }
    if (errors) {
      println("Didn't save properly");
    } else {
      saveStrings("data/savedData.txt", array);
    }
  }
}
