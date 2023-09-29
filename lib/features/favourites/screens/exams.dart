import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/favourites/cubit/favourite_cubit.dart';

import '../../../core/utils/hex_color.dart';
import '../../start_trip/widgets/classes_exam_item_widget.dart';
import '../../start_trip/widgets/item_one_class_widget.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit,FavouriteState>(
      
      builder: (context, state) {
        FavouriteCubit cubit = context.read<FavouriteCubit>();
      if(state is LoadingGetFavourite){
        return ShowLoadingIndicator();
      }
      if(state is FailureGetFavourite){
        return NoDataWidget(
            onclick: (){
              cubit.getAllFavourite();
        }, title: "No Data");
      }
      return RefreshIndicator(
        onRefresh: ()async {
          cubit.getAllFavourite();
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: cubit.allFavourite?.data?.onlineExams?.length ??0,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .75,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ) ,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // if (cubit.classesData[index].status == 'lock') {
                    //   toastMessage(
                    //     'open_class'.tr(),
                    //     context,
                    //     color: AppColors.error,
                    //   );
                    // }
                    // else {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => LessonsClassScreen(
                    //         classId: cubit.classesData[index].id!,
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                  child:  ClassesExamItemWidget(
                    index: index,
                    model: cubit.allFavourite!.data!.onlineExams![index],
                  ),

                );
              },
          ),
        ), 
      );
    },);
  }
}
