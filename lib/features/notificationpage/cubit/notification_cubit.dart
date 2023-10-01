
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/models/update_notification.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/navigation_bottom/cubit/navigation_cubit.dart';
import '../../../../core/models/notifications_model.dart';
import '../../../../core/remote/service.dart';
import '../../../config/routes/app_routes.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {

  NotificationCubit(this.api) : super(NotificationInitial()) {
    getAllNotification();
  }

  List<NotificationModel>? data;
  final ServiceApi api;
 // UpdateNotification? updateNotification;
  final List<bool> switches = List.generate(3, (index) => true);

  changeSwitch(bool value,index){
    switches[index] = value ;
    emit(ChangingSwitchCaseState());
  }




  getAllNotification() async {
    emit(NotificationPageLoading());
    final response = await api.getAllNotification();
    response.fold(
      (error) => emit(NotificationPageError()),
      (response) {
        data = response.data;
        emit(NotificationPageLoaded());
      },
    );
  }

  notificationUpdate(int index , BuildContext context ) async {
     final response = await api.updateNotification(data![index].id!);
     response.fold(
             (l) => emit(FailedToUpdateState()),
             (r) async {
               if(r.code == 200 || r.code == 201)
                 data![index].seen = "seen";
               data![index] = r.data!;
               emit(SuccessUpdateState());
               //couldn't check this case
               if(data![index].type=="video_resource"){
                 Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
                     arguments: {
                       'type': 'video_resource',
                       'videoId': data![index].serviceId,
                     });
               }
               else if(data![index].type=="video_part"){
                 Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
                     arguments: {
                       'type': 'video_part',
                       'videoId': data![index].serviceId,
                     });

               }
               //couldn't check this case
               else if(data![index].type=="video_basic"){
                 Navigator.pushNamed(context, Routes.videoDetailsScreenRoute,
                     arguments: {
                       'type': 'video_basic',
                       'videoId': data![index].serviceId,
                     });
               }
               //couldn't check this case
               else if(data![index].type=="all_exam"){
                 Navigator.pushNamed(context, Routes.examInstructionsRoute,
                     arguments: [data![index].serviceId,"all_exam"]);
               }
               //couldn't check this case
               else if(data![index].type=="video_part_exam"){
                 Navigator.pushNamed(context, Routes.examInstructionsRoute,
                     arguments: [data![index].serviceId,"video"]);
               }
               //couldn't check this case
               else if(data![index].type=="lesson_exam"){
                 Navigator.pushNamed(context, Routes.examInstructionsRoute,
                     arguments: [data![index].serviceId,"lesson"]);
               }
               //couldn't check this case
               else if(data![index].type=="subject_class_exam"){
                 Navigator.pushNamed(context, Routes.examInstructionsRoute,
                     arguments: [data![index].serviceId,"online_exam"]);
               }
               else if(data![index].type=="papel_sheet_exam"){
               await  context.read<NavigationCubit>().getTimes(context);

               }
               else if(data![index].type=="text"){
               showDialog(context: context, builder:(context) {
                 return AlertDialog(
                   title:
                   Center(child: Text("${data![index].title}")),
                   content: Text("${data![index].body}"),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                   actions: [TextButton(
                       onPressed: () {
                     Navigator.pop(context);
                   }, child: Text("close".tr(),))],

                 );
               },);
               }


            //   updateNotification = r ;
             });
  }
}
