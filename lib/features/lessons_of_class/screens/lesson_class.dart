import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/lessons_of_class/cubit/lessons_class_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/my_painter_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../widgets/lesson_class_item_widget.dart';

class LessonsClassScreen extends StatefulWidget {
  const LessonsClassScreen({Key? key, required this.classId}) : super(key: key);
  final int classId;

  @override
  State<LessonsClassScreen> createState() => _LessonsClassScreenState();
}

class _LessonsClassScreenState extends State<LessonsClassScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LessonsClassCubit>().getLessonsClassData(widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<LessonsClassCubit, LessonsClassState>(
              builder: (context, state) {
                LessonsClassCubit cubit = context.read<LessonsClassCubit>();
                if (state is LessonsClassLoading) {
                  return ShowLoadingIndicator();
                }
                if (state is LessonsClassError) {
                  return NoDataWidget(onclick: () {}, title: 'no_date');
                }
                return Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cubit.getLessonsClassData(widget.classId);
                    },
                    child: ListView(
                      children: [
                        SizedBox(height: 115),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            height: 180,
                            width: MediaQuery.of(context).size.width - 80,
                            child: Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: MediaQuery.of(context).size.width *
                                        0.25,
                                    bottom: 0,
                                    child: ClipPath(
                                      clipper: CCustomClipper(),
                                      child: ManageNetworkImage(
                                        imageUrl: cubit.oneClass.image ??
                                            "https://elmazone.topbusiness.io/sliders/1.jpg",
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CustomPaint(
                                      size: Size(
                                        180,
                                        115,
                                      ),
                                      painter: MyPainter(
                                        HexColor(
                                          cubit.oneClass.backgroundColor!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Stack(
                                      children: [
                                        CustomPaint(
                                          size: Size(
                                            250,
                                            80,
                                          ),
                                          painter: MyPainter(
                                            darken(
                                              HexColor(
                                                cubit.oneClass.backgroundColor!,
                                              ),
                                              0.2,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 6,
                                          left: 55,
                                          right: 15,
                                          child: Text(
                                            cubit.oneClass.name!,
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(3.0, 3.0),
                                                  blurRadius: 3.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 2,
                                    right: 8,
                                    child: Text(
                                      cubit.oneClass.title!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ...List.generate(
                          cubit.lessons.length,
                          (index) => LessonClassItemWidget(
                            model: cubit.lessons[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(isHome: false),
            ),
          ],
        ),
      ),
    );
  }
}

class CCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.06578947);
    path_0.cubicTo(0, size.height * 0.02945493, size.width * 0.01139224, 0,
        size.width * 0.02544529, 0);
    path_0.lineTo(size.width * 0.65, 0);
    path_0.lineTo(size.width * 0.99, size.height);
    path_0.lineTo(size.width * 0.02544529, size.height);
    path_0.cubicTo(size.width * 0.01139224, size.height, 0,
        size.height * 0.9705461, 0, size.height * 0.9342105);
    path_0.lineTo(0, size.height * 0.06578947);
    path_0.close();

    return path_0;

    // final double heightDelta = size.height / 2.2;

    // Path()
    //  ..addRect(
    //      Rect.fromLTWH(35, 120, 260, 160))
    //  ;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
