import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:new_mazoon/core/models/month_plan_model.dart';
import 'package:new_mazoon/features/monthplan/cubit/monthplan_state.dart';

import '../../../../core/remote/service.dart';

class MonthPlanCubit extends Cubit<MonthPlanState> {
  List<MothData> monthplanList = [];

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime datefoucse = DateTime.now();
  DateTime datecurrent = DateTime.now();

  MonthPlanCubit(this.api) : super(MonthPlanInitial()) {
    // getAdsOfApp();
  }

  final ServiceApi api;

  Future<void> getMonthPlan(
      String date, DateTime dateFoucse, DateTime dateCurrent) async {
    this.date = date;
    this.datefoucse = dateFoucse;
    this.datecurrent = dateCurrent;
    emit(MonthPlanLoading());
    final response = await api.getMonthPlans(date);
    response.fold(
      (error) => emit(MonthPlanError()),
      (res) {
        if (res.data != null) {
          monthplanList = res.data!;
        } else {
          monthplanList = [];
        }
        emit(MonthPlanLoaded());
      },
    );
  }
}
