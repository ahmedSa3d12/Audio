import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/features/monthplan/cubit/monthplan_state.dart';

import '../../../../core/models/ads_model.dart';
import '../../../../core/remote/service.dart';


class MonthPlanCubit extends Cubit<MonthPlanState> {
  MonthPlanCubit(this.api) : super(MonthPlanInitial()) {
     // getAdsOfApp();
  }

  final ServiceApi api;
  List<AdsModelDatum> adsList = [];
  LifeExam lifeExam=LifeExam();

  Future<void> getAdsOfApp() async {
    emit(MonthPlanLoading());
    final response = await api.getAppAds();
    response.fold(
      (error) => emit(MonthPlanError()),
      (res) {
        adsList = res.data!.ads!;
        lifeExam=res.data!.lifeExam!;
        print("ddd");
        print(res.data!.lifeExam!.timeEnd);
        emit(MonthPlanLoaded());
      },
    );
  }
}
