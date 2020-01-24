void requestHandler(String input, Client requester) {
  String data[] = input.split("\n");
  try {
    if (data[0].equalsIgnoreCase("hello.score")) {
      requester.write("welcome.score\n" + leftLightMode + "\n" + leftColor + "\n" + leftTeam + "\n" + leftScore + "\n" + rightLightMode + "\n" + rightColor + "\n" + rightTeam + "\n" + rightScore + "\n");
    } else if (data[0].equalsIgnoreCase("hello.ctrl")) {
      requester.write("welcome.ctrl\n" + leftLightMode + "\n" + leftColor + "\n" + leftTeam + "\n" + leftBonus + "\n" + rightLightMode + "\n" + rightColor + "\n" + rightTeam + "\n" + rightBonus + "\n" + bottomMessageEdit + "\n" + keyColor + "\n");
    } else if (data[0].equalsIgnoreCase("update")) {
      if (data[1].equalsIgnoreCase("score")) {
        if (data[2].equalsIgnoreCase("left")) {
          if (leftScoreNew == leftScore) {
            leftScoreNew = leftScore + int(data[3]);
            newTransitionL = true;
          }
        } else if (data[2].equalsIgnoreCase("right")) {
          if (rightScoreNew == rightScore) {
            rightScoreNew = rightScore + int(data[3]);
            newTransitionR = true;
          }
        }
      } else if (data[1].equalsIgnoreCase("timeouts")) {
        if (data[2].equalsIgnoreCase("left")) {
          if (data[3].equalsIgnoreCase("+1")) {
            if (timeoutsL < 4) {
              timeoutsL++;
            }
          } else if (data[3].equalsIgnoreCase("-1")) {
            if (timeoutsL > 0) {
              timeoutsL--;
            }
          }
        } else if (data[2].equalsIgnoreCase("right")) {
          if (data[3].equalsIgnoreCase("+1")) {
            if (timeoutsR < 4) {
              timeoutsR++;
            }
          } else if (data[3].equalsIgnoreCase("-1")) {
            if (timeoutsR > 0) {
              timeoutsR--;
            }
          }
        }
      } else if (data[1].equalsIgnoreCase("quarter")) {
        if (data[2].equalsIgnoreCase("-")) {
          if (quarter > 0) {
            quarter--;
          }
        } else if (data[2].equalsIgnoreCase("+")) {
          quarter++;
        }
      }
    } else if (data[0].equalsIgnoreCase("set")) {
      if (data[1].equalsIgnoreCase("score")) {
        if (data[2].equalsIgnoreCase("left")) {
          if (leftScoreNew == leftScore) {
            leftScoreNew = int(data[3]);
            newTransitionL = true;
          }
        } else if (data[2].equalsIgnoreCase("right")) {
          if (rightScoreNew == rightScore) {
            rightScoreNew = int(data[3]);
            newTransitionR = true;
          }
        }
      } else if (data[1].equalsIgnoreCase("name")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftTeam = data[3];
          bugServer.write("set\n" + "name\n" + "left\n" + leftTeam + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightTeam = data[3];
          bugServer.write("set\n" + "name\n" + "right\n" + rightTeam + "\n");
        }
      } else if (data[1].equalsIgnoreCase("color")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftColor = unhex(data[3]);
          bugServer.write("set\n" + "color\n" + "left\n" + hex(leftColor).toLowerCase() + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightColor = unhex(data[3]);
          bugServer.write("set\n" + "color\n" + "right\n" + hex(rightColor).toLowerCase() + "\n");
        } else if (data[2].equalsIgnoreCase("key")) {
          keyColor = unhex(data[3]);
          bugServer.write("set\n" + "color\n" + "key\n" + hex(keyColor).toLowerCase() + "\n");
        }
      } else if (data[1].equalsIgnoreCase("lightMode")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftLightMode = boolean(data[3]);
          bugServer.write("set\n" + "lightMode\n" + "left\n" + str(leftLightMode) + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightLightMode = boolean(data[3]);
          bugServer.write("set\n" + "lightMode\n" + "right\n" + str(rightLightMode) + "\n");
        }
      } else if (data[1].equalsIgnoreCase("time")) {
        minutes = float(data[2]);
        seconds = float(data[3]);
        currentSeconds = seconds;
        currentMinutes = minutes;
      } else if (data[1].equalsIgnoreCase("message")) {
        bottomMessageEdit = spacer(data[2]);
      }
    } else if (data[0].equalsIgnoreCase("toggle")) {
      if (data[1].equalsIgnoreCase("time")) {
        if (!timeRunning) {
          timeStarted = true;
        } else {
          timeStopped = true;
        }
      } else if (data[1].equalsIgnoreCase("messageVis")) {
        if (messageIsShowing == false) {
          messageAction = "show";
        } else {
          messageAction = "hide";
        }
      } else if (data[1].equalsIgnoreCase("switchMessage")) {
        if (!transitioningMessage) {
          newTransitionMessage = true;
          //println("enter pressed");
        }
      } else if (data[1].equalsIgnoreCase("bonus")) {
        if (data[2].equalsIgnoreCase("left")) {
          leftBonus = !leftBonus;
          //bugServer.write("set\n" + "bonus\n" + "left\n" + leftBonus + "\n");
        } else if (data[2].equalsIgnoreCase("right")) {
          rightBonus = !rightBonus;
          //bugServer.write("set\n" + "bonus\n" + "right\n" + rightBonus + "\n");
        }
      } else if (data[1].equalsIgnoreCase("scoreboard")) {
        if (scoreBoardTransitioning == false) {
          scoreBoardTransitioning = true;
        }
      }
    }
  } catch (NullPointerException rip) {} catch (ArrayIndexOutOfBoundsException rip) {
  }
  
}
