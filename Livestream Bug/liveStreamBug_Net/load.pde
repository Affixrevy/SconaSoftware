void loadData() {
  try {
    String[] data = loadStrings("data/savedData.txt");
    leftLightMode = boolean(data[0]);
    rightLightMode = boolean(data[1]);
    leftBonus = boolean(data[2]);
    rightBonus = boolean(data[3]);
    seconds = float(data[4]);
    minutes = float(data[5]);
    bottomMessageLive = data[6];
    bottomMessageEdit = data[7];
    leftTeam = data[8];
    rightTeam = data[9];
    leftScore = int(data[10]);
    rightScore = int(data[11]);
    quarter = int(data[12]);
    timeoutsL = int(data[13]);
    timeoutsR = int(data[14]);
    leftColor = unhex(data[15]);
    rightColor = unhex(data[16]);
    keyColor = unhex(data[17]);
  } catch (NullPointerException rip) {} catch (ArrayIndexOutOfBoundsException rip2) {}
}
