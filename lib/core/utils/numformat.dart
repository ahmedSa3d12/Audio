formatedTime({required int timeInSecond}) {
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  return (int.parse(minute) / 60);
}
