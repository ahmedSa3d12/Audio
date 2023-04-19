import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/hex_color.dart';
import '../widgets/item_one_class_widget.dart';

class ClassesScreen extends StatelessWidget {
  ClassesScreen({Key? key}) : super(key: key);

  List<String> classNumber = ['الفصل الاول', 'الفصل الثانى', 'الفصل الثالث'];
  List<String> classTitle = ['عنوان 1', 'عنوان 2', 'عنوان 3'];
  List<String> classPresents = ['50', '20', '0'];
  List<String> lessonsNumbers = ['3', '2', '4'];
  List<String> videoNumbers = ['5', '2', '5'];
  List<String> hourNumbers = ['2', '1', '3'];
  List<Color> mainColors = [
    HexColor('#48B8E0'),
    HexColor('#E4312A'),
    HexColor('#009541'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTripCubit, StartTripState>(
      builder: (context, state) {
        StartTripCubit cubit = context.read<StartTripCubit>();
        if (state is StartTripExplanationLoading) {
          return ShowLoadingIndicator();
        }
        if (state is StartTripExplanationError) {
          return NoDataWidget(
            onclick: () {
              cubit.getExplanationData();
            },
            title: 'no_date',
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            print(010101010101010);
            cubit.getExplanationData();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .80,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              itemCount: cubit.classesData.length,
              itemBuilder: (BuildContext context, int index) {
                print(cubit.classesData[index].totalTimes);
                return ItemOfOneClassWidget(
                  classNum: cubit.classesData[index].title!,
                  classTitle: cubit.classesData[index].name!,
                  classPresentFinished:
                      cubit.classesData[index].totalWatch.toString(),
                  lessonNum: cubit.classesData[index].numOfLessons.toString(),
                  videoNum: cubit.classesData[index].numOfVideos.toString(),
                  hourNum: cubit.classesData[index].totalTimes.toString(),
                  mainColor:
                      HexColor(cubit.classesData[index].backgroundColor!),
                  imagePath: cubit.classesData[index].image!,
                  status: cubit.classesData[index].status!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
