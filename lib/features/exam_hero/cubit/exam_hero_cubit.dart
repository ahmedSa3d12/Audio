import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:new_mazoon/core/remote/service.dart';

import '../../../core/models/exam_hero.dart';
import 'exam_hero_state.dart';

class ExamHeroCubit extends Cubit<ExamHeroState> {
  ExamHeroCubit(this.api) : super(ExamHeroInitial());
  ServiceApi api;
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ExamHeroChangeCurrentIndexTap());
  }

  //get
  ExamHerosModelData? allData;
  List<ExamHerosModelAuth> currentMonthHeroes = [];
  List<ExamHerosModelAuth> lastMonthHeroes = [];
  List<ExamHerosModelAuth> switchList = [];
  List<ExamHerosModelAuth> weekHeroes = [];
  List<ExamHerosModelAuth> dayHeroes = [];

  getExamHero() async {
    emit(LoadingGetExamHeros());
    final response = await api.getExamHero();
    response.fold((l) => emit(ErrorGetExamHeros()), (r) {
      allData = r.data;
      currentMonthHeroes = r.data.currentMonthHeroes;
      lastMonthHeroes = r.data.lastMonthHeroes;
      weekHeroes = r.data.weekHeroes;
      switchList = r.data.currentMonthHeroes;
      dayHeroes = r.data.dayHeroes;
      emit(LoadedGetExamHeros());
    });
  }

  switchCurrentAndLast(String value) {
    if (value == 'current_month'.tr()) {
      num = 2;
      currentMonthHeroes = switchList;
    } else {
      currentMonthHeroes = lastMonthHeroes;
      num = 3;
    }
    emit(ExamHeroChangeCurrentMonthTap());
  }

  int num = 0;
}
