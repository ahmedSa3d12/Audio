import 'package:flutter/material.dart';

class MusicAnimation extends StatefulWidget {
  const MusicAnimation({Key? key, required this.duration, required this.color}) : super(key: key);
final int duration;
final Color color;
  @override
  State<MusicAnimation> createState() => _MusicAnimationState();
}

class _MusicAnimationState extends State<MusicAnimation> with SingleTickerProviderStateMixin{
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration));
    final curveraniomation=CurvedAnimation(parent: animationController!, curve: Curves.easeInOut);
 animation=Tween<double>(begin: 0,end: 100).animate(curveraniomation)..addListener(() {
   setState(() {

   });

 });
    animationController!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 4,
      height: animation!.value,
      decoration: BoxDecoration(color: widget.color,
      borderRadius: BorderRadius.circular(5)),
    );
  }
}
class MusicList extends StatelessWidget{
  List<Color> colors=[Colors.red,Colors.blue,Colors.yellow,Colors.redAccent,Colors.green];
  List<int> duraton=[900,700,600,800,500];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: new List<Widget>.generate(35, (index) => MusicAnimation(duration: duraton[index%5], color: colors[index%5])),
   );
  }

}