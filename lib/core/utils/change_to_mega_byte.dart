String changeToMegaByte(String size) {
  if(size.isEmpty){
    size="0";
  }
  double mySize = double.parse(size);
  print(mySize);
  if (mySize == 1000.0) {
    return '1 MB';
  }else if (mySize < 1024) {
    return '$size KB';
  }   else {
    mySize = mySize / 1024;
    return '${mySize.toStringAsFixed(2).toString()} MB';
  }
}
