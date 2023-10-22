String myTime(String inputTime) {
  List<String> timeParts = inputTime.split(':');
  if (timeParts.length == 3) {
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);
    String formattedTime = (hours == 0)
        ? "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}"
        : "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    return formattedTime;
  } else {
    return inputTime;
  }
}
