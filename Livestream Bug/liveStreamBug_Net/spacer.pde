String spacer(String input) {
  String returnString = "";
  char[] charArray = input.toCharArray();
  for (int i = 0; i<charArray.length; i++) {
    if (charArray[i] != ' ' && i < charArray.length-1) {
      returnString = returnString + charArray[i] + " ";
    } else {
      returnString = returnString + charArray[i];
    }
  }
  return returnString;
}
